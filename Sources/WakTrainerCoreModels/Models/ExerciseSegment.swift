//
//  ExerciseSegment.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-30.
//

import Foundation

/// Legacy exercise time segment.
///
/// New workout records should use `WorkoutExerciseRecord`, which can preserve
/// strength sets and cardio intervals in addition to the time range.
public struct ExerciseSegment: Identifiable, Codable, Equatable {
    public let id: UUID
    public var name: String
    public let startTime: Date
    public var endTime: Date?

    public init(
        id: UUID = UUID(),
        name: String,
        startTime: Date = Date(),
        endTime: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
    }

    /// Duration is only final once the segment has an end time.
    public var completedDuration: TimeInterval? {
        guard let endTime else { return nil }
        return endTime.timeIntervalSince(startTime)
    }

    @available(*, deprecated, message: "Use completedDuration. Live duration belongs in session/UI state.")
    public var duration: TimeInterval {
        completedDuration ?? 0
    }
}
