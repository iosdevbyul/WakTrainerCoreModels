//
//  HealthSnapshot.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-30.
//

import Foundation

/// HealthKit 등을 통해 수집된 건강 및 활동 측정 지표 데이터
public struct HealthSnapshot: Codable, Equatable {
    public var heartRate: Double         // 심박수 (BPM)
    public var stepCount: Double        // 걸음 수
    public var activeCalories: Double     // 소모 칼로리 (kcal)
    public var distance: Double           // 이동 거리 (m)
    
    public init(
        heartRate: Double = 0.0,
        stepCount: Double = 0.0,
        activeCalories: Double = 0.0,
        distance: Double = 0.0
    ) {
        self.heartRate = heartRate
        self.stepCount = stepCount
        self.activeCalories = activeCalories
        self.distance = distance
    }
}
