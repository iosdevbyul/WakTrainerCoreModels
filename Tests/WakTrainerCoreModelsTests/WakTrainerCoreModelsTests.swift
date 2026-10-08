import Foundation
import CoreLocation
import Testing
@testable import WakTrainerCoreModels

@Suite("WakTrainerCoreModels 테스트")
struct WakTrainerCoreModelsTests {

    @Test("ExerciseSegment 완료 소요 시간 계산 검증")
    func testExerciseSegmentCompletedDuration() {
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(900)

        let segment = ExerciseSegment(
            name: "벤치프레스",
            startTime: startTime,
            endTime: endTime
        )

        #expect(segment.completedDuration == 900)
    }

    @Test("진행 중 ExerciseSegment는 확정 소요 시간을 만들지 않음")
    func testExerciseSegmentWithoutEndDateHasNoCompletedDuration() {
        let segment = ExerciseSegment(
            name: "스쿼트",
            startTime: Date(),
            endTime: nil
        )

        #expect(segment.completedDuration == nil)
    }

    @Test("HealthSnapshot 기본값 및 커스텀 값 생성 검증")
    func testHealthSnapshotInitialization() {
        let defaultSnapshot = HealthSnapshot()
        let customSnapshot = HealthSnapshot(
            heartRate: 145.0,
            stepCount: 3500.0,
            activeCalories: 250.5,
            distance: 1200.0
        )

        #expect(defaultSnapshot.heartRate == 0.0)
        #expect(customSnapshot.heartRate == 145.0)
        #expect(customSnapshot.activeCalories == 250.5)
    }

    @Test("WorkoutSession은 운동 정체성, 시간, 세트, HealthKit 샘플, 경로를 보존")
    func testWorkoutSessionCodable() throws {
        let startDate = Date(timeIntervalSince1970: 1_800_000_000)
        let endDate = startDate.addingTimeInterval(3600)

        let identity = WorkoutIdentity(
            workoutID: "bench-press",
            name: "Bench Press",
            category: "strength",
            type: .staticWorkout
        )

        let set = StrengthSetRecord(
            setNumber: 1,
            weightKilograms: 80,
            repetitions: 8,
            startDate: startDate,
            endDate: startDate.addingTimeInterval(45),
            restDuration: 90,
            isCompleted: true
        )

        let exercise = WorkoutExerciseRecord(
            exerciseID: "bench-press",
            name: "Bench Press",
            kind: .strength,
            strengthEquipment: .barbell,
            startDate: startDate,
            endDate: endDate,
            strengthSets: [set]
        )

        let heartRateSample = WorkoutHealthMetricSample(
            metric: .heartRate,
            startDate: startDate,
            endDate: startDate.addingTimeInterval(5),
            value: 142,
            unit: "count/min",
            sourceName: "Apple Watch",
            sourceBundleIdentifier: "com.apple.health"
        )

        let health = WorkoutHealthData(
            summary: WorkoutHealthSummary(
                averageHeartRate: 132,
                minimumHeartRate: 88,
                maximumHeartRate: 168,
                activeCalories: 410
            ),
            samples: [heartRateSample]
        )

        let routePoint = WorkoutRoutePoint(
            timestamp: startDate,
            latitude: 37.5665,
            longitude: 126.9780,
            altitude: 31,
            speedMetersPerSecond: 2.8,
            horizontalAccuracy: 4
        )

        let session = WorkoutSession(
            workout: identity,
            timing: WorkoutTiming(
                startDate: startDate,
                endDate: endDate,
                elapsedDuration: 3600,
                activeDuration: 3300,
                pausedDuration: 300
            ),
            exerciseRecords: [exercise],
            health: health,
            route: [routePoint]
        )

        let encoded = try JSONEncoder().encode(session)
        let decoded = try JSONDecoder().decode(WorkoutSession.self, from: encoded)

        #expect(decoded == session)
        #expect(decoded.exerciseRecords.first?.strengthEquipment == .barbell)
        #expect(decoded.exerciseRecords.first?.strengthSets.first?.volumeKilograms == 640)
        #expect(decoded.health.samples(for: .heartRate).count == 1)
        #expect(decoded.route.first?.coordinate.latitude == 37.5665)
    }

    @Test("Legacy WorkoutSessionData는 잘못된 route 좌표를 안전하게 무시")
    func testLegacyWorkoutSessionDataIgnoresMalformedCoordinate() throws {
        let id = UUID()
        let startDate = Date(timeIntervalSince1970: 1_800_000_000)
        let encoder = JSONEncoder()

        struct LegacyPayload: Encodable {
            let id: UUID
            let startDate: Date
            let endDate: Date?
            let totalDuration: TimeInterval
            let exerciseSegments: [ExerciseSegment]
            let healthSummary: HealthSnapshot
            let route_locations: [[Double]]
        }

        let payload = LegacyPayload(
            id: id,
            startDate: startDate,
            endDate: nil,
            totalDuration: 0,
            exerciseSegments: [],
            healthSummary: HealthSnapshot(),
            route_locations: [
                [37.5665],
                [37.5665, 126.9780]
            ]
        )

        let data = try encoder.encode(payload)
        let decoded = try JSONDecoder().decode(WorkoutSessionData.self, from: data)

        #expect(decoded.routeLocations.count == 1)
        #expect(decoded.routeLocations.first?.longitude == 126.9780)
    }
}
