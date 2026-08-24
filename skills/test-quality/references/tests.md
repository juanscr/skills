# Good and Bad Tests

## Good tests

Test observable behavior through real public interfaces:

```typescript
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

Good tests:

- verify behavior callers care about;
- use a public API;
- survive internal refactoring;
- describe what happens, not how it happens; and
- keep each test focused on one logical behavior.

## Implementation-detail tests

Do not test private methods or internal collaboration:

```typescript
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

This test can fail when internals are refactored even if checkout behavior is
unchanged.

Verify through the public interface rather than a side channel:

```typescript
// Bad: bypasses the application interface.
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// Good: observes the capability through its interface.
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```

## Tautological tests

Do not calculate the expected result with the same logic as the implementation:

```typescript
// Bad: the expectation repeats the algorithm.
test("calculateTotal sums line items", () => {
  const items = [{ price: 10 }, { price: 5 }];
  const expected = items.reduce((sum, item) => sum + item.price, 0);
  expect(calculateTotal(items)).toBe(expected);
});

// Good: the expected value is independently known.
test("calculateTotal sums line items", () => {
  expect(calculateTotal([{ price: 10 }, { price: 5 }])).toBe(15);
});
```
