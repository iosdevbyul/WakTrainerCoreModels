import Foundation
import CoreLocation
import Testing
@testable import WakTrainerCoreModels

@Suite("WakTrainerCoreModels 테스트")
struct WakTrainerCoreModelsTests {
    
    @Test("ExerciseSegment 소요 시간(duration) 계산 검증")
    func testExerciseSegmentDuration() {
        // Given
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(900) // 15분 (900초) 후
        
        // When
        let segment = ExerciseSegment(
            name: "벤치프레스",
            startTime: startTime,
            endTime: endTime
        )
        
        // Then
        #expect(segment.duration == 900)
    }
    
    @Test("HealthSnapshot 기본값 및 커스텀 값 생성 검증")
    func testHealthSnapshotInitialization() {
        // Given & When
        let defaultSnapshot = HealthSnapshot()
        let customSnapshot = HealthSnapshot(
            heartRate: 145.0,
            stepCount: 3500.0,
            activeCalories: 250.5,
            distance: 1200.0
        )
        
        // Then
        #expect(defaultSnapshot.heartRate == 0.0)
        #expect(customSnapshot.heartRate == 145.0)
        #expect(customSnapshot.activeCalories == 250.5)
    }
    
    @Test("WorkoutSessionData JSON Codable (인코딩/디코딩 및 위치 좌표) 검증")
    func testWorkoutSessionDataCodable() throws {
        // Given
        let startDate = Date()
        let segment = ExerciseSegment(name: "스쿼트", startTime: startDate)
        let snapshot = HealthSnapshot(heartRate: 130.0, activeCalories: 150.0)
        let route = [
            CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780) // 서울시청 좌표
        ]
        
        let originalSession = WorkoutSessionData(
            startDate: startDate,
            totalDuration: 1800,
            exerciseSegments: [segment],
            healthSummary: snapshot,
            routeLocations: route
        )
        
        // When (JSON 인코딩 후 다시 디코딩)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(originalSession)
        let decodedSession = try decoder.decode(WorkoutSessionData.self, from: data)
        
        // Then
        #expect(decodedSession.id == originalSession.id)
        #expect(decodedSession.exerciseSegments.first?.name == "스쿼트")
        #expect(decodedSession.healthSummary.heartRate == 130.0)
        #expect(decodedSession.routeLocations.count == 1)
        #expect(decodedSession.routeLocations.first?.latitude == 37.5665)
    }
}
