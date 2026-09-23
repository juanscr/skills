---
name: model-selection
description: Select the proper model when delegating work to a child agent.
---

Prefer GPT models over Claude ones. Use GPT-6 Sol (High / Large context) for
most work, only use GPT-6 Luna models when the task is direct and no thinking
is required; if Luna is needed, use max reasoning and large context windows.
GPT-6 Astra should be used for research, solving big complex tasks, or
orchestrating agents.

When reviewing code:
1. GPT-6 Luna for reviewing simple things.
2. GPT-6 Sol the default for reviewing code.
3. GPT-6 Astra for skeptical or risky reviews.

Claude models are only approved for:
1. Creating visual artifacts in HTML (SVG, images, etc).
2. Reviewing / executing tasks that are pure frontend or HTML, as they have
   better visual artifact creation.

For those cases, use Claude 5.5 Opus on medium reasoning. Don't delegate
thinking to these models, only pure execution.
