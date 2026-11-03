-- Seed the same 12 public records used by the project's static showcase.
-- Run after schema.sql. The insert is idempotent for projects and transaction rows.
insert into public.projects (id,project_code,project_name,description,category,location,ward_number,government_department,contractor_name,contractor_gstin,tender_reference,work_order_number,public_contact,total_budget,allocated_amount,spent_amount,progress,status,start_date,expected_end_date) values
(1,'MUN-2026-0001','Warangal Smart Road Corridor','Upgrading the Hanamkonda–Kazipet corridor with road resurfacing, junction safety measures and storm-water improvements.','Infrastructure','Hanamkonda to Kazipet Road, Warangal','Ward 6–12','GWMC Engineering Department','Telangana Infra Works Pvt. Ltd.','36AAECT4921L1ZW','WGL/RD/2026/001','WO-WGL-2026-001','1800-425-1989',135000000,80000000,45000000,58,'ACTIVE','2026-04-15','2027-02-28'),
(2,'MUN-2026-0002','Smart LED Street Lighting Programme','Energy-efficient LED luminaires, feeder pillars and smart controls for priority urban streets.','Utilities','Subedari, Hanamkonda','Ward 18–23','GWMC Electrical Wing','Deccan Lighting Systems LLP','36AAHFD7712K1ZP','WGL/ELC/2026/006','WO-WGL-2026-006','1800-425-1989',90500000,60000000,30500000,72,'ACTIVE','2026-05-20','2026-12-20'),
(3,'MUN-2026-0003','Kazipet Water Supply Improvement','Pipeline replacement, valve upgrades and reservoir-linked distribution strengthening in Kazipet.','Water Supply','Kazipet Municipal Zone','Ward 35–40','GWMC Water Supply Department','Godavari Water Projects Ltd.','36AACCG1864G1ZQ','WGL/WTR/2026/011','WO-WGL-2026-011','1800-425-1989',150000000,110000000,52000000,35,'ACTIVE','2026-06-10','2027-06-30'),
(4,'MUN-2026-0004','Public Park & Open Space Renewal','Renewal of open space with inclusive paths, play equipment, landscaping and community amenities.','Parks','Kakatiya Colony, Warangal','Ward 14–17','GWMC Urban Greens Division','Greenfield Urban Spaces Pvt. Ltd.','36AAHCG4208F1ZT','WGL/PKS/2026/014','WO-WGL-2026-014','1800-425-1989',80000000,65000000,57500000,90,'ON_HOLD','2026-03-01','2026-11-15'),
(5,'MUN-2026-0005','Narsampet Drainage Resilience Works','Construction of reinforced concrete storm-water drains and culverts for flood-resilient neighbourhoods.','Drainage','Narsampet Main Road','Ward 31–34','GWMC Engineering Department','Kakatiya Civil Engineering Co.','36AAEFK2819N1ZR','WGL/DRN/2026/019','WO-WGL-2026-019','1800-425-1989',120000000,85000000,18500000,20,'PLANNING','2026-07-29','2027-04-05'),
(6,'MUN-2026-0006','Warangal Urban Health Centre Modernisation','Ward health-centre renovation with diagnostics facilities, accessible circulation and solar backup.','Public Health','MGM Hospital Road, Warangal','Ward 11','GWMC Public Health Department','Arogya Buildcon India Pvt. Ltd.','36AAMCA7781D1ZX','WGL/HLT/2026/026','WO-WGL-2026-026','1800-425-1989',98000000,72000000,41800000,54,'ACTIVE','2026-05-12','2027-01-10'),
(7,'MUN-2026-0007','Bhadrakali Lakefront Safety Improvements','Lakefront walkway rehabilitation, retaining barriers, railings and safety lighting.','Public Space','Bhadrakali Lake Road, Warangal','Ward 3–4','GWMC Urban Planning Department','Heritage Waterscape Contractors Ltd.','36AABCH6502P1Z8','WGL/LKF/2026/029','WO-WGL-2026-029','1800-425-1989',115000000,90000000,62100000,66,'ACTIVE','2026-04-20','2027-02-20'),
(8,'MUN-2026-0008','Hanamkonda Municipal Market Upgrade','Market fire-safety rehabilitation, roofing replacement, drainage and vendor amenities.','Markets & Commerce','Hanamkonda Public Market','Ward 16','GWMC Markets Department','Sri Balaji Civic Projects LLP','36ABDFS9204G1ZQ','WGL/MKT/2026/033','WO-WGL-2026-033','1800-425-1989',87000000,68000000,27000000,39,'ACTIVE','2026-07-01','2027-05-30'),
(9,'MUN-2026-0009','Kazipet Solid Waste Transfer Station','Material recovery shed, weighbridge, compactors and leachate collection works.','Solid Waste','Madikonda Road, Kazipet','Ward 28','GWMC Sanitation Department','EcoCycle Municipal Services Ltd.','36AABCE8117R1ZL','WGL/SWM/2026/037','WO-WGL-2026-037','1800-425-1989',142000000,108000000,70500000,63,'ACTIVE','2026-03-18','2027-01-28'),
(10,'MUN-2026-0010','Fort Warangal Heritage Access Works','Stone pathway conservation, visitor amenities, signage and universal access improvements.','Heritage Infrastructure','Warangal Fort, Khila Warangal','Ward 25','GWMC Heritage Cell','Kakatiya Heritage Works Pvt. Ltd.','36AAGCK4419C1Z7','WGL/HER/2026/041','WO-WGL-2026-041','1800-425-1989',76000000,54000000,19800000,31,'ACTIVE','2026-08-15','2027-08-10'),
(11,'MUN-2026-0011','Vaddepally Community Sports Complex','Multi-use sports surface, spectator seating, drainage and energy-efficient lighting.','Sports & Community','Vaddepally, Hanamkonda','Ward 21','GWMC Community Development Department','Vihari Sports Infrastructure Ltd.','36AABCV1288M1ZG','WGL/SPT/2026/044','WO-WGL-2026-044','1800-425-1989',94000000,70000000,45500000,57,'ACTIVE','2026-04-02','2027-03-22'),
(12,'MUN-2026-0012','Reddy Colony Road Safety Junctions','Junction redesign, pedestrian crossings, signals, bus bays and universal-access kerbs.','Road Safety','Reddy Colony, Hanamkonda','Ward 9','GWMC Traffic Engineering Cell','SafeRoute Engineering Services Pvt. Ltd.','36AAKCS2335Q1ZV','WGL/RDS/2026/048','WO-WGL-2026-048','1800-425-1989',69000000,50000000,12500000,24,'PLANNING','2026-09-10','2027-07-15')
on conflict (project_code) do nothing;

insert into public.project_materials (project_id,material_name,specification,unit,planned_quantity,used_quantity,vendor_name,quality_status) values
(1,'Bituminous Concrete','VG-30 asphalt mix','tonne',8400,4900,'Telangana Infra Works Pvt. Ltd.','VERIFIED'),
(1,'Ready Mix Concrete','M30 grade','m³',5200,2700,'Warangal Concrete Depot','VERIFIED'),
(1,'Road Marking Paint','Thermoplastic reflective','kg',12000,6100,'Deccan Safety Systems','VERIFIED'),
(2,'LED Street Luminaire','120 W IP66 smart-ready','nos',2100,1510,'Deccan Lighting Systems LLP','VERIFIED'),
(2,'GI Octagonal Pole','9 metre hot dip galvanised','nos',860,620,'Telangana Steel Fabricators','VERIFIED'),
(2,'XLPE Cable','4-core 16 sq mm','metre',42000,28800,'Hanamkonda Electrical Stores','VERIFIED'),
(3,'DI Pipe','K9 class, 300 mm','metre',18000,6300,'Godavari Water Projects Ltd.','VERIFIED'),
(3,'Sluice Valve','PN 1.6, 300 mm','nos',95,34,'Hyderabad Valve Works','VERIFIED'),
(3,'River Sand','Washed bedding sand','m³',9800,3500,'Kazipet Aggregates','VERIFIED'),
(4,'Paver Block','60 mm zig-zag concrete','m²',18000,16400,'Greenfield Urban Spaces Pvt. Ltd.','VERIFIED'),
(4,'Play Equipment','ISI certified children equipment','sets',42,38,'PlayScape India','VERIFIED'),
(4,'Planting Saplings','Native shade species','nos',1200,1090,'GWMC Nursery','VERIFIED'),
(5,'RCC Precast Drain','900 mm U-drain section','metre',6000,1100,'Kakatiya Civil Engineering Co.','VERIFIED'),
(5,'Reinforcement Steel','Fe 500D TMT bars','MT',430,75,'Warangal Steel Traders','VERIFIED'),
(5,'Cement','OPC 53 grade','Bags',18000,3100,'Telangana Cement Depot','VERIFIED'),
(6,'AAC Block','Autoclaved aerated concrete','nos',78000,43000,'Arogya Buildcon India Pvt. Ltd.','VERIFIED'),
(6,'Hospital Vinyl Flooring','Antibacterial homogeneous vinyl','m²',4200,2200,'MedFloor Systems','VERIFIED'),
(6,'Solar Inverter','25 kW hybrid inverter','nos',4,2,'Surya Power Solutions','VERIFIED'),
(7,'Granite Paving','Flamed-finish heritage granite','m²',8600,5400,'Heritage Waterscape Contractors Ltd.','VERIFIED'),
(7,'Safety Railing','Grade 304 stainless steel','metre',4400,2800,'Kakatiya Steel Works','VERIFIED'),
(7,'LED Bollard','30 W weatherproof light','nos',320,210,'Lumina Public Systems','VERIFIED'),
(8,'Roofing Sheet','0.50 mm colour-coated sheet','m²',16400,6400,'Sri Balaji Civic Projects LLP','VERIFIED'),
(8,'Fire Hydrant','Landing valve and hose reel','nos',56,21,'FireShield Telangana','VERIFIED'),
(8,'Anti-skid Tile','Commercial vitrified tile','m²',6200,2100,'Hanamkonda Tile House','VERIFIED'),
(9,'Waste Compactor','20 m³ hydraulic compactor','nos',4,3,'EcoCycle Municipal Services Ltd.','VERIFIED'),
(9,'Weighbridge','60 tonne electronic system','nos',1,1,'Metro Weigh Systems','VERIFIED'),
(9,'HDPE Liner','1.5 mm geomembrane','m²',18600,10700,'Green Barrier Polymers','VERIFIED'),
(10,'Sandstone Paver','Hand-dressed sandstone','m²',7200,2700,'Kakatiya Heritage Works Pvt. Ltd.','VERIFIED'),
(10,'Interpretation Signage','Bilingual weather-resistant','nos',58,24,'Deccan Signworks','VERIFIED'),
(10,'Tactile Tile','Yellow guiding tile','m²',1250,430,'Access India Products','VERIFIED'),
(11,'Synthetic Turf','FIFA-quality artificial turf','m²',8800,5100,'Vihari Sports Infrastructure Ltd.','VERIFIED'),
(11,'Sports Floodlight','150 W LED floodlight','nos',48,30,'Arena Lighting Works','VERIFIED'),
(11,'Precast Seating','RCC spectator bench','nos',420,240,'Hanamkonda Precast Industries','VERIFIED'),
(12,'Traffic Signal','Adaptive LED controller','nos',12,3,'SafeRoute Engineering Services Pvt. Ltd.','VERIFIED'),
(12,'Thermoplastic Marking','High-reflectivity compound','kg',8600,2100,'Road Safety India Ltd.','VERIFIED'),
(12,'Bus Shelter','Powder-coated steel shelter','nos',8,2,'Telangana Urban Furniture','VERIFIED');

-- Add 100 generated public ledger rows per project; each project's sample rows total its recorded spend.
with numbered as (
  select p.id as project_id, p.project_code, p.spent_amount, n,
         (0.7::numeric + ((n - 1) % 9)::numeric / 20) as weight,
         sum(0.7::numeric + ((n - 1) % 9)::numeric / 20) over (partition by p.id) as total_weight,
         coalesce(m.material_name, p.project_name) as material_name,
         p.contractor_name
  from public.projects p
  cross join generate_series(1,100) as n
  left join lateral (
    select pm.material_name from public.project_materials pm
    where pm.project_id = p.id order by pm.id offset ((n - 1) % 3) limit 1
  ) m on true
  where p.project_code like 'MUN-2026-%'
), amounts as (
  select *,
    floor(spent_amount * weight / total_weight)::bigint as amount_before_last,
    sum(floor(spent_amount * weight / total_weight)::bigint)
      filter (where n < 100) over (partition by project_id) as sum_before_last
  from numbered
)
insert into public.fund_transactions
  (project_id, transaction_code, amount, transaction_type, description, vendor, status,
   occurred_at, blockchain_hash, risk_level, risk_score)
select project_id,
       'TXN-' || lpad(project_id::text,4,'0') || '-' || lpad(n::text,4,'0'),
       case when n=100 then spent_amount-sum_before_last else amount_before_last end,
       'EXPENDITURE',
       material_name || ' supply / execution certificate ' || n,
       contractor_name,
       'APPROVED',
       now() - make_interval(days => (100-n)),
       'LOCAL-DEV-PROOF-' || md5(project_code || ':' || n::text),
       case when n % 13=0 then 'MEDIUM' else 'LOW' end,
       case when n % 13=0 then 38 else 12 end
from amounts
on conflict (transaction_code) do nothing;


