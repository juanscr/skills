---
name: test-quality
description: Write or evaluate behavior-focused tests with reliable assertions and boundary-aware mocking. Use whenever creating, changing, or reviewing tests; this does not require a TDD workflow.
---

# Test Quality

Use these references whenever tests are written, changed, or reviewed:

- [Good and bad tests](references/tests.md)
- [Mocking](references/mocking.md)

Tests should prove observable behavior through public interfaces and survive
internal refactoring. Expected values must come from an independent source of
truth: an approved example, known literal, protocol contract, or another fact
outside the code under test.

Mock only true system boundaries. Prefer real controlled collaborators owned by
the codebase, and treat difficulty testing a public behavior without internal
mocks as design pressure rather than a reason to couple the test to internals.
