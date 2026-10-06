//
//  WorkoutSessionData.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-30.
//

import Foundation

/// 전체 운동 세션 완료 데이터를 나타내는 최상위 모델
public struct WorkoutSessionData: Identifiable, Codable {
    public let id: UUID
    public let startDate: Date
    public var endDate: Date?
    public var totalDuration: TimeInterval
    public var exerciseSegments: [ExerciseSegment]
    public var healthSummary: HealthSnapshot
    public var routePoints: [WorkoutRoutePoint]

    /// 좌표만 필요한 소비자를 위한 CoreLocation 독립 표현
    public var routeLocations: [WorkoutCoordinate] {
        routePoints.map(\.coordinate)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case startDate
        case endDate
        case totalDuration
        case exerciseSegments
        case healthSummary
        case routePoints = "route_points"
        case legacyRouteLocations = "route_locations"
    }

    public init(
        id: UUID = UUID(),
        startDate: Date,
        endDate: Date? = nil,
        totalDuration: TimeInterval = 0,
        exerciseSegments: [ExerciseSegment] = [],
        healthSummary: HealthSnapshot = HealthSnapshot(),
        routePoints: [WorkoutRoutePoint] = []
    ) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.totalDuration = totalDuration
        self.exerciseSegments = exerciseSegments
        self.healthSummary = healthSummary
        self.routePoints = routePoints
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )

        id = try container.decode(
            UUID.self,
            forKey: .id
        )
        startDate = try container.decode(
            Date.self,
            forKey: .startDate
        )
        endDate = try container.decodeIfPresent(
            Date.self,
            forKey: .endDate
        )
        totalDuration = try container.decode(
            TimeInterval.self,
            forKey: .totalDuration
        )
        exerciseSegments = try container.decode(
            [ExerciseSegment].self,
            forKey: .exerciseSegments
        )
        healthSummary = try container.decode(
            HealthSnapshot.self,
            forKey: .healthSummary
        )

        if let decodedRoutePoints = try container.decodeIfPresent(
            [WorkoutRoutePoint].self,
            forKey: .routePoints
        ) {
            routePoints = decodedRoutePoints
            return
        }

        let legacyCoordinates = try container.decodeIfPresent(
            [[Double]].self,
            forKey: .legacyRouteLocations
        ) ?? []

        routePoints = legacyCoordinates.compactMap { values in
            guard values.count >= 2 else {
                return nil
            }

            return WorkoutRoutePoint(
                latitude: values[0],
                longitude: values[1]
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(
            keyedBy: CodingKeys.self
        )

        try container.encode(id, forKey: .id)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(
            totalDuration,
            forKey: .totalDuration
        )
        try container.encode(
            exerciseSegments,
            forKey: .exerciseSegments
        )
        try container.encode(
            healthSummary,
            forKey: .healthSummary
        )
        try container.encode(
            routePoints,
            forKey: .routePoints
        )

        let legacyCoordinates = routePoints.map {
            [
                $0.coordinate.latitude,
                $0.coordinate.longitude
            ]
        }

        try container.encode(
            legacyCoordinates,
            forKey: .legacyRouteLocations
        )
    }
}
