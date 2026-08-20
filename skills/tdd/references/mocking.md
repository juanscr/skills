# When to Mock

Mock at system boundaries only:

- external APIs;
- databases when a real test database is impractical;
- time and randomness; and
- filesystems when a controlled real filesystem is impractical.

Do not mock:

- your own classes or modules;
- internal collaborators; or
- behavior the test can observe through a real public interface.

## Design boundary interfaces

Pass external dependencies in rather than constructing them inside domain
behavior:

```typescript
// Boundary dependency is explicit and replaceable.
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// Boundary dependency is hidden and difficult to control.
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

Prefer operation-specific boundary interfaces over one generic conditional
fetcher:

```typescript
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) =>
    fetch("/orders", { method: "POST", body: data }),
};
```

Each test double should represent one external operation and one response
shape. Avoid conditional mock logic that recreates the production client.

