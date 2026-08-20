# Grilling Protocol

Use `grilling` twice for each design artifact: first to make decisions, then to
prove and deepen understanding.

## Discovery grilling

Model the work as a design tree. A question is on the current frontier only
when all facts and decisions it depends on are settled.

For each round:

1. Ask the whole current frontier.
2. Number the questions.
3. Explain why each decision matters.
4. Give a recommended answer and its rationale.
5. Present material alternatives without manufacturing false choices.
6. Wait for the user's answers before recomputing the frontier.

Research a factual prerequisite yourself. If independent research is still in
progress, leave only its dependent branch off the frontier and ask the other
ready questions.

Record the user's decisions and accepted assumptions in the relevant artifact.
Do not convert the recommendation into a decision unless the user accepts it.

Discovery is complete only when the frontier is empty and the user approves a
shared-understanding summary.

## Final comprehension grilling

After the user reviews an overview or phase spec, test understanding with
active recall. Do not initially provide suggested answers or multiple-choice
prompts.

Ask the user to:

- trace the happy path from entry point to observable result;
- trace important failure and alternate paths;
- explain who owns each material object or state and its lifecycle;
- defend the chosen design against the strongest alternative;
- explain phase boundaries and dependency order;
- predict important edge-case behavior; and
- connect acceptance criteria to verification.

This is a teaching loop, not a scored exam. When an answer exposes uncertainty:

1. identify the exact weak concept;
2. explain it in plain English using repository evidence;
3. improve the artifact so it does not rely on missing context; and
4. retry that part of the grill.

Do not store quiz scores or a transcript. Record the clarifications that changed
the artifact and the user's explicit approval after they can explain the design
end to end.

