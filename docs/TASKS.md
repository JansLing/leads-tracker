# Tasks — Leads Tracker

## Gantt Overview
```
Sprint 1 [DB + Core Engine]   ████████
Sprint 2 [Score + Polish]              ████████
Sprint 3 [Activity + AI Draft]                  ████████
Sprint 4 [Lock It Down]                                  ████████
```

---

## Sprint 1 — DB + Core Lead Engine
**Goal**: Any visitor opens the URL and sees leads, can add/edit/delete. Core engine works end-to-end.

- [ ] Run migration SQL (leads, activities, audit_logs + RLS v1 + seed data)
- [ ] Build `/` page: fetch leads server-side, render pipeline table
- [ ] Loading state (skeleton rows), empty state ("Add your first lead" CTA), error state (toast)
- [ ] Add Lead modal: all fields, submit → Supabase insert → revalidate list
- [ ] Edit Lead modal: pre-filled, submit → Supabase update → revalidate
- [ ] Delete Lead: confirmation dialog → Supabase delete → row disappears
- [ ] Every write appends to `audit_logs`
- [ ] Deploy to Vercel; confirm public URL works

**Definition of Done**: Open the public URL cold. Five demo leads appear. Add "Acme Corp $30k Inbound". See it in the list. Edit stage to Proposal. Delete it. All changes survive a hard refresh. No login prompt appeared.

---

## Sprint 2 — Lead Scoring + Polish ✦ v1 functional milestone
**Goal**: Scores computed and displayed; UI is recruiter-ready.

- [ ] Server-side `scoreLead()` function (value + source + stage weights → 0–100)
- [ ] Store `score`, `score_source`, `score_confidence`, `score_review_status` on save
- [ ] Score badge on every lead row (colour-coded: red/amber/green)
- [ ] Default sort: score descending
- [ ] Pipeline stage counts in page header
- [ ] Responsive layout; clean sans-serif typography; no placeholder copy
- [ ] Test: add lead → score appears; edit value → score updates

**Definition of Done**: Every lead shows a numeric score badge. Changing deal_value from $5k to $80k raises the score. UI looks polished on a 1440px screen and an iPhone 390px viewport.

---

## Sprint 3 — Activity Log + AI Follow-up Draft
**Goal**: Lead detail page with activity timeline and GPT-drafted follow-up.

- [ ] Lead detail page at `/leads/[id]`
- [ ] Add activity form (type: note / call / email, body text)
- [ ] Activity timeline (newest first)
- [ ] "Draft follow-up" button → calls GPT-4o server action → stores draft in `activities` with `draft_source`, `draft_confidence`, `draft_review_status='unreviewed'`
- [ ] Draft shown in editable textarea; user clicks "Approve" to mark `draft_review_status='approved'`
- [ ] If OpenAI unavailable: show error toast, no crash

**Definition of Done**: Open a lead detail page. Add a call note. Click "Draft follow-up". See a GPT-written email in an editable box. Approve it. Activity log shows both entries. Works if OpenAI key is removed (graceful error).

---

## Sprint 4 — Lock It Down (Auth + RLS)
**Goal**: Real users can own their data; demo still visible to anonymous visitors.

- [ ] Enable Supabase Auth (email/password)
- [ ] Login + signup pages at `/login`
- [ ] Replace open RLS policies with `auth.uid() = user_id` on leads + activities
- [ ] Seed demo rows retain `user_id = null` and remain publicly readable via a separate permissive read policy for null-owner rows
- [ ] Logged-in users see only their own leads
- [ ] Confirm no service role key in any client bundle
- [ ] Manual test: two different accounts cannot see each other's leads

**Definition of Done**: Create account A, add a lead. Log out. Create account B. Account B sees zero leads from account A. Anonymous visitor still sees the 5 seed demo leads.
