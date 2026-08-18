//
//  PaceHRDataPoint.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-18.
//

import Foundation

public struct PaceHRDataPoint: Identifiable, Sendable {
    public let id: UUID
    public let distanceKm: Double  // x축: 거리 (km)
    public let paceMinKm: Double   // 좌측 Y축: 페이스 (분/km)
    public let heartRateBpm: Double // 우측 Y축: 심박수 (bpm)
    
    public init(id: UUID = UUID(), distanceKm: Double, paceMinKm: Double, heartRateBpm: Double) {
        self.id = id
        self.distanceKm = distanceKm
        self.paceMinKm = paceMinKm
        self.heartRateBpm = heartRateBpm
    }
}
