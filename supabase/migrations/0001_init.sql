create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  first_name text not null,
  last_name text not null,
  email text,
  phone text,
  company text,
  title text,
  source text,
  stage text not null default 'new',
  deal_value numeric,
  notes text,
  score numeric,
  score_source text,
  score_confidence numeric,
  score_review_status text default 'unreviewed'
);

alter table leads enable row level security;

drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);

drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  lead_id uuid references leads(id) on delete cascade,
  activity_type text not null,
  body text not null,
  draft_source text,
  draft_confidence numeric,
  draft_review_status text default 'unreviewed'
);

alter table activities enable row level security;

drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);

drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  table_name text not null,
  record_id uuid,
  action text not null,
  old_data jsonb,
  new_data jsonb
);

alter table audit_logs enable row level security;

drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);

drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into leads (first_name, last_name, email, company, title, source, stage, deal_value, notes, score, score_source, score_confidence, score_review_status) values
  ('Sarah', 'Chen', 'sarah.chen@meridiantech.com', 'Meridian Tech', 'VP of Engineering', 'LinkedIn', 'qualified', 42000, 'Attended our webinar, asked about enterprise pricing.', 87, 'rule_engine_v1', 0.82, 'unreviewed'),
  ('James', 'Okafor', 'james.okafor@foundryco.io', 'Foundry Co', 'CEO', 'Referral', 'proposal', 95000, 'Warm intro from existing customer. High intent.', 94, 'rule_engine_v1', 0.91, 'unreviewed'),
  ('Priya', 'Nair', 'priya.nair@bluelake.com', 'BlueLake Systems', 'Director of Ops', 'Cold Outbound', 'new', 18000, 'Downloaded whitepaper. No reply yet.', 41, 'rule_engine_v1', 0.74, 'unreviewed'),
  ('Tom', 'Becker', 'tom.becker@apexretail.com', 'Apex Retail', 'Head of Sales', 'Conference', 'contacted', 27500, 'Met at SaaStr. Requested a demo next week.', 68, 'rule_engine_v1', 0.78, 'unreviewed'),
  ('Lena', 'Russo', 'lena.russo@novamedia.eu', 'Nova Media', 'CMO', 'Inbound', 'closed_won', 61000, 'Signed contract 2024-11-15. Upsell opportunity Q2.', 99, 'rule_engine_v1', 0.95, 'reviewed');