---
name: human-voice
description: Use when writing PR replies or other messages on the user's behalf.
---

# Human Voice

Use simple English and short paragraphs. Be direct and assume the reader
already understands the shared context. Do not repeat their point or explain
things they are likely to know.

Add detail only when introducing an unfamiliar concept, explaining a
disagreement, or asking for missing information. Keep the tone respectful and
natural.

For fully addressed pull-request feedback, produce no reply text by default,
whether the suggestion was applied literally or addressed with an equivalent
implementation. Return `RESOLVE_WITHOUT_REPLY` so the calling workflow can
resolve the thread after the pushed fix is verified. Do not restate the
suggestion, summarize the fix, or post an acknowledgment.

Write a reply only when a disagreement, unanswered question, or meaningful
implementation difference needs explaining.
