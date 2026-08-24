//
//  WorkoutLocationModels.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-25.
//

import Foundation
import CoreLocation

/// 운동 유형
public enum WorkoutType: String, Codable, Sendable {
    case staticWorkout  // 클라이밍, 트레드밀, 헬스 등 (한 장소)
    case dynamicWorkout // 걷기, 달리기, 자전거 등 (이동 경로)
}

/// Pace(속도) 구간별 컬러 구분
public enum SpeedCategory: String, CaseIterable, Sendable {
    case verySlow   // 연한 노란색 (Pace 느림)
    case slow       // 진한 노란색
    case moderate   // 초록색
    case brisk      // 진한 초록색
    case fast       // 연한 빨간색
    case veryFast   // 빨간색 (Pace 매우 빠름)
    
    /// m/s 속도 기준으로 구간 분류 (필요 시 운동 종목별 조정 가능)
    public static func category(forSpeed speed: Double) -> SpeedCategory {
        switch speed {
        case ..<1.0: return .verySlow
        case 1.0..<1.8: return .slow
        case 1.8..<2.5: return .moderate
        case 2.5..<3.3: return .brisk
        case 3.3..<4.2: return .fast
        default: return .veryFast
        }
    }
}

/// 경로상 한 지점과 다음 지점 사이의 선분 정보
public struct PaceSegment: Sendable, Identifiable {
    public let id = UUID()
    public let startCoordinate: CLLocationCoordinate2D
    public let endCoordinate: CLLocationCoordinate2D
    public let speedCategory: SpeedCategory
    public let speedMs: Double
    
    public init(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D, speedCategory: SpeedCategory, speedMs: Double) {
        self.startCoordinate = startCoordinate
        self.endCoordinate = endCoordinate
        self.speedCategory = speedCategory
        self.speedMs = speedMs
    }
}

/// 정적 운동 시 산출된 중심 대표 좌표
public struct StaticLocationSummary: Sendable {
    public let centerCoordinate: CLLocationCoordinate2D
    public let sampleCount: Int
    
    public init(centerCoordinate: CLLocationCoordinate2D, sampleCount: Int) {
        self.centerCoordinate = centerCoordinate
        self.sampleCount = sampleCount
    }
}
