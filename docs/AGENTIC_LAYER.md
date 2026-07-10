# Agentic Layer — Leads Tracker

## Risk Levels & Actions

### Low — Auto-execute (no approval needed)
- Compute lead score on save (`score_lead` tool)
- Tag lead source from notes (`tag_source` tool) — Sprint 3+

### Medium — Draft shown, human approves before write
- Generate follow-up email draft (`draft_followup` tool via GPT-4o)
- Update lead stage based on activity pattern (`suggest_stage_change` tool)

### High — Always requires explicit approval
- Send email to lead (`send_email` tool — Sprint 4+)

### Critical — Human-only, never automated
- Permanently delete a lead or bulk wipe
- Any action touching billing or auth

## Named Tools (approved list)
| Tool | Risk | v1? |
|---|---|---|
| `score_lead` | Low | ✅ |
| `draft_followup` | Medium | Sprint 3 |
| `suggest_stage_change` | Medium | Sprint 3 |
| `send_email` | High | Later |

## Audit Log Fields (every action)
`table_name`, `record_id`, `action`, `old_data`, `new_data`, `user_id`, `created_at`

## Agent Permission Rule
Agent inherits the current user's RLS permissions. It cannot escalate beyond what the user can do. No raw `run_any` or `send_any` calls permitted.
