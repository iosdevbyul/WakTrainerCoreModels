//
//  WorkoutSessionData.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-30.
//

import Foundation
import CoreLocation

/// 전체 운동 세션 완료 데이터를 나타내는 최상위 모델
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
        
        let coords = try container.decode([[Double]].self, forKey: .routeLocations)
        routeLocations = coords.map { CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1]) }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(totalDuration, forKey: .totalDuration)
        try container.encode(exerciseSegments, forKey: .exerciseSegments)
        try container.encode(healthSummary, forKey: .healthSummary)
        
        let coords = routeLocations.map { [$0.latitude, $0.longitude] }
        try container.encode(coords, forKey: .routeLocations)
    }
}
