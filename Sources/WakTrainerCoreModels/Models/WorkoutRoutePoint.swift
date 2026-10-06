//
//  WorkoutRoutePoint.swift
//  WakTrainerCoreModels
//

import Foundation

public struct WorkoutCoordinate: Codable, Sendable, Equatable, Hashable {
    public let latitude: Double
    public let longitude: Double

    public init(
        latitude: Double,
        longitude: Double
    ) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public struct WorkoutRoutePoint: Codable, Sendable, Equatable {
    public let coordinate: WorkoutCoordinate
    public let altitudeMeters: Double?
    public let horizontalAccuracyMeters: Double?
    public let verticalAccuracyMeters: Double?
    public let speedMetersPerSecond: Double?
    public let courseDegrees: Double?
    public let timestamp: Date?

    public init(
        coordinate: WorkoutCoordinate,
        altitudeMeters: Double? = nil,
        horizontalAccuracyMeters: Double? = nil,
        verticalAccuracyMeters: Double? = nil,
        speedMetersPerSecond: Double? = nil,
        courseDegrees: Double? = nil,
        timestamp: Date? = nil
    ) {
        self.coordinate = coordinate
        self.altitudeMeters = altitudeMeters
        self.horizontalAccuracyMeters = horizontalAccuracyMeters
        self.verticalAccuracyMeters = verticalAccuracyMeters
        self.speedMetersPerSecond = speedMetersPerSecond
        self.courseDegrees = courseDegrees
        self.timestamp = timestamp
    }

    public init(
        latitude: Double,
        longitude: Double,
        altitudeMeters: Double? = nil,
        horizontalAccuracyMeters: Double? = nil,
        verticalAccuracyMeters: Double? = nil,
        speedMetersPerSecond: Double? = nil,
        courseDegrees: Double? = nil,
        timestamp: Date? = nil
    ) {
        self.init(
            coordinate: WorkoutCoordinate(
                latitude: latitude,
                longitude: longitude
            ),
            altitudeMeters: altitudeMeters,
            horizontalAccuracyMeters: horizontalAccuracyMeters,
            verticalAccuracyMeters: verticalAccuracyMeters,
            speedMetersPerSecond: speedMetersPerSecond,
            courseDegrees: courseDegrees,
            timestamp: timestamp
        )
    }
}
