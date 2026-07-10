# PRD — Leads Tracker

## Problem
Sales reps lose track of prospects across spreadsheets and sticky notes. Recruiters need proof a builder can ship a real, working full-stack app.

## Target User
A portfolio visitor (recruiter / hiring manager) who opens the live URL and immediately sees a working sales lead pipeline — and the builder themselves as the primary sales user.

## Core Objects
- **Lead** — the person/company being pursued (contact info, company, stage, value, source, AI score)
- **Activity** — a logged touchpoint on a lead (note, call, email, draft)
- **Audit Log** — every meaningful write action recorded server-side

## MVP Must-Haves (v1 checklist)
- [ ] Lead list visible immediately — no login wall — seeded demo data shows on first load
- [ ] Add a lead via form → persists to DB → appears in list
- [ ] Edit a lead → changes persist → UI updates
- [ ] Delete a lead → confirmation → removed from DB
- [ ] Rule-based lead score displayed on every lead (value + source + stage)
- [ ] Pipeline stage counts visible in header
- [ ] Loading, empty, and error states handled on list page
- [ ] Deployed to Vercel with live Supabase backend

## Non-Goals (v1)
- User login / signup
- Per-user data isolation
- Email sending
- CSV import
- Team / multi-user features
- Mobile-native app

## Success Criteria
A recruiter opens the live URL, sees 5 real-looking leads with scores and stages, adds a new lead "Acme Corp / $30k / Inbound", watches it appear in the pipeline with a score, edits the stage to _Proposal_, and sees the change reflected — all in under 30 seconds, zero login required.
