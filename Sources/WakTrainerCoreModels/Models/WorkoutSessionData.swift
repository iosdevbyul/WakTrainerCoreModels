//
//  WorkoutSessionData.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-30.
//

import Foundation
import CoreLocation

/// Legacy workout-session payload retained for source compatibility.
///
/// New workout recording and reporting code should use `WorkoutSession`.
@available(*, deprecated, message: "Use WorkoutSession for new workout recording and reporting.")
public struct WorkoutSessionData: Identifiable, Codable {
    public let id: UUID
    public let startDate: Date
    public var endDate: Date?
    public var totalDuration: TimeInterval
    public var exerciseSegments: [ExerciseSegment]
    public var healthSummary: HealthSnapshot
    public var routeLocations: [CLLocationCoordinate2D]

    enum CodingKeys: String, CodingKey {
        case id, startDate, endDate, totalDuration, exerciseSegments, healthSummary
        case routeLocations = "route_locations"
    }

    public init(
        id: UUID = UUID(),
        startDate: Date,
        endDate: Date? = nil,
        totalDuration: TimeInterval = 0,
        exerciseSegments: [ExerciseSegment] = [],
        healthSummary: HealthSnapshot = HealthSnapshot(),
        routeLocations: [CLLocationCoordinate2D] = []
    ) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.totalDuration = totalDuration
        self.exerciseSegments = exerciseSegments
        self.healthSummary = healthSummary
        self.routeLocations = routeLocations
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        startDate = try container.decode(Date.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(Date.self, forKey: .endDate)
        totalDuration = try container.decode(TimeInterval.self, forKey: .totalDuration)
        exerciseSegments = try container.decode([ExerciseSegment].self, forKey: .exerciseSegments)
        healthSummary = try container.decode(HealthSnapshot.self, forKey: .healthSummary)

        let coordinates = try container.decode([[Double]].self, forKey: .routeLocations)
        routeLocations = coordinates.compactMap { values in
            guard values.count >= 2 else { return nil }
            return CLLocationCoordinate2D(
                latitude: values[0],
                longitude: values[1]
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(totalDuration, forKey: .totalDuration)
        try container.encode(exerciseSegments, forKey: .exerciseSegments)
        try container.encode(healthSummary, forKey: .healthSummary)

        let coordinates = routeLocations.map { [$0.latitude, $0.longitude] }
        try container.encode(coordinates, forKey: .routeLocations)
    }
}
