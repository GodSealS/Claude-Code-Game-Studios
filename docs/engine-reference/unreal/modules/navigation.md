# Unreal Engine 5.7 — Navigation Module Reference / Unreal Engine导航模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 navigation improvements

---

<!-- 概述 -->
## Overview

UE 5.7 navigation systems:
- **Nav Mesh**: Automatic pathfinding mesh for AI
- **AI Controller**: Controls AI movement and behavior
- **Behavior Trees**: AI decision-making (covered in AI module)

---

<!-- 中文翻译 -->
## Nav Mesh Setup

<!-- 中文翻译 -->
### Add Nav Mesh Bounds Volume

1. Place Actors > Volumes > Nav Mesh Bounds Volume
2. Scale to cover walkable areas
3. Press `P` to toggle Nav Mesh visualization (green overlay)

<!-- 中文翻译 -->
### Nav Mesh Settings

```cpp
// Project Settings > Engine > Navigation System
// - Generate Navigation Only Around Navigation Invokers: Performance optimization
// - Auto Update Enabled: Rebuild NavMesh when geometry changes
```

---

<!-- 中文翻译 -->
## AI Controller & Movement

<!-- 中文翻译 -->
### Create AI Controller

```cpp
UCLASS()
class AEnemyAIController : public AAIController {
    GENERATED_BODY()

public:
    void BeginPlay() override {
        Super::BeginPlay();

        // Move to location
        FVector TargetLocation = FVector(1000, 0, 0);
        MoveToLocation(TargetLocation);
    }
};
```

<!-- 中文翻译 -->
### Assign AI Controller to Pawn

```cpp
UCLASS()
class AEnemyCharacter : public ACharacter {
    GENERATED_BODY()

public:
    AEnemyCharacter() {
        // ✅ Assign AI Controller class
        AIControllerClass = AEnemyAIController::StaticClass();
        AutoPossessAI = EAutoPossessAI::PlacedInWorldOrSpawned;
    }
};
```

---

<!-- 中文翻译 -->
## Basic AI Movement

<!-- 中文翻译 -->
### Move to Location

```cpp
AAIController* AIController = Cast<AAIController>(GetController());
if (AIController) {
    FVector TargetLocation = FVector(1000, 0, 0);
    EPathFollowingRequestResult::Type Result = AIController->MoveToLocation(TargetLocation);

    if (Result == EPathFollowingRequestResult::RequestSuccessful) {
        UE_LOG(LogTemp, Warning, TEXT("Moving to location"));
    }
}
```

<!-- 中文翻译 -->
### Move to Actor

```cpp
AActor* Target = /* Get target actor */;
AIController->MoveToActor(Target, 100.0f); // Stop 100 units away
```

<!-- 中文翻译 -->
### Stop Movement

```cpp
AIController->StopMovement();
```

---

<!-- 中文翻译 -->
## Path Following Events

<!-- 中文翻译 -->
### On Move Completed

```cpp
UCLASS()
class AEnemyAIController : public AAIController {
    GENERATED_BODY()

public:
    void BeginPlay() override {
        Super::BeginPlay();

        // Bind to move completed event
        ReceiveMoveCompleted.AddDynamic(this, &AEnemyAIController::OnMoveCompleted);
    }

    UFUNCTION()
    void OnMoveCompleted(FAIRequestID RequestID, EPathFollowingResult::Type Result) {
        if (Result == EPathFollowingResult::Success) {
            UE_LOG(LogTemp, Warning, TEXT("Reached destination"));
        } else {
            UE_LOG(LogTemp, Warning, TEXT("Failed to reach destination"));
        }
    }
};
```

---

<!-- 中文翻译 -->
## Pathfinding Queries

<!-- 中文翻译 -->
### Find Path to Location

```cpp
#include "NavigationSystem.h"
#include "NavigationPath.h"

UNavigationSystemV1* NavSys = UNavigationSystemV1::GetCurrent(GetWorld());
if (NavSys) {
    FVector Start = GetActorLocation();
    FVector End = TargetLocation;

    FPathFindingQuery Query;
    Query.StartLocation = Start;
    Query.EndLocation = End;
    Query.NavData = NavSys->GetDefaultNavDataInstance();

    FPathFindingResult Result = NavSys->FindPathSync(Query);

    if (Result.IsSuccessful()) {
        UNavigationPath* NavPath = Result.Path.Get();
        // Use path points: NavPath->GetPathPoints()
    }
}
```

<!-- 中文翻译 -->
### Check if Location is Reachable

```cpp
UNavigationSystemV1* NavSys = UNavigationSystemV1::GetCurrent(GetWorld());
FNavLocation OutLocation;
bool bReachable = NavSys->ProjectPointToNavigation(TargetLocation, OutLocation);

if (bReachable) {
    UE_LOG(LogTemp, Warning, TEXT("Location is reachable"));
}
```

---

<!-- 中文翻译 -->
## Nav Mesh Modifiers

<!-- 中文翻译 -->
### Nav Modifier Volume (Block/Allow Areas)

1. Place Actors > Volumes > Nav Modifier Volume
2. Configure Area Class (e.g., NavArea_Null to block, NavArea_LowHeight for crouching)

---

<!-- 中文翻译 -->
## Custom Nav Areas

<!-- 中文翻译 -->
### Create Custom Nav Area

```cpp
UCLASS()
class UNavArea_Jump : public UNavArea {
    GENERATED_BODY()

public:
    UNavArea_Jump() {
        DefaultCost = 10.0f; // Higher cost = AI avoids unless necessary
        FixedAreaEnteringCost = 100.0f; // One-time cost to enter
    }
};
```

<!-- 中文翻译 -->
### Use Custom Nav Area

```cpp
// Assign to Nav Modifier Volume or geometry
```

---

<!-- 中文翻译 -->
## Nav Mesh Generation

<!-- 中文翻译 -->
### Rebuild Nav Mesh at Runtime

```cpp
UNavigationSystemV1* NavSys = UNavigationSystemV1::GetCurrent(GetWorld());
NavSys->Build(); // Rebuild entire NavMesh
```

<!-- 中文翻译 -->
### Dynamic Nav Mesh (Moving Obstacles)

```cpp
// Enable: Project Settings > Navigation System > Runtime Generation = Dynamic

// Mark actor as dynamic obstacle:
UStaticMeshComponent* Mesh = /* Get mesh */;
Mesh->SetCanEverAffectNavigation(true);
Mesh->bDynamicObstacle = true;
```

---

<!-- 中文翻译 -->
## Nav Links (Off-Mesh Connections)

<!-- 中文翻译 -->
### Nav Link Proxy (Jump, Teleport)

1. Place Actors > Navigation > Nav Link Proxy
2. Set up start and end points
3. Configure:
   - **Direction**: One-way or bidirectional
   - **Smart Link**: Animate character during traversal

---

<!-- 中文翻译 -->
## Crowd Management

<!-- 中文翻译 -->
### Detour Crowd (Avoid Overlapping)

```cpp
// Enable: Character Movement Component > Avoidance Enabled = true

// Configure avoidance group and flags
UCharacterMovementComponent* MoveComp = GetCharacterMovement();
MoveComp->SetAvoidanceGroup(1);
MoveComp->SetGroupsToAvoid(1);
MoveComp->SetAvoidanceEnabled(true);
```

---

<!-- 性能提示 -->
## Performance Tips

<!-- 中文翻译 -->
### Nav Mesh Optimization

```cpp
// Reduce tile size for large worlds:
// Project Settings > Navigation System > Cell Size = 19 (default)

// Use Navigation Invokers for dynamic generation:
// Only generate NavMesh around players/important actors
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Visualize Nav Mesh

```cpp
// Console commands:
// show navigation - Toggle NavMesh visualization
// p - Toggle NavMesh (editor viewport)

// Draw debug path:
if (NavPath) {
    for (int i = 0; i < NavPath->GetPathPoints().Num() - 1; i++) {
        DrawDebugLine(GetWorld(), NavPath->GetPathPoints()[i], NavPath->GetPathPoints()[i + 1], FColor::Green, false, 5.0f, 0, 5.0f);
    }
}
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Patrol Between Waypoints

```cpp
UPROPERTY(EditAnywhere, Category = "AI")
TArray<AActor*> PatrolPoints;

int32 CurrentPatrolIndex = 0;

void OnMoveCompleted(FAIRequestID RequestID, EPathFollowingResult::Type Result) {
    if (Result == EPathFollowingResult::Success) {
        // Move to next waypoint
        CurrentPatrolIndex = (CurrentPatrolIndex + 1) % PatrolPoints.Num();
        MoveToActor(PatrolPoints[CurrentPatrolIndex]);
    }
}
```

<!-- 中文翻译 -->
### Chase Player

```cpp
void Tick(float DeltaTime) {
    Super::Tick(DeltaTime);

    AAIController* AIController = Cast<AAIController>(GetController());
    APawn* PlayerPawn = GetWorld()->GetFirstPlayerController()->GetPawn();

    if (AIController && PlayerPawn) {
        float Distance = FVector::Dist(GetActorLocation(), PlayerPawn->GetActorLocation());

        if (Distance < 1000.0f) {
            // Chase player
            AIController->MoveToActor(PlayerPawn, 100.0f);
        } else {
            // Stop chasing
            AIController->StopMovement();
        }
    }
}
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/navigation-system-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/ai-in-unreal-engine/
