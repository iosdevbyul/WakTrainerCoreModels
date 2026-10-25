import Foundation

/// Live HealthKit metric values. The optional sample end times represent
/// acquisition instants, not the time a snapshot was emitted or uploaded.
public struct HealthSnapshot: Codable, Equatable {
    public var heartRate: Double
    public var stepCount: Double
    public var activeCalories: Double
    public var distance: Double

    /// Latest contributing sample end time for each metric, as an absolute Date.
    /// Aggregate values (steps, calories, distance) are not single samples;
    /// their timestamp denotes the most recent contributing sample.
    public var sampleEndDates: [WorkoutHealthMetric: Date]

    public init(
        heartRate: Double = 0.0,
        stepCount: Double = 0.0,
        activeCalories: Double = 0.0,
        distance: Double = 0.0,
        sampleEndDates: [WorkoutHealthMetric: Date] = [:]
    ) {
        self.heartRate = heartRate
        self.stepCount = stepCount
        self.activeCalories = activeCalories
        self.distance = distance
        self.sampleEndDates = sampleEndDates
    }

    private enum CodingKeys: String, CodingKey {
        case heartRate
        case stepCount
        case activeCalories
        case distance
        case sampleEndDates
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        heartRate = try container.decode(Double.self, forKey: .heartRate)
        stepCount = try container.decode(Double.self, forKey: .stepCount)
        activeCalories = try container.decode(Double.self, forKey: .activeCalories)
        distance = try container.decode(Double.self, forKey: .distance)
        sampleEndDates = try container.decodeIfPresent(
            [WorkoutHealthMetric: Date].self,
            forKey: .sampleEndDates
        ) ?? [:]
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(heartRate, forKey: .heartRate)
        try container.encode(stepCount, forKey: .stepCount)
        try container.encode(activeCalories, forKey: .activeCalories)
        try container.encode(distance, forKey: .distance)
        if !sampleEndDates.isEmpty {
            try container.encode(sampleEndDates, forKey: .sampleEndDates)
        }
    }
}
