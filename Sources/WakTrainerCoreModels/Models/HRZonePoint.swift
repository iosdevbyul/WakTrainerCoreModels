//
//  HRZonePoint.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-18.
//

import Foundation
import SwiftUI

public struct HRZonePoint: Identifiable, Sendable {
    public let id: UUID
    public let zone: Int          // 구간 (1~5)
    public let percentage: Double // 0.0 ~ 1.0 (해당 구간의 비율)
    public let label: String      // Zone 1, Zone 2 등
    public let color: Color       // 이미지와 동일한 색상
    
    public init(id: UUID = UUID(), zone: Int, percentage: Double, label: String, color: Color) {
        self.id = id
        self.zone = zone
        self.percentage = percentage
        self.label = label
        self.color = color
    }
}
