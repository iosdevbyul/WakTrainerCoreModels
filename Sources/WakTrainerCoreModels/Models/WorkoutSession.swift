import Foundation

public struct WorkoutSession: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let workout: WorkoutIdentity
    public var timing: WorkoutTiming
    public var exerciseRecords: [WorkoutExerciseRecord]
    public var health: WorkoutHealthData
    public var route: [WorkoutRoutePoint]

    public init(
        id: UUID = UUID(),
        workout: WorkoutIdentity,
        timing: WorkoutTiming,
        exerciseRecords: [WorkoutExerciseRecord] = [],
        health: WorkoutHealthData = WorkoutHealthData(),
        route: [WorkoutRoutePoint] = []
    ) {
        self.id = id
        self.workout = workout
        self.timing = timing
        self.exerciseRecords = exerciseRecords
        self.health = health
        self.route = route
    }
}

public struct WorkoutIdentity: Codable, Equatable, Sendable {
    public let workoutID: String
    public let name: String
    public let category: String
    public let type: WorkoutType

    public init(
        workoutID: String,
        name: String,
        category: String,
        type: WorkoutType
    ) {
        self.workoutID = workoutID
        self.name = name
        self.category = category
        self.type = type
    }
}

public struct WorkoutTiming: Codable, Equatable, Sendable {
    public let startDate: Date
    public var endDate: Date?
    public var elapsedDuration: TimeInterval
    public var activeDuration: TimeInterval
    public var pausedDuration: TimeInterval

    /// Exact paused windows used for future partial-restore editing.
    /// Legacy sessions decode with an empty array.
    public var pauseIntervals: [WorkoutPauseInterval]

    public init(
        startDate: Date,
        endDate: Date? = nil,
        elapsedDuration: TimeInterval = 0,
        activeDuration: TimeInterval = 0,
        pausedDuration: TimeInterval = 0,
        pauseIntervals: [WorkoutPauseInterval] = []
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.elapsedDuration = elapsedDuration
        self.activeDuration = activeDuration
        self.pausedDuration = pausedDuration
        self.pauseIntervals = pauseIntervals
    }

    private enum CodingKeys: String, CodingKey {
        case startDate
        case endDate
        case elapsedDuration
        case activeDuration
        case pausedDuration
        case pauseIntervals
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        startDate = try container.decode(Date.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(Date.self, forKey: .endDate)
        elapsedDuration = try container.decode(TimeInterval.self, forKey: .elapsedDuration)
        activeDuration = try container.decode(TimeInterval.self, forKey: .activeDuration)
        pausedDuration = try container.decode(TimeInterval.self, forKey: .pausedDuration)
        pauseIntervals = try container.decodeIfPresent(
            [WorkoutPauseInterval].self,
            forKey: .pauseIntervals
        ) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(startDate, forKey: .startDate)
        try container.encodeIfPresent(endDate, forKey: .endDate)
        try container.encode(elapsedDuration, forKey: .elapsedDuration)
        try container.encode(activeDuration, forKey: .activeDuration)
        try container.encode(pausedDuration, forKey: .pausedDuration)
        if !pauseIntervals.isEmpty {
            try container.encode(pauseIntervals, forKey: .pauseIntervals)
        }
    }
}
