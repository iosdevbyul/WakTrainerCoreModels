//
//  TimerManagerProtocol.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-31.
//

import Foundation
import Combine

@MainActor
public protocol TimerManagerProtocol: ObservableObject {
    var elapsedTime: TimeInterval { get }
    var isRunning: Bool { get }
    var formattedTime: String { get }
    
    func start()
    func pause()
    func stop()
}

// 공통 연산 프로퍼티는 protocol extension으로 기본 구현을 제공할 수 있습니다.
public extension TimerManagerProtocol {
    var formattedTime: String {
        let totalSeconds = Int(elapsedTime)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
