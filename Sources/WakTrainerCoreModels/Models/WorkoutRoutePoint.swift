import Foundation
import CoreLocation

public struct WorkoutRoutePoint: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let timestamp: Date
    public let latitude: Double
    public let longitude: Double
    public let altitude: Double?
    public let speedMetersPerSecond: Double?
    public let horizontalAccuracy: Double?
    public let verticalAccuracy: Double?
    public let course: Double?

    public init(
        id: UUID = UUID(),
        timestamp: Date,
        latitude: Double,
        longitude: Double,
        altitude: Double? = nil,
        speedMetersPerSecond: Double? = nil,
        horizontalAccuracy: Double? = nil,
        verticalAccuracy: Double? = nil,
        course: Double? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.speedMetersPerSecond = speedMetersPerSecond
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
        self.course = course
    }

    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
