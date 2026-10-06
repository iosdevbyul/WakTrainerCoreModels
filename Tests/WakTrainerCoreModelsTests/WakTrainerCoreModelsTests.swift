import Foundation
import Testing
@testable import WakTrainerCoreModels

@Suite("WakTrainerCoreModels 테스트")
struct WakTrainerCoreModelsTests {

    @Test("ExerciseSegment 소요 시간(duration) 계산 검증")
    func testExerciseSegmentDuration() {
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(900)

        let segment = ExerciseSegment(
            name: "벤치프레스",
            startTime: startTime,
            endTime: endTime
        )

        #expect(segment.duration == 900)
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

    @Test("WorkoutRoutePoint가 위치 측정 메타데이터를 보존")
    func testWorkoutRoutePointInitialization() {
        let timestamp = Date(
            timeIntervalSince1970: 1_000
        )

        let point = WorkoutRoutePoint(
            latitude: 37.5665,
            longitude: 126.9780,
            altitudeMeters: 30,
            horizontalAccuracyMeters: 5,
            verticalAccuracyMeters: 8,
            speedMetersPerSecond: 2.5,
            courseDegrees: 180,
            timestamp: timestamp
        )

        #expect(point.coordinate.latitude == 37.5665)
        #expect(point.coordinate.longitude == 126.9780)
        #expect(point.altitudeMeters == 30)
        #expect(point.horizontalAccuracyMeters == 5)
        #expect(point.verticalAccuracyMeters == 8)
        #expect(point.speedMetersPerSecond == 2.5)
        #expect(point.courseDegrees == 180)
        #expect(point.timestamp == timestamp)
    }

    @Test("WorkoutSessionData JSON 왕복 시 전체 경로 데이터 보존")
    func testWorkoutSessionDataCodable() throws {
        let startDate = Date(
            timeIntervalSince1970: 2_000
        )
        let segment = ExerciseSegment(
            name: "스쿼트",
            startTime: startDate
        )
        let snapshot = HealthSnapshot(
            heartRate: 130.0,
            activeCalories: 150.0
        )
        let route = [
            WorkoutRoutePoint(
                latitude: 37.5665,
                longitude: 126.9780,
                altitudeMeters: 25,
                speedMetersPerSecond: 2.2,
                timestamp: startDate
            )
        ]

        let originalSession = WorkoutSessionData(
            startDate: startDate,
            totalDuration: 1800,
            exerciseSegments: [segment],
            healthSummary: snapshot,
            routePoints: route
        )

        let data = try JSONEncoder().encode(
            originalSession
        )
        let decodedSession = try JSONDecoder().decode(
            WorkoutSessionData.self,
            from: data
        )

        #expect(decodedSession.id == originalSession.id)
        #expect(
            decodedSession.exerciseSegments.first?.name
                == "스쿼트"
        )
        #expect(
            decodedSession.healthSummary.heartRate == 130.0
        )
        #expect(decodedSession.routePoints.count == 1)
        #expect(
            decodedSession.routePoints.first?.coordinate.latitude
                == 37.5665
        )
        #expect(
            decodedSession.routePoints.first?.altitudeMeters
                == 25
        )
        #expect(
            decodedSession.routePoints.first?.speedMetersPerSecond
                == 2.2
        )
        #expect(
            decodedSession.routePoints.first?.timestamp
                == startDate
        )
    }

    @Test("기존 route_locations 좌표 배열을 계속 디코딩")
    func testLegacyWorkoutSessionRouteDecoding() throws {
        let id = UUID()
        let startDate = Date(
            timeIntervalSince1970: 3_000
        )

        let legacyPayload = LegacyWorkoutSessionPayload(
            id: id,
            startDate: startDate,
            endDate: nil,
            totalDuration: 1200,
            exerciseSegments: [],
            healthSummary: HealthSnapshot(),
            routeLocations: [
                [37.5665, 126.9780],
                [37.5670, 126.9790]
            ]
        )

        let data = try JSONEncoder().encode(
            legacyPayload
        )
        let decodedSession = try JSONDecoder().decode(
            WorkoutSessionData.self,
            from: data
        )

        #expect(decodedSession.id == id)
        #expect(decodedSession.routePoints.count == 2)
        #expect(
            decodedSession.routePoints.first?.coordinate.latitude
                == 37.5665
        )
        #expect(
            decodedSession.routePoints.last?.coordinate.longitude
                == 126.9790
        )
        #expect(
            decodedSession.routePoints.first?.timestamp == nil
        )
    }

    @Test("PaceSegment가 CoreLocation 없이 좌표를 표현")
    func testPaceSegmentUsesWorkoutCoordinate() {
        let start = WorkoutCoordinate(
            latitude: 37.1,
            longitude: 127.1
        )
        let end = WorkoutCoordinate(
            latitude: 37.2,
            longitude: 127.2
        )

        let segment = PaceSegment(
            startCoordinate: start,
            endCoordinate: end,
            speedCategory: .moderate,
            speedMs: 2.2
        )

        #expect(segment.startCoordinate == start)
        #expect(segment.endCoordinate == end)
        #expect(segment.speedCategory == .moderate)
        #expect(segment.speedMs == 2.2)
    }
}

private struct LegacyWorkoutSessionPayload: Encodable {
    let id: UUID
    let startDate: Date
    let endDate: Date?
    let totalDuration: TimeInterval
    let exerciseSegments: [ExerciseSegment]
    let healthSummary: HealthSnapshot
    let routeLocations: [[Double]]

    enum CodingKeys: String, CodingKey {
        case id
        case startDate
        case endDate
        case totalDuration
        case exerciseSegments
        case healthSummary
        case routeLocations = "route_locations"
    }
}
