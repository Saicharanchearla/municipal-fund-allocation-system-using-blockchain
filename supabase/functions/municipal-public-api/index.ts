import { createClient } from "npm:@supabase/supabase-js@2.95.0";

const projectUrl = Deno.env.get("SUPABASE_URL") ?? "";
const secretKeys = JSON.parse(Deno.env.get("SUPABASE_SECRET_KEYS") ?? "{}");
const serverKey =
  secretKeys.default ??
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ??
  Deno.env.get("SUPABASE_SERVICE_KEY") ??
  "";
const publishableKeys = JSON.parse(Deno.env.get("SUPABASE_PUBLISHABLE_KEYS") ?? "{}");
const allowedApiKeys = new Set([
  ...Object.values(publishableKeys),
  Deno.env.get("SUPABASE_ANON_KEY") ?? "",
].filter((key): key is string => typeof key === "string" && key.length > 0));

if (!projectUrl || !serverKey) {
  throw new Error("Supabase server credentials are not available to this function.");
}

const db = createClient(projectUrl, serverKey, {
  auth: { persistSession: false, autoRefreshToken: false },
});

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "apikey, authorization, content-type, x-client-info",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Vary": "Origin",
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json; charset=utf-8" },
  });
}

function mapProject(row: Record<string, unknown>) {
  const totalBudget = Number(row.total_budget ?? 0);
  const allocatedAmount = Number(row.allocated_amount ?? 0);
  const spentAmount = Number(row.spent_amount ?? 0);
  return {
    id: Number(row.id),
    projectCode: row.project_code,
    projectName: row.project_name,
    description: row.description,
    category: row.category,
    location: row.location,
    wardNumber: row.ward_number,
    governmentDepartment: row.government_department,
    contractorName: row.contractor_name,
    contractorGstin: row.contractor_gstin,
    tenderReference: row.tender_reference,
    workOrderNumber: row.work_order_number,
    publicContact: row.public_contact,
    totalBudget,
    allocatedAmount,
    spentAmount,
    remainingAmount: allocatedAmount - spentAmount,
    progress: Number(row.progress ?? 0),
    status: row.status,
    startDate: row.start_date,
    expectedEndDate: row.expected_end_date,
  };
}

function mapMaterial(row: Record<string, unknown>) {
  return {
    id: Number(row.id),
    materialName: row.material_name,
    specification: row.specification,
    unit: row.unit,
    plannedQuantity: Number(row.planned_quantity ?? 0),
    usedQuantity: Number(row.used_quantity ?? 0),
    unitRate: Number(row.unit_rate ?? 0),
    vendorName: row.vendor_name,
    qualityStatus: row.quality_status,
  };
}

function mapTransaction(row: Record<string, unknown>) {
  return {
    id: Number(row.id),
    transactionCode: row.transaction_code,
    amount: Number(row.amount ?? 0),
    description: row.description,
    vendor: row.vendor,
    status: row.status,
    timestamp: row.occurred_at,
    blockchainHash: row.blockchain_hash,
    riskLevel: row.risk_level,
    riskScore: Number(row.risk_score ?? 0),
  };
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  const apiKey = req.headers.get("apikey") ?? "";
  if (!allowedApiKeys.has(apiKey)) return json({ error: "Invalid API key" }, 401);

  const marker = "/functions/v1/municipal-public-api";
  const pathname = new URL(req.url).pathname;
  const route = pathname.includes(marker)
    ? pathname.slice(pathname.indexOf(marker) + marker.length).replace(/^\/+|\/+$/g, "")
    : pathname.replace(/^\/+|\/+$/g, "");

  try {
    if (req.method === "GET" && route === "health") {
      return json({ ok: true, service: "municipal-supabase-public-api" });
    }

    if (req.method === "GET" && route === "projects") {
      const { data, error } = await db
        .from("projects")
        .select("*")
        .not("project_code", "is", null)
        .order("id", { ascending: true });
      if (error) throw error;
      return json((data ?? []).map(mapProject));
    }

    const projectRoute = route.match(/^projects\/(\d+)$/);
    if (req.method === "GET" && projectRoute) {
      const projectId = Number(projectRoute[1]);
      const { data: project, error: projectError } = await db
        .from("projects")
        .select("*")
        .eq("id", projectId)
        .maybeSingle();
      if (projectError) throw projectError;
      if (!project) return json({ error: "Project not found" }, 404);

      const [materialsResult, transactionsResult] = await Promise.all([
        db.from("project_materials").select("*").eq("project_id", projectId).order("id"),
        db.from("fund_transactions").select("*")
          .eq("project_id", projectId)
          .eq("status", "APPROVED")
          .order("occurred_at", { ascending: false })
          .limit(100),
      ]);
      if (materialsResult.error) throw materialsResult.error;
      if (transactionsResult.error) throw transactionsResult.error;

      return json({
        ...mapProject(project),
        materials: (materialsResult.data ?? []).map(mapMaterial),
        transactions: (transactionsResult.data ?? []).map(mapTransaction),
      });
    }

    if (req.method === "POST" && route === "feedback") {
      const contentLength = Number(req.headers.get("content-length") ?? 0);
      if (contentLength > 4096) return json({ error: "Feedback is too large" }, 413);
      const body = await req.json();
      const projectId = Number(body.projectId);
      const message = typeof body.message === "string" ? body.message.trim() : "";
      if (!Number.isSafeInteger(projectId) || projectId < 1 || !message || message.length > 2000) {
        return json({ error: "A project and feedback message of up to 2,000 characters are required" }, 400);
      }

      const { data, error } = await db.from("citizen_feedback").insert({
        project_id: projectId,
        citizen_name: typeof body.citizenName === "string" ? body.citizenName.trim().slice(0, 120) : null,
        message,
        category: typeof body.category === "string" ? body.category.slice(0, 40) : "OTHER",
      }).select("id").single();
      if (error) throw error;
      return json({ id: data.id }, 201);
    }

    return json({ error: "Route not found" }, 404);
  } catch (error) {
    console.error("Municipal public API error:", error);
    return json({ error: "The municipal data service is temporarily unavailable" }, 500);
  }
});

