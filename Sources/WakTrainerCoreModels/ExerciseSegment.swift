//
//  ExerciseSegment.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-30.
//

import Foundation

/// 운동 세션 내 개별 운동 구간을 나타내는 모델 (예: 15:40 ~ 22:42 스쿼트)
public struct ExerciseSegment: Identifiable, Codable, Equatable {
    public let id: UUID
    public var name: String            // 운동 이름 (예: "벤치프레스", "스쿼트")
    public let startTime: Date         // 해당 구간 시작 시간
    public var endTime: Date?          // 해당 구간 종료 시간
    
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
    
    /// 해당 구간의 소요 시간(초) 계산
    public var duration: TimeInterval {
        let end = endTime ?? Date()
        return end.timeIntervalSince(startTime)
    }
}
