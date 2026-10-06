import Foundation

public enum WorkoutExerciseRecordKind: String, Codable, Sendable {
    case strength
    case cardio
    case general
}

public struct WorkoutExerciseRecord: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let exerciseID: String?
    public var name: String
    public let kind: WorkoutExerciseRecordKind
    public let startDate: Date
    public var endDate: Date?
    public var strengthSets: [StrengthSetRecord]
    public var cardioIntervals: [CardioIntervalRecord]

    public init(
        id: UUID = UUID(),
        exerciseID: String? = nil,
        name: String,
        kind: WorkoutExerciseRecordKind,
        startDate: Date,
        endDate: Date? = nil,
        strengthSets: [StrengthSetRecord] = [],
        cardioIntervals: [CardioIntervalRecord] = []
    ) {
        self.id = id
        self.exerciseID = exerciseID
        self.name = name
        self.kind = kind
        self.startDate = startDate
        self.endDate = endDate
        self.strengthSets = strengthSets
        self.cardioIntervals = cardioIntervals
    }

    public var completedDuration: TimeInterval? {
        guard let endDate else { return nil }
        return endDate.timeIntervalSince(startDate)
    }
}

public struct StrengthSetRecord: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let setNumber: Int
    public var weightKilograms: Double?
    public var repetitions: Int?
    public var startDate: Date?
    public var endDate: Date?
    public var restDuration: TimeInterval?
    public var isWarmup: Bool
    public var isCompleted: Bool

    public init(
        id: UUID = UUID(),
        setNumber: Int,
        weightKilograms: Double? = nil,
        repetitions: Int? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        restDuration: TimeInterval? = nil,
        isWarmup: Bool = false,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.setNumber = setNumber
        self.weightKilograms = weightKilograms
        self.repetitions = repetitions
        self.startDate = startDate
        self.endDate = endDate
        self.restDuration = restDuration
        self.isWarmup = isWarmup
        self.isCompleted = isCompleted
    }

    public var volumeKilograms: Double? {
        guard let weightKilograms, let repetitions else { return nil }
        return weightKilograms * Double(repetitions)
    }
}

public struct CardioIntervalRecord: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let intervalNumber: Int
    public let startDate: Date
    public var endDate: Date?
    public var distanceMeters: Double?
    public var averageHeartRate: Double?
    public var averageSpeedMetersPerSecond: Double?
    public var activeCalories: Double?

    public init(
        id: UUID = UUID(),
        intervalNumber: Int,
        startDate: Date,
        endDate: Date? = nil,
        distanceMeters: Double? = nil,
        averageHeartRate: Double? = nil,
        averageSpeedMetersPerSecond: Double? = nil,
        activeCalories: Double? = nil
    ) {
        self.id = id
        self.intervalNumber = intervalNumber
        self.startDate = startDate
        self.endDate = endDate
        self.distanceMeters = distanceMeters
        self.averageHeartRate = averageHeartRate
        self.averageSpeedMetersPerSecond = averageSpeedMetersPerSecond
        self.activeCalories = activeCalories
    }

    public var completedDuration: TimeInterval? {
        guard let endDate else { return nil }
        return endDate.timeIntervalSince(startDate)
    }
}
