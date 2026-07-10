# Test Plan — Leads Tracker

## v1 Success Scenario (manual, Sprint 1–2)
1. Open the public Vercel URL in an incognito window
2. **Expect**: Pipeline table loads with 5 demo leads, scores visible, no login prompt
3. Click **Add Lead** → fill: First=Jane, Last=Smith, Company=Acme Corp, Value=30000, Source=Referral, Stage=New
4. Submit → **Expect**: Jane Smith appears in list with a score badge (≥60 for Referral + $30k)
5. Click Edit on Jane Smith → change Stage to Proposal → Save
6. **Expect**: Stage updates in list immediately; score may increase
7. Click Delete on Jane Smith → confirm
8. **Expect**: Row gone; if list is now empty of non-seed leads, empty state does NOT show (seed rows remain)
9. Hard-refresh the page → **Expect**: All edits persisted; no data lost

## Empty State
- Delete all non-seed leads → list still shows seed rows (never truly empty in demo)
- If seed table is cleared manually: empty state "No leads yet — add your first" CTA is shown

## Error Cases
| Scenario | Expected behaviour |
|---|---|
| Submit Add Lead form with no first_name | Inline validation error, no DB call |
| Supabase unreachable | Error toast "Could not save lead — try again"; form stays open |
| Invalid lead ID in URL `/leads/bad-uuid` | 404 page with back link |
| OpenAI unavailable (Sprint 3) | "Draft unavailable" toast; no crash; existing activities unaffected |

## Score Spot-checks
| deal_value | source | stage | Expected score range |
|---|---|---|---|
| $5,000 | Cold Outbound | new | 25–30 |
| $30,000 | Referral | qualified | 75–85 |
| $80,000 | Referral | proposal | 90–100 |

## Audit Log Check
After add + edit + delete: query `audit_logs` in Supabase dashboard → confirm 3 rows with correct `action` values (`insert`, `update`, `delete`) and matching `record_id`.
