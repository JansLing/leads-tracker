# Intelligence Layer — Leads Tracker

## Messy Inputs
- Sales rep fills in: name, company, deal_value, source, stage, optional notes
- No standardised format; source values vary; deal_value sometimes missing

## Auto-Structure (score computation)
Rule engine runs server-side on every save:

```json
{
  "lead_id": "uuid",
  "inputs": {
    "deal_value": 42000,
    "source": "Referral",
    "stage": "qualified"
  },
  "weights": {
    "deal_value_bucket": 40,
    "source_quality": 35,
    "stage_progress": 25
  },
  "score": 87,
  "score_source": "rule_engine_v1",
  "score_confidence": 0.82,
  "score_review_status": "unreviewed"
}
```

## Scoring Rules (v1 — rule-based)
- **deal_value**: <$10k=10pts, $10–50k=25pts, >$50k=40pts
- **source**: Cold Outbound=10, Inbound=20, Conference=25, LinkedIn=28, Referral=35
- **stage**: new=5, contacted=10, qualified=15, proposal=20, closed_won=25

## Events Tracked
- Lead created, stage changed, score computed, activity logged

## What Gets Ranked
- Leads sorted by `score DESC` by default on list page

## v1 vs Later
- **v1**: Rule-based score, stored with source + confidence
- **Next**: GPT-4o draft follow-up email per lead (stored, editable, human-approved before any send)
- **Later**: ML re-scoring based on historical close rates
