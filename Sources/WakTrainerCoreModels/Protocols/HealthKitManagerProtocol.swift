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
    
    /// 실시간 데이터 관측 시작 (AsyncStream을 통해 백그라운드에서 데이터를 받아옴)
    func startObservingData() -> AsyncStream<HealthSnapshot>
    
    /// 실시간 데이터 관측 중단
    func stopObservingData() async
}
