//
//  LocationManagerProtocol.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-31.
//

import Combine

@MainActor
public protocol LocationManagerProtocol: ObservableObject {
    /// 현재 사용자 위치
    var userLocation: WorkoutRoutePoint? { get }

    /// 운동 중 수집된 전체 위치 샘플
    var routePoints: [WorkoutRoutePoint] { get }

    /// 트래킹 중 여부
    var isTracking: Bool { get }

    /// 위치 권한 요청
    func requestLocationPermission()

    /// 위치 트래킹 시작
    func startTracking()

    /// 위치 트래킹 중단
    func stopTracking()
}
