# Data Model — Leads Tracker

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner (set at lock-down sprint) |
| created_at | timestamptz | default now() |
| first_name | text NOT NULL | |
| last_name | text NOT NULL | |
| email | text | |
| phone | text | |
| company | text | |
| title | text | |
| source | text | LinkedIn / Referral / Inbound / Conference / Cold Outbound |
| stage | text NOT NULL | new / contacted / qualified / proposal / closed_won / closed_lost |
| deal_value | numeric | USD |
| notes | text | |
| score | numeric | **AI field** — 0–100 |
| score_source | text | e.g. `rule_engine_v1` |
| score_confidence | numeric | 0.0–1.0 |
| score_review_status | text | `unreviewed` / `approved` / `overridden` |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| lead_id | uuid FK → leads.id | cascade delete |
| activity_type | text | note / call / email |
| body | text NOT NULL | |
| draft_source | text | **AI field** — e.g. `gpt-4o` |
| draft_confidence | numeric | |
| draft_review_status | text | `unreviewed` / `approved` / `sent` |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| table_name | text | which table was touched |
| record_id | uuid | which row |
| action | text | insert / update / delete |
| old_data | jsonb | previous state |
| new_data | jsonb | new state |

## RLS
All tables: v1 open policies (select + all using `true`). Replaced with `auth.uid() = user_id` at lock-down sprint.
