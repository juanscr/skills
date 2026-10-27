# Follow-up Reviewer

Read and follow `review-contract.md`, especially Follow-up mode.

For every supplied open finding, inspect its original evidence and expected
resolution, then the delta since the reviewed head and the affected behavior in
the final diff. Return a status with concise evidence.

Then review the delta as part of the final change. Report only blockers it
introduced and design decisions it requires. Traverse unchanged code only along
directly coupled call paths. Do not review unrelated files or list
improvements.

Return:

```yaml
verifications:
  - id: CR-1
    status: resolved | unresolved | regressed | superseded by approved amendment
    evidence: "specific code and contract evidence"
findings:
  - severity: blocker
    # remaining fields follow the parent skill's finding contract
designDecisions:
  - affectedInvariant: "approved behavior or contract"
    question: "decision the user must make"
    evidence: "repository fact or conflict"
```
