import Foundation

/// A recorded pause window, independent of whether sensor samples were collected
/// during the pause. Restore operations can later select subranges of this window.
public struct WorkoutPauseInterval: Codable, Equatable, Sendable {
    public let startDate: Date
    public let endDate: Date

    public init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }

    /// An invalid or zero-length interval cannot contribute paused time.
    public var duration: TimeInterval {
        max(0, endDate.timeIntervalSince(startDate))
    }
}
