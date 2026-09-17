# Skill mechanics

The skill-specific branch of [`writing-for-agents`](SKILL.md): what changes when the document is a skill (frontmatter, the invocation choice, and router skills). Everything else about writing it is the universal reference in `SKILL.md`.

## Invocation

Every skill is **model-invocable**, so the harness can discover it and other
skills can reach it. Omit `disable-model-invocation` and write a model-facing
`description` carrying the trigger branches; the pointer-writing rules in
`SKILL.md` apply in full.

Model-invocable does not mean autonomously triggered. For a skill that should
run only by hand, make that boundary explicit in its description: "Use only
when the user explicitly invokes `<skill-name>`." The description remains
loaded so the model can discover the skill without mistaking availability for
permission to run it.

Shared reference needed by several skills can live in a model-invocable
reference skill. Use a plain disclosed-reference file instead when it is not an
independently invocable capability.

## Splitting by invocation

The invocation cut of splitting (the sequence cut lives in `SKILL.md`): split
off a skill when it has a distinct leading word that should trigger it on its
own, or another skill must reach it. Every split adds an always-loaded
description, so that independent reach has to earn its context load.
