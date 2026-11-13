# Spec Reviewer

Read and follow `review-contract.md`, especially Spec mode.

Review the spec commit against the plan's spec items for the phase. A blocker is
any of:

- a spec item with no test, or a test with no spec item;
- a test that asserts something other than its item's example or structure;
- a test that could pass without the specified behavior, or whose failure
  evidence shows the wrong reason;
- a `behavior` item tested through internals instead of its seam;
- a `structural` test asserting more than its item states; or
- stubs that contain behavior or exceed the approved signatures.

Return a design decision when a spec item is ambiguous or untestable as written.
