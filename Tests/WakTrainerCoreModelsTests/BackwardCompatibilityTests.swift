import Foundation
import CoreLocation
import Testing
import WakTrainerCoreModels

@Suite("Backward compatibility regression tests")
struct BackwardCompatibilityTests {
    @Test("Legacy live health snapshots decode without measurement metadata")
    func legacyHealthSnapshotDecoding() throws {
        let legacy = Data(
            #"{"heartRate":142,"stepCount":150,"activeCalories":32,"distance":480}"#.utf8
        )
        let snapshot = try JSONDecoder().decode(HealthSnapshot.self, from: legacy)
        #expect(snapshot.heartRate == 142)
        #expect(snapshot.sampleEndDates.isEmpty)
        let encoded = try JSONEncoder().encode(snapshot)
        let object = try #require(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        )
        #expect(object["sampleEndDates"] == nil)
    }

    @Test("Health snapshot preserves metric acquisition instants across serialization")
    func healthSnapshotSampleEndDatesRoundTrip() throws {
        let measuredAt = try #require(
            ISO8601DateFormatter().date(from: "2026-10-24T23:00:00Z")
        )
        let snapshot = HealthSnapshot(
            heartRate: 142,
            stepCount: 150,
            activeCalories: 32,
            distance: 480,
            sampleEndDates: [
                .heartRate: measuredAt,
                .stepCount: measuredAt.addingTimeInterval(-30)
            ]
        )
        let encoded = try JSONEncoder().encode(snapshot)
        let object = try #require(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        )
        let keyedDates = try #require(object["sampleEndDates"] as? [String: Any])
        #expect(keyedDates["heartRate"] != nil)
        #expect(keyedDates["stepCount"] != nil)
        let decoded = try JSONDecoder().decode(HealthSnapshot.self, from: encoded)
        #expect(decoded == snapshot)
        #expect(decoded.sampleEndDates[.heartRate] == measuredAt)
    }

    @Test("Legacy route coordinates retain the route_locations JSON key and pair format")
    func legacyRouteEncodingContract() throws {
        let start = Date(timeIntervalSince1970: 1_800_000_000)
        let original = WorkoutSessionData(
            startDate: start,
            totalDuration: 120,
            routeLocations: [
                CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
                CLLocationCoordinate2D(latitude: 37.5666, longitude: 126.9781)
            ]
        )

        let encoded = try JSONEncoder().encode(original)
        let object = try #require(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        )
        let coordinates = try #require(object["route_locations"] as? [[Double]])

        #expect(coordinates == [[37.5665, 126.9780], [37.5666, 126.9781]])

        let decoded = try JSONDecoder().decode(WorkoutSessionData.self, from: encoded)
        #expect(decoded.routeLocations.count == 2)
        #expect(decoded.routeLocations[0].latitude == 37.5665)
        #expect(decoded.routeLocations[1].longitude == 126.9781)
    }

    @Test("Previously saved route coordinates still decode, including malformed short entries")
    func legacyRouteDecodingContract() throws {
        let stored = WorkoutSessionData(
            startDate: Date(timeIntervalSince1970: 1_800_000_000)
        )
        let encoded = try JSONEncoder().encode(stored)
        var object = try #require(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        )
        object["route_locations"] = [
            [37.5, 127.0],
            [37.6],
            [],
            [37.7, 127.2]
        ]
        let data = try JSONSerialization.data(withJSONObject: object)

        let decoded = try JSONDecoder().decode(WorkoutSessionData.self, from: data)
        #expect(decoded.routeLocations.count == 2)
        #expect(decoded.routeLocations[0].longitude == 127.0)
        #expect(decoded.routeLocations[1].latitude == 37.7)
    }

    @Test("Existing CoreLocation coordinate property remains available")
    func routePointPublicCoordinateContract() {
        let point = WorkoutRoutePoint(
            timestamp: Date(timeIntervalSince1970: 1_800_000_000),
            latitude: 37.5665,
            longitude: 126.9780,
            altitude: 35
        )
        let coordinate: CLLocationCoordinate2D = point.coordinate
        #expect(coordinate.latitude == 37.5665)
        #expect(coordinate.longitude == 126.9780)
    }

    @Test("Strength equipment records survive Codable round trips")
    func strengthEquipmentPersistenceContract() throws {
        let record = WorkoutExerciseRecord(
            name: "Bench Press",
            kind: .strength,
            strengthEquipment: .barbell,
            startDate: Date(timeIntervalSince1970: 1_800_000_000)
        )
        let data = try JSONEncoder().encode(record)
        let decoded = try JSONDecoder().decode(WorkoutExerciseRecord.self, from: data)
        #expect(decoded == record)
        #expect(decoded.strengthEquipment == .barbell)
    }

    @Test("Existing initializer continues accepting omitted equipment")
    func optionalEquipmentSourceCompatibility() {
        let record = WorkoutExerciseRecord(
            name: "Push Up",
            kind: .strength,
            startDate: Date(timeIntervalSince1970: 1_800_000_000)
        )
        #expect(record.strengthEquipment == nil)
    }
}
