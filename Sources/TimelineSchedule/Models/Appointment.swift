//
//  Appointment.swift
//  TimelineSchedule
//
//  ⚠️ AI-GENERATED PROJECT DISCLAIMER
//  This project was created with the assistance of Artificial Intelligence (AI).
//  While the code has been reviewed and tested, users should verify functionality
//  for their specific use cases.
//
//  Copyright (c) 2025 Fadhy Yusuf
//  Licensed under the MIT License
//

import Foundation
import UIKit

/// Represents an appointment or event in the timeline
public struct Appointment {
    
    // MARK: - Properties
    
    /// Unique identifier for the appointment
    public let id: String
    
    /// Main title of the appointment
    public let title: String
    
    /// Optional subtitle or description
    public let subtitle: String?
    
    /// Start time of the appointment
    public let startTime: Date
    
    /// End time of the appointment
    public let endTime: Date
    
    /// Color for the appointment border/accent
    public let color: UIColor
    
    /// Background color for the appointment card
    public let backgroundColor: UIColor
    
    /// Optional avatar image URL
    public let avatarURL: String?
    
    // Calculated properties for layout (set by overlap manager)
    internal var column: Int = 0
    internal var totalColumns: Int = 1
    
    // MARK: - Initialization
    
    /// Creates a new appointment
    /// - Parameters:
    ///   - id: Unique identifier
    ///   - title: Main title
    ///   - subtitle: Optional subtitle
    ///   - startTime: Start time
    ///   - endTime: End time
    ///   - color: Border/accent color
    ///   - backgroundColor: Card background color
    ///   - avatarURL: Optional avatar image URL
    public init(
        id: String,
        title: String,
        subtitle: String? = nil,
        startTime: Date,
        endTime: Date,
        color: UIColor = .systemBlue,
        backgroundColor: UIColor = .white,
        avatarURL: String? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.startTime = startTime
        self.endTime = endTime
        self.color = color
        self.backgroundColor = backgroundColor
        self.avatarURL = avatarURL
    }
    
    // MARK: - Helper Methods
    
    /// Duration of the appointment in minutes
    public var durationInMinutes: Int {
        let duration = endTime.timeIntervalSince(startTime)
        return Int(duration / 60)
    }
    
    /// Check if this appointment overlaps with another
    /// - Parameter other: Another appointment to check
    /// - Returns: True if appointments overlap
    public func overlaps(with other: Appointment) -> Bool {
        return startTime < other.endTime && endTime > other.startTime
    }
}

// MARK: - Equatable

extension Appointment: Equatable {
    public static func == (lhs: Appointment, rhs: Appointment) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Hashable

extension Appointment: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
