//
//  ChartDataPoint.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-17.
//

import Foundation

public struct ChartDataPoint: Identifiable {
    public let id = UUID()
    public let date: Date
    public let value: Double
    
    // Date 타입으로 직접 받는 이니셜라이저
    public init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }
    
    // 유닉스 타임스탬프(초 단위)로 받는 이니셜라이저
    public init(timestamp: TimeInterval, value: Double) {
        self.date = Date(timeIntervalSince1970: timestamp)
        self.value = value
    }
}
