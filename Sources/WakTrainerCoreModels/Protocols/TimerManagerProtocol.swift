//
//  TimerManagerProtocol.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-07-31.
//

import Foundation
import Combine

public protocol TimerManagerProtocol: ObservableObject {
    var elapsedTime: TimeInterval { get }
    var isRunning: Bool { get }
    var formattedTime: String { get }
    
    func start()
    func pause()
    func stop()
}

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
