# Backward compatibility contract

This package is consumed directly by multiple WakTrainer Swift packages. Treat its public API and persisted workout data format as a compatibility boundary.

## Verified direct consumers (2026-10-21)

- [WakTrainerServiceLocation](https://github.com/iosdevbyul/WakTrainerServiceLocation/blob/main/Package.swift) resolves `WakTrainerCoreModels` from `main`.
- [WakTrainerDomainWorkout](https://github.com/iosdevbyul/WakTrainerDomainWorkout/blob/main/Package.swift) resolves `WakTrainerCoreModels` from `main`.

Other consumers, transitive dependencies, and pinned resolution files must be checked before any public API migration.

## Non-breaking change rules

1. Keep existing public types, initializers, properties, cases, protocol requirements and signatures available to current callers. Deprecate instead of deleting. Adding a protocol requirement without a compatible default is a breaking change.
2. Preserve the ability to decode existing saved `WorkoutSession` and legacy `WorkoutSessionData` data, including historical route payloads. Newly added stored fields must be optional or have decoding defaults, and changes must be validated with fixtures.
3. Do not change `CLLocation` / `CLLocationCoordinate2D` public API in place. Any Foundation-only location model must initially be additive, with separate adapters. Removal requires a coordinated migration with every consuming SPM and the application.
4. Do not change minimum deployment targets or Swift language/tools requirements as part of the location refactor.
5. Never land a breaking API change directly on `main`. Work on a branch; run model unit tests and downstream build/tests with exact proposed revision; then open a PR for review.
6. Do not assume CI success in this repository alone proves compatibility. Require consumer-side evidence and explicit approval before merging.

## Migration sequence

1. Inventory direct and transitive usages of public CoreModels APIs and dependency revisions.
2. Capture baseline builds/tests for CoreModels, ServiceLocation, DomainWorkout, FeatureWorkout and WakTrainerApp (plus any additional users found).
3. Add characterization tests for Codable, legacy route decoding, recorded strength equipment and public API compile usage.
4. Introduce new Foundation-only coordinate structures **additively** if justified. Retain and test bridges to existing CoreLocation APIs.
5. Migrate consumers one by one, verifying tests and the app with each proposed revision.
6. Consider deprecation/removal only in a separately planned breaking release after consumers have migrated.

## Previous attempt

[PR #2](https://github.com/iosdevbyul/WakTrainerCoreModels/pull/2) was closed without merge on 2026-10-20. Its CoreLocation-removal changes are **not** in `main`. Do not reuse or merge its stale branch blindly.

## Current verification status

This document changes **no executable code or public API**. Consumer manifests for ServiceLocation and DomainWorkout were inspected; repository-wide usage auditing, simulator builds, tests, and CI have **not yet** been completed. Treat the migration as blocked until those checks are performed.
