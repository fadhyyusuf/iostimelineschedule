//
//  OverlapManager.swift
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

/// Manages the layout of overlapping appointments
class OverlapManager {
    
    /// Positioned appointment with column information
    struct PositionedAppointment {
        let appointment: Appointment
        let column: Int
        let totalColumns: Int
    }
    
    /// Calculate column positions for overlapping appointments
    /// - Parameter appointments: List of appointments to position
    /// - Returns: List of positioned appointments with column information
    func calculatePositions(_ appointments: [Appointment]) -> [PositionedAppointment] {
        guard !appointments.isEmpty else { return [] }
        
        // Sort appointments by start time
        let sorted = appointments.sorted { $0.startTime < $1.startTime }
        
        var positioned: [PositionedAppointment] = []
        var groups: [[Appointment]] = []
        
        // Group overlapping appointments
        for appointment in sorted {
            var addedToGroup = false
            
            for i in 0..<groups.count {
                // Check if appointment overlaps with any in this group
                if groups[i].contains(where: { $0.overlaps(with: appointment) }) {
                    groups[i].append(appointment)
                    addedToGroup = true
                    break
                }
            }
            
            // Create new group if doesn't overlap with existing groups
            if !addedToGroup {
                groups.append([appointment])
            }
        }
        
        // Calculate columns for each group
        for group in groups {
            let groupPositioned = calculateGroupColumns(group)
            positioned.append(contentsOf: groupPositioned)
        }
        
        return positioned
    }
    
    /// Calculate column positions for a group of overlapping appointments
    private func calculateGroupColumns(_ group: [Appointment]) -> [PositionedAppointment] {
        guard !group.isEmpty else { return [] }
        
        if group.count == 1 {
            return [PositionedAppointment(
                appointment: group[0],
                column: 0,
                totalColumns: 1
            )]
        }
        
        // Sort by start time
        let sorted = group.sorted { $0.startTime < $1.startTime }
        
        var columns: [[Appointment]] = []
        var positioned: [PositionedAppointment] = []
        
        for appointment in sorted {
            var assignedColumn = -1
            
            // Try to find an available column
            for (index, column) in columns.enumerated() {
                let canPlace = !column.contains { existing in
                    existing.overlaps(with: appointment)
                }
                
                if canPlace {
                    assignedColumn = index
                    break
                }
            }
            
            // Create new column if needed
            if assignedColumn == -1 {
                assignedColumn = columns.count
                columns.append([])
            }
            
            columns[assignedColumn].append(appointment)
        }
        
        let totalColumns = columns.count
        
        // Create positioned appointments
        for (columnIndex, column) in columns.enumerated() {
            for appointment in column {
                positioned.append(PositionedAppointment(
                    appointment: appointment,
                    column: columnIndex,
                    totalColumns: totalColumns
                ))
            }
        }
        
        return positioned
    }
}
