//
//  HealthKitManagerProtocol.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-31.
//

import Foundation

public protocol HealthKitManagerProtocol: Sendable {
    /// 권한 승인 여부
    var isAuthorized: Bool { get async }

    /// HealthKit 데이터 읽기 권한 요청
    func requestAuthorization() async throws -> Bool

    /// 실시간 데이터 관측 시작
    func startObservingData() -> AsyncStream<HealthSnapshot>

    /// 실시간 데이터 관측 중단
    func stopObservingData() async

    /// 운동 종료 후 운동 시간 범위의 원본 HealthKit 샘플과 요약 데이터를 조회
    func fetchWorkoutHealthData(
        from startDate: Date,
        to endDate: Date
    ) async throws -> WorkoutHealthData
}

public extension HealthKitManagerProtocol {
    func fetchWorkoutHealthData(
        from startDate: Date,
        to endDate: Date
    ) async throws -> WorkoutHealthData {
        WorkoutHealthData()
    }
}
