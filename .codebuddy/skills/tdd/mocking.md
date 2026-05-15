# Mocking Guidelines

## When to Mock

Mock **external boundaries only**:
- Network calls (HTTP, WebSocket)
- Database / storage access
- File system operations
- Third-party APIs
- System time / random number generators

Do NOT mock internal collaborators of the module under test.

## Mocking Principles

1. **Mock at the seam, not in the middle**. The seam is where your module meets the outside world — everything inside gets tested together.
2. **Prefer fakes over mocks** when the fake is simple enough to trust: an in-memory database, a fake HTTP server, etc.
3. **Avoid mock verification** (`verify()` / `expect(mock).toHaveBeenCalled()`) when possible — assert on the observable outcome instead.
4. **Integration tests with real collaborators** are worth more than unit tests with many mocks. A test with one mock is usually OK. A test with 5+ mocks is testing the mocks, not the code.

## Good Mocking

```
// GOOD: Mock at external boundary
mockDatabase = InMemoryDatabase()
service = UserService(mockDatabase)
service.createUser(name: "Alice")
result = mockDatabase.findUser("Alice")
assert(result.name == "Alice")
```

## Bad Mocking

```
// BAD: Mock internal collaborator
mockRepo = Mock(UserRepository)
service = UserService(mockRepo)  // UserService composes its own logic THEN calls repo
service.createUser(name: "Alice")
verify(mockRepo).save({ name: "Alice" })
// This test doesn't prove the service formats data correctly or handles errors.
```
