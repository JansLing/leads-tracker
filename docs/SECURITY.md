# Security — Leads Tracker

## Secret Handling
- `SUPABASE_SERVICE_ROLE_KEY` and `OPENAI_API_KEY` live only in Vercel server-side env vars
- Only `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` exposed to the browser — anon key is safe with RLS enabled
- Never log secrets; never commit `.env` files

## Permission Model (v1 → lock-down)
- **v1**: Open RLS policies — demo works for anyone; no sensitive data in seed rows
- **Lock-down sprint**: Replace all `using (true)` policies with `auth.uid() = user_id`; add signup/login
- Agent actions run with the calling user's Supabase session — no privilege escalation

## Approved Tools Rule
- Only named tools in `AGENTIC_LAYER.md` may be invoked by automation
- No `eval`, no `run_any`, no `send_any` wrappers
- Every tool call that mutates data writes a row to `audit_logs`

## Audit Principle
- Every insert, update, and delete on `leads` and `activities` appends to `audit_logs` via a Server Action wrapper — not optional, not bypassable from the UI
- `audit_logs` is append-only; no delete policy exists on that table in any sprint

## Pre-Launch Checklist
- [ ] No secret keys in `git log` or browser Network tab
- [ ] RLS enabled on every table (confirmed in Supabase dashboard)
- [ ] Lock-down sprint completed before sharing with real prospects
