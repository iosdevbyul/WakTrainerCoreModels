//
//  UserProfileManager.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-23.
//

import Foundation

public protocol UserProfileManager: Sendable {
    var profile: UserProfile? { get async }
    
    func saveProfile(_ profile: UserProfile) async
    func loadProfile() async -> UserProfile?
}
