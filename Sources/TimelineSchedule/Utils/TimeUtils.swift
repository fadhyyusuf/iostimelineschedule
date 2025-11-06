//
//  TimeUtils.swift
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

/// Utility functions for time and date operations
class TimeUtils {
    
    /// Shared date formatters
    private static let timeFormatter12Hour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    private static let timeFormatter24Hour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    /// Format time for display
    /// - Parameters:
    ///   - date: Date to format
    ///   - use24Hour: Whether to use 24-hour format
    /// - Returns: Formatted time string
    static func formatTime(_ date: Date, use24Hour: Bool = false) -> String {
        let formatter = use24Hour ? timeFormatter24Hour : timeFormatter12Hour
        return formatter.string(from: date)
    }
    
    /// Get hour component from date
    /// - Parameter date: Date to extract hour from
    /// - Returns: Hour (0-23)
    static func getHour(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    /// Get minute component from date
    /// - Parameter date: Date to extract minute from
    /// - Returns: Minute (0-59)
    static func getMinute(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: date)
    }
    
    /// Create a date with specific hour and minute for today
    /// - Parameters:
    ///   - hour: Hour (0-23)
    ///   - minute: Minute (0-59)
    /// - Returns: Date with specified time
    static func createTime(hour: Int, minute: Int = 0) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components) ?? Date()
    }
    
    /// Calculate minutes from midnight
    /// - Parameter date: Date to calculate from
    /// - Returns: Minutes since midnight
    static func minutesFromMidnight(_ date: Date) -> Int {
        let hour = getHour(from: date)
        let minute = getMinute(from: date)
        return hour * 60 + minute
    }
    
    /// Get current time
    /// - Returns: Current date and time
    static func now() -> Date {
        return Date()
    }
    
    /// Check if a date is today
    /// - Parameter date: Date to check
    /// - Returns: True if date is today
    static func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
}
