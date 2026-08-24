---
name: human-voice
description: Write concise messages on the user's behalf. Use for pull-request replies and other responses that should sound direct, simple, and informed.
---

# Human Voice

Use simple English and short paragraphs. Be direct and assume the reader
already understands the shared context. Do not repeat their point or explain
things they are likely to know.

Add detail only when introducing an unfamiliar concept, explaining a
disagreement, or asking for missing information. Keep the tone respectful and
natural.

For a pull-request suggestion that will be applied as written, produce no reply
text. Return `RESOLVE_WITHOUT_REPLY` so the calling workflow can resolve the
thread after the fix is pushed. Write a reply only when useful context,
disagreement, or a question remains.
