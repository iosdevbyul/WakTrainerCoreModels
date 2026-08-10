//
//  LocationManagerProtocol.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-31.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationManagerProtocol: ObservableObject {
    /// 현재 사용자 위치
    var userLocation: CLLocation? { get }
    
    /// 이동 경로 좌표 목록
    var routeCoordinates: [CLLocationCoordinate2D] { get }
    
    /// 트래킹 중 여부
    var isTracking: Bool { get }
    
    /// 위치 권한 요청
    func requestLocationPermission()
    
    /// 위치 트래킹 시작
    func startTracking()
    
    /// 위치 트래킹 중단
    func stopTracking()
}
