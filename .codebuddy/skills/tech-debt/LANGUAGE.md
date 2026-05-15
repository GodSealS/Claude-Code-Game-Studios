# Architecture Deepening Vocabulary

Shared vocabulary for architecture improvement suggestions. Use these terms exactly when proposing architecture changes.

## Terms

**Module**
Anything with an interface and an implementation. Scale-agnostic — applies equally to a function, class, package, or tier-spanning slice.
_Avoid_: unit, component, service.

**Interface**
Everything a caller must know to use the module correctly: type signature, invariants, ordering constraints, error modes, required configuration, and performance characteristics.
_Avoid_: API, signature (too narrow).

**Implementation**
What's inside a module — its body of code.

**Depth**
Leverage at the interface — the amount of behaviour a caller (or test) can exercise per unit of interface they need to learn. **Deep** = high leverage (simple interface, rich behaviour). **Shallow** = low leverage (interface nearly as complex as the implementation).

**Seam** _(from Michael Feathers)_
A place where you can alter behaviour without editing in that place. Where a module's interface lives.
_Avoid_: boundary (overloaded with DDD's bounded context).

**Adapter**
A concrete thing that satisfies an interface at a seam. Describes role, not substance.

**Leverage**
What callers get from depth. More capability per unit of interface they must learn.

**Locality**
What maintainers get from depth. Change, bugs, knowledge, and verification concentrate at one place rather than spreading across N callers.

## Principles

- **Depth is a property of the interface, not the implementation.** A module can have internal seams (private to its implementation) as well as external seams at its interface.
- **The deletion test.** Imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across N callers, it was earning its keep.
- **The interface is the test surface.** Callers and tests cross the same seam.
- **One adapter = hypothetical seam. Two adapters = real seam.** Don't introduce a seam unless something actually varies across it.
