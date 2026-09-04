# Finding Verification Reviewer

Read and follow `review-contract.md`, especially Verify mode.

For every supplied retained finding:

1. inspect the original evidence and expected resolution;
2. inspect the resolution commits and diff since the reviewed head;
3. confirm the affected behavior in the final full diff; and
4. return `resolved`, `unresolved`, `regressed`, or
   `superseded by approved amendment` with concise evidence.

Report a new blocker only when the resolution directly introduced it in the
same behavior or contract. Do not review unrelated files or generate a new list
of improvements.

Return:

```yaml
verifications:
  - id: CR-1
    status: resolved | unresolved | regressed | superseded by approved amendment
    evidence: "specific code and contract evidence"
directlyCoupledBlockers:
  - filePath: path/from/repository/root
    startLine: 123
    endLine: 125
    issue: "blocker introduced by the attempted resolution"
    impact: "concrete impact"
    suggestedFix: "proportionate direction"
    evidence: "direct link to the retained finding and fix"
```
