//
//  HealthKitManagerProtocol.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-31.
//

import Foundation
import Combine

@MainActor
public protocol HealthKitManagerProtocol: ObservableObject {
    /// 현재 수집된 헬스 데이터 스냅샷
    var currentSnapshot: HealthSnapshot { get }
    
    /// 권한 승인 여부
    var isAuthorized: Bool { get }
    
    /// HealthKit 데이터 읽기 권한 요청
    func requestAuthorization(completion: @escaping @Sendable @MainActor (Bool) -> Void)
    
    /// 실시간 데이터 관측 시작
    func startObservingData()
    
    /// 실시간 데이터 관측 중단
    func stopObservingData()
}
