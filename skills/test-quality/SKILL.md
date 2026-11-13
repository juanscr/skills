---
name: test-quality
description: Use when creating, changing, or reviewing tests.
---

# Test Quality

Use these references whenever tests are written, changed, or reviewed:

- [Good and bad tests](references/tests.md)
- [Mocking](references/mocking.md)

Tests prove the approved contract and survive refactoring of everything else.
Usually the contract is observable behavior through public interfaces. When the
user approves structure as a requirement (schema, public types, module
boundaries), that structure is the contract; test it directly and nothing
beyond it. Expected values must come from an independent source of
truth: an approved example, known literal, protocol contract, or another fact
outside the code under test.

Mock only true system boundaries. Prefer real controlled collaborators owned by
the codebase, and treat difficulty testing a public behavior without internal
mocks as design pressure rather than a reason to couple the test to internals.
