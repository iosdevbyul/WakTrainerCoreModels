# Downstream compatibility inventory

Checked against each consumer repository's default-branch `Package.swift` on 2026-10-21.

## Confirmed direct consumers

| Package | CoreModels requirement | Test target |
| --- | --- | --- |
| [WakTrainerServiceLocation](https://github.com/iosdevbyul/WakTrainerServiceLocation/blob/main/Package.swift) | `branch: "main"` | `WakTrainerServiceLocationTests` |
| [WakTrainerDomainWorkout](https://github.com/iosdevbyul/WakTrainerDomainWorkout/blob/main/Package.swift) | `branch: "main"` | `WakTrainerDomainWorkoutTests` |
| [WakTrainerFeatureWorkout](https://github.com/iosdevbyul/WakTrainerFeatureWorkout/blob/main/Package.swift) | `branch: "main"` | `WakTrainerFeatureWorkoutTests` |
| [WakTrainerServiceHealthKit](https://github.com/iosdevbyul/WakTrainerServiceHealthKit/blob/main/Package.swift) | `branch: "main"` | `WakTrainerServiceHealthKitTests` |
| [WakTrainerServiceWorkoutStorage](https://github.com/iosdevbyul/WakTrainerServiceWorkoutStorage/blob/main/Package.swift) | `branch: "main"` | `WakTrainerServiceWorkoutStorageTests` |

This is a **confirmed subset**, not a complete audit of all repository source files, app targets or transitive consumers. Some of these packages also depend on each other.

## Compatibility risk

Every confirmed consumer tracks CoreModels `main` directly, so a public API removal on that branch can affect downstream compilation without a consumer version change.

Keep `WorkoutRoutePoint.coordinate: CLLocationCoordinate2D`, legacy `WorkoutSessionData.routeLocations`, existing public model initializers and Codable payloads intact during any additive location-model experiment. Do not cherry-pick unmerged PR #2.

## Verification matrix — not yet executed

| Target | Required validation | Result |
| --- | --- | --- |
| CoreModels | Existing unit tests and new backward-compatibility tests | PR #5 CI passed |
| ServiceLocation | iOS simulator package build and unit tests | Pending |
| DomainWorkout | iOS simulator package build and unit tests | Pending |
| ServiceHealthKit | iOS simulator package build and unit tests | Pending |
| ServiceWorkoutStorage | iOS simulator package build and unit tests | Pending |
| FeatureWorkout | iOS simulator package build and unit tests | Pending |
| WakTrainerApp | App build, workout recording and history smoke tests | Pending |

## Guardrails before refactoring

1. Resolve and record the exact CoreModels commit used by the consumer.
2. Run baseline consumer build/tests on its unchanged main.
3. Run the same tests against the proposed CoreModels revision, without changing its public API.
4. Add any new Foundation coordinate types *alongside* existing CoreLocation-facing APIs, with tested bridges.
5. Migrate consumers separately; merge no breaking CoreModels revision until all are verified.
6. Confirm app simulation/device regressions before shipping.

No downstream builds or integration tests are claimed by this inventory. This is documentation only.
