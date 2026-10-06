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

    public init(
        startDate: Date,
        endDate: Date? = nil,
        elapsedDuration: TimeInterval = 0,
        activeDuration: TimeInterval = 0,
        pausedDuration: TimeInterval = 0
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.elapsedDuration = elapsedDuration
        self.activeDuration = activeDuration
        self.pausedDuration = pausedDuration
    }
}
