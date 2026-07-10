# Architecture — Leads Tracker

## Stack
- **Frontend**: Next.js 14 (App Router, React Server Components)
- **Database**: Supabase (Postgres + RLS)
- **Hosting**: Vercel (auto-deploy from main branch)
- **AI**: OpenAI GPT-4o (follow-up draft generation, Sprint 3+)

## What's Built Now vs Later

**Now**: Lead CRUD → rule-based scoring → pipeline view (no auth)
**Next**: Activity log, GPT draft generation, filters/sort
**Later**: Auth + RLS lock-down, email send, CSV import, team roles

## Key User Action — End-to-End Flow
1. Visitor hits `/` → Next.js fetches leads from Supabase (server component)
2. Leads render in pipeline table with score badges — no login needed
3. User clicks **Add Lead** → form modal opens
4. Form submits → Next.js Server Action calls Supabase insert
5. Score is computed server-side (rule engine: value + source + stage → 0–100)
6. Score + `score_source='rule_engine_v1'` + `score_confidence` stored on the row
7. Page revalidates → updated list reflects new lead instantly
8. Every write appends a row to `audit_logs`

## Layer Order
1. **Database** — tables, constraints, RLS policies (source of truth)
2. **Server Actions** — CRUD + scoring logic (runs without AI)
3. **UI Components** — list, form, pipeline header, score badge
4. **Intelligence** — score first rule-based; GPT draft added in Sprint 3

## Core Runs Without AI
If OpenAI is unavailable, leads still load, scores still compute (rule-based), CRUD still works. AI only enhances the draft-copy field.
