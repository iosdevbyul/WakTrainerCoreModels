//
//  WorkoutLocationModels.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-25.
//

import Foundation

/// 운동 유형
public enum WorkoutType: String, Codable, Sendable {
    case staticWorkout
    case dynamicWorkout
}

/// Pace(속도) 구간별 컬러 구분
public enum SpeedCategory: String, Codable, CaseIterable, Sendable {
    case verySlow
    case slow
    case moderate
    case brisk
    case fast
    case veryFast

    /// m/s 속도 기준으로 구간 분류
    public static func category(
        forSpeed speed: Double
    ) -> SpeedCategory {
        switch speed {
        case ..<1.0:
            return .verySlow
        case 1.0..<1.8:
            return .slow
        case 1.8..<2.5:
            return .moderate
        case 2.5..<3.3:
            return .brisk
        case 3.3..<4.2:
            return .fast
        default:
            return .veryFast
        }
    }
}

/// 경로상 한 지점과 다음 지점 사이의 선분 정보
public struct PaceSegment: Codable, Sendable, Identifiable, Equatable {
    public let id: UUID
    public let startCoordinate: WorkoutCoordinate
    public let endCoordinate: WorkoutCoordinate
    public let speedCategory: SpeedCategory
    public let speedMs: Double

    public init(
        id: UUID = UUID(),
        startCoordinate: WorkoutCoordinate,
        endCoordinate: WorkoutCoordinate,
        speedCategory: SpeedCategory,
        speedMs: Double
    ) {
        self.id = id
        self.startCoordinate = startCoordinate
        self.endCoordinate = endCoordinate
        self.speedCategory = speedCategory
        self.speedMs = speedMs
    }
}

/// 정적 운동 시 산출된 중심 대표 좌표
public struct StaticLocationSummary: Codable, Sendable, Equatable {
    public let centerCoordinate: WorkoutCoordinate
    public let sampleCount: Int

    public init(
        centerCoordinate: WorkoutCoordinate,
        sampleCount: Int
    ) {
        self.centerCoordinate = centerCoordinate
        self.sampleCount = sampleCount
    }
}
