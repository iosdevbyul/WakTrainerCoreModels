//
//  UserProfile.swift
//  WakTrainerCoreModels
//
//  Created by COMATOKI on 2026-08-22.
//

import Foundation

// MARK: - User Profile Model
public struct UserProfile: Codable, Equatable, Sendable {
    public var gender: Gender
    public var birthDate: Date
    public var heightCm: Double
    public var weightKg: Double
    
    public var age: Int {
        Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
    }
    
    public init(gender: Gender, birthDate: Date, heightCm: Double, weightKg: Double) {
        self.gender = gender
        self.birthDate = birthDate
        self.heightCm = heightCm
        self.weightKg = weightKg
    }
    
    public enum Gender: String, Codable, CaseIterable, Sendable {
        case male = "남성"
        case female = "여성"
        case other = "기타"
    }
}
