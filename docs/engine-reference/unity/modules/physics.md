# Unity 6.3 — Physics Module Reference / Unity物理模块


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** Unity 6 physics improvements, solver changes

---

<!-- 概述 -->
## Overview

Unity 6.3 uses **PhysX 5.1** (improved from PhysX 4.x in 2022 LTS):
- Better solver stability
- Improved performance
- Enhanced collision detection

---

<!-- 自 2022 LTS 以来的关键变化 -->
## Key Changes from 2022 LTS

<!-- 中文翻译 -->
### Default Solver Iterations Increased
Unity 6 increased default solver iterations for better stability:

```csharp
// Default changed from 6 to 8 iterations
Physics.defaultSolverIterations = 8; // Check if relying on old behavior
```

<!-- 中文翻译 -->
### Enhanced Collision Detection

```csharp
// ✅ Unity 6: Improved Continuous Collision Detection (CCD)
rigidbody.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;
// Better handling of fast-moving objects
```

---

<!-- 中文翻译 -->
## Core Physics Components

<!-- 中文翻译 -->
### Rigidbody

```csharp
// ✅ Best practice: Use AddForce, not direct velocity writes
Rigidbody rb = GetComponent<Rigidbody>();
rb.AddForce(Vector3.forward * 10f, ForceMode.Impulse);

// ❌ Avoid: Direct velocity assignment (can cause instability)
rb.velocity = new Vector3(0, 10, 0); // Only use when necessary
```

<!-- 中文翻译 -->
### Colliders

```csharp
// Primitive colliders: Box, Sphere, Capsule (cheapest)
// Mesh colliders: Expensive, use only for static geometry

// ✅ Compound colliders (multiple primitives) > single mesh collider
```

---

<!-- 中文翻译 -->
## Raycasting

<!-- 中文翻译 -->
### Efficient Raycasting (Avoid Allocations)

```csharp
// ✅ Non-allocating raycast
if (Physics.Raycast(origin, direction, out RaycastHit hit, maxDistance)) {
    Debug.Log($"Hit: {hit.collider.name}");
}

// ✅ Multiple hits (non-allocating)
RaycastHit[] results = new RaycastHit[10];
int hitCount = Physics.RaycastNonAlloc(origin, direction, results, maxDistance);
for (int i = 0; i < hitCount; i++) {
    Debug.Log($"Hit {i}: {results[i].collider.name}");
}

// ❌ Avoid: RaycastAll (allocates array every call)
RaycastHit[] hits = Physics.RaycastAll(origin, direction); // GC allocation!
```

<!-- 中文翻译 -->
### LayerMask for Selective Raycasting

```csharp
// ✅ Use LayerMask to filter collisions
int layerMask = 1 << LayerMask.NameToLayer("Enemy");
Physics.Raycast(origin, direction, out RaycastHit hit, maxDistance, layerMask);
```

---

<!-- 中文翻译 -->
## Physics Queries

<!-- 中文翻译 -->
### OverlapSphere (Check for nearby objects)

```csharp
// ✅ Non-allocating version
Collider[] results = new Collider[10];
int count = Physics.OverlapSphereNonAlloc(center, radius, results);
for (int i = 0; i < count; i++) {
    // Process results[i]
}
```

<!-- 中文翻译 -->
### SphereCast (Thick raycast)

```csharp
// Useful for character controllers
if (Physics.SphereCast(origin, radius, direction, out RaycastHit hit, maxDistance)) {
    // Hit something with a sphere-shaped ray
}
```

---

<!-- 中文翻译 -->
## Collision Events

<!-- 中文翻译 -->
### OnCollisionEnter / Stay / Exit

```csharp
void OnCollisionEnter(Collision collision) {
    // Triggered when collision starts
    Debug.Log($"Collided with {collision.gameObject.name}");

    // Access contact points
    foreach (ContactPoint contact in collision.contacts) {
        Debug.DrawRay(contact.point, contact.normal, Color.red, 2f);
    }
}
```

<!-- 中文翻译 -->
### OnTriggerEnter / Stay / Exit

```csharp
void OnTriggerEnter(Collider other) {
    // Trigger collider (Is Trigger = true)
    if (other.CompareTag("Pickup")) {
        Destroy(other.gameObject);
    }
}
```

---

<!-- 中文翻译 -->
## Character Controllers

<!-- 中文翻译 -->
### CharacterController Component

```csharp
CharacterController controller = GetComponent<CharacterController>();

// ✅ Move with collision detection
Vector3 move = transform.forward * speed * Time.deltaTime;
controller.Move(move);

// Apply gravity manually
if (!controller.isGrounded) {
    velocity.y += Physics.gravity.y * Time.deltaTime;
}
controller.Move(velocity * Time.deltaTime);
```

---

<!-- 中文翻译 -->
## Physics Materials

<!-- 中文翻译 -->
### Friction & Bounciness

```csharp
// Create: Assets > Create > Physic Material
// Assign to collider: Collider > Material

// PhysicMaterial settings:
// - Dynamic Friction: 0.6 (sliding friction)
// - Static Friction: 0.6 (starting friction)
// - Bounciness: 0.0 - 1.0
// - Friction Combine: Average, Minimum, Maximum, Multiply
// - Bounce Combine: Average, Minimum, Maximum, Multiply
```

---

<!-- 中文翻译 -->
## Joints

<!-- 中文翻译 -->
### Fixed Joint (Attach two rigidbodies)

```csharp
FixedJoint joint = gameObject.AddComponent<FixedJoint>();
joint.connectedBody = otherRigidbody;
```

<!-- 中文翻译 -->
### Hinge Joint (Door, wheel)

```csharp
HingeJoint hinge = gameObject.AddComponent<HingeJoint>();
hinge.axis = Vector3.up; // Rotation axis
hinge.useLimits = true;
hinge.limits = new JointLimits { min = -90, max = 90 };
```

---

<!-- 性能优化 -->
## Performance Optimization

<!-- 中文翻译 -->
### Physics Layer Collision Matrix
`Edit > Project Settings > Physics > Layer Collision Matrix`
- Disable unnecessary collision checks between layers
- Massive performance gain

<!-- 中文翻译 -->
### Fixed Timestep
`Edit > Project Settings > Time > Fixed Timestep`
- Default: 0.02 (50 FPS physics)
- Lower = more accurate, higher CPU cost
- Match game's target framerate if possible

<!-- 中文翻译 -->
### Simplified Collision Geometry
- Use primitive colliders (box, sphere, capsule) over mesh colliders
- Bake mesh colliders at build time, not runtime

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Ground Check (Character Controller)

```csharp
bool IsGrounded() {
    float rayLength = 0.1f;
    return Physics.Raycast(transform.position, Vector3.down, rayLength);
}
```

<!-- 中文翻译 -->
### Apply Explosion Force

```csharp
void ApplyExplosion(Vector3 explosionPos, float radius, float force) {
    Collider[] colliders = Physics.OverlapSphere(explosionPos, radius);
    foreach (Collider hit in colliders) {
        Rigidbody rb = hit.GetComponent<Rigidbody>();
        if (rb != null) {
            rb.AddExplosionForce(force, explosionPos, radius);
        }
    }
}
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Physics Debugger (Unity 6+)
- `Window > Analysis > Physics Debugger`
- Visualize colliders, contacts, queries

<!-- 中文翻译 -->
### Gizmos

```csharp
void OnDrawGizmos() {
    Gizmos.color = Color.red;
    Gizmos.DrawWireSphere(transform.position, detectionRadius);
}
```

---

<!-- 来源 -->
## Sources
- https://docs.unity3d.com/6000.0/Documentation/Manual/PhysicsOverview.html
- https://docs.unity3d.com/ScriptReference/Physics.html
