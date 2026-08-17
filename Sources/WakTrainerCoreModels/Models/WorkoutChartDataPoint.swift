//
//  WorkoutChartDataPoint.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-17.
//

import Foundation

public struct WorkoutChartDataPoint: Identifiable, Sendable {
    public let id: UUID
    public let date: Date
    public let heartRate: Double  // bpm
    public let calorie: Double    // 누적 kcal
    
    public init(id: UUID = UUID(), date: Date, heartRate: Double, calorie: Double) {
        self.id = id
        self.date = date
        self.heartRate = heartRate
        self.calorie = calorie
    }
}
