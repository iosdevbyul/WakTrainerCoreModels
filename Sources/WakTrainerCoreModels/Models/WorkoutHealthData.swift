import Foundation

public enum WorkoutHealthMetric: String, Codable, CaseIterable, Sendable {
    case heartRate
    case heartRateVariabilitySDNN
    case activeEnergyBurned
    case basalEnergyBurned
    case stepCount
    case distanceWalkingRunning
    case distanceCycling
    case flightsClimbed
    case runningSpeed
    case runningPower
    case runningCadence
    case runningStrideLength
    case runningVerticalOscillation
    case runningGroundContactTime
    case cyclingPower
    case cyclingCadence
}

public struct WorkoutHealthMetricSample: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let metric: WorkoutHealthMetric
    public let startDate: Date
    public let endDate: Date
    public let value: Double
    public let unit: String
    public let sourceName: String?
    public let sourceBundleIdentifier: String?

    public init(
        id: UUID = UUID(),
        metric: WorkoutHealthMetric,
        startDate: Date,
        endDate: Date,
        value: Double,
        unit: String,
        sourceName: String? = nil,
        sourceBundleIdentifier: String? = nil
    ) {
        self.id = id
        self.metric = metric
        self.startDate = startDate
        self.endDate = endDate
        self.value = value
        self.unit = unit
        self.sourceName = sourceName
        self.sourceBundleIdentifier = sourceBundleIdentifier
    }
}

public struct WorkoutHealthSummary: Codable, Equatable, Sendable {
    public var averageHeartRate: Double?
    public var minimumHeartRate: Double?
    public var maximumHeartRate: Double?
    public var averageHeartRateVariability: Double?
    public var activeCalories: Double?
    public var basalCalories: Double?
    public var stepCount: Double?
    public var distanceMeters: Double?
    public var averageSpeedMetersPerSecond: Double?
    public var maximumSpeedMetersPerSecond: Double?
    public var averageCadence: Double?
    public var averagePowerWatts: Double?
    public var elevationGainMeters: Double?

    public init(
        averageHeartRate: Double? = nil,
        minimumHeartRate: Double? = nil,
        maximumHeartRate: Double? = nil,
        averageHeartRateVariability: Double? = nil,
        activeCalories: Double? = nil,
        basalCalories: Double? = nil,
        stepCount: Double? = nil,
        distanceMeters: Double? = nil,
        averageSpeedMetersPerSecond: Double? = nil,
        maximumSpeedMetersPerSecond: Double? = nil,
        averageCadence: Double? = nil,
        averagePowerWatts: Double? = nil,
        elevationGainMeters: Double? = nil
    ) {
        self.averageHeartRate = averageHeartRate
        self.minimumHeartRate = minimumHeartRate
        self.maximumHeartRate = maximumHeartRate
        self.averageHeartRateVariability = averageHeartRateVariability
        self.activeCalories = activeCalories
        self.basalCalories = basalCalories
        self.stepCount = stepCount
        self.distanceMeters = distanceMeters
        self.averageSpeedMetersPerSecond = averageSpeedMetersPerSecond
        self.maximumSpeedMetersPerSecond = maximumSpeedMetersPerSecond
        self.averageCadence = averageCadence
        self.averagePowerWatts = averagePowerWatts
        self.elevationGainMeters = elevationGainMeters
    }
}

public struct WorkoutHealthData: Codable, Equatable, Sendable {
    public var summary: WorkoutHealthSummary
    public var samples: [WorkoutHealthMetricSample]

    public init(
        summary: WorkoutHealthSummary = WorkoutHealthSummary(),
        samples: [WorkoutHealthMetricSample] = []
    ) {
        self.summary = summary
        self.samples = samples
    }

    public func samples(
        for metric: WorkoutHealthMetric
    ) -> [WorkoutHealthMetricSample] {
        samples.filter { $0.metric == metric }
    }
}
