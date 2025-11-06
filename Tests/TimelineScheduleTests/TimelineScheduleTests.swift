//
//  TimelineScheduleTests.swift
//  TimelineScheduleTests
//
//  Tests for TimelineSchedule library
//

import XCTest
@testable import TimelineSchedule

final class TimelineScheduleTests: XCTestCase {
    
    // MARK: - Appointment Tests
    
    func testAppointmentCreation() {
        let appointment = Appointment(
            id: "1",
            title: "Test Appointment",
            subtitle: "Test Subtitle",
            startTime: TimeUtils.createTime(hour: 9, minute: 0),
            endTime: TimeUtils.createTime(hour: 10, minute: 0),
            color: .blue,
            backgroundColor: .white
        )
        
        XCTAssertEqual(appointment.id, "1")
        XCTAssertEqual(appointment.title, "Test Appointment")
        XCTAssertEqual(appointment.subtitle, "Test Subtitle")
    }
    
    func testAppointmentDuration() {
        let appointment = Appointment(
            id: "1",
            title: "Test",
            startTime: TimeUtils.createTime(hour: 9, minute: 0),
            endTime: TimeUtils.createTime(hour: 10, minute: 30),
            color: .blue,
            backgroundColor: .white
        )
        
        XCTAssertEqual(appointment.durationInMinutes, 90)
    }
    
    func testAppointmentOverlap() {
        let appointment1 = Appointment(
            id: "1",
            title: "First",
            startTime: TimeUtils.createTime(hour: 9, minute: 0),
            endTime: TimeUtils.createTime(hour: 10, minute: 0),
            color: .blue,
            backgroundColor: .white
        )
        
        let appointment2 = Appointment(
            id: "2",
            title: "Second",
            startTime: TimeUtils.createTime(hour: 9, minute: 30),
            endTime: TimeUtils.createTime(hour: 10, minute: 30),
            color: .blue,
            backgroundColor: .white
        )
        
        let appointment3 = Appointment(
            id: "3",
            title: "Third",
            startTime: TimeUtils.createTime(hour: 11, minute: 0),
            endTime: TimeUtils.createTime(hour: 12, minute: 0),
            color: .blue,
            backgroundColor: .white
        )
        
        XCTAssertTrue(appointment1.overlaps(with: appointment2))
        XCTAssertTrue(appointment2.overlaps(with: appointment1))
        XCTAssertFalse(appointment1.overlaps(with: appointment3))
        XCTAssertFalse(appointment3.overlaps(with: appointment1))
    }
    
    // MARK: - TimeUtils Tests
    
    func testTimeUtilsCreateTime() {
        let date = TimeUtils.createTime(hour: 15, minute: 30)
        let hour = TimeUtils.getHour(from: date)
        let minute = TimeUtils.getMinute(from: date)
        
        XCTAssertEqual(hour, 15)
        XCTAssertEqual(minute, 30)
    }
    
    func testTimeUtilsMinutesFromMidnight() {
        let date = TimeUtils.createTime(hour: 10, minute: 30)
        let minutes = TimeUtils.minutesFromMidnight(date)
        
        XCTAssertEqual(minutes, 630) // 10 * 60 + 30
    }
    
    func testTimeUtilsFormatTime12Hour() {
        let date = TimeUtils.createTime(hour: 14, minute: 30)
        let formatted = TimeUtils.formatTime(date, use24Hour: false)
        
        XCTAssertTrue(formatted.contains("2") || formatted.contains("14"))
        XCTAssertTrue(formatted.contains("30"))
    }
    
    func testTimeUtilsFormatTime24Hour() {
        let date = TimeUtils.createTime(hour: 14, minute: 30)
        let formatted = TimeUtils.formatTime(date, use24Hour: true)
        
        XCTAssertTrue(formatted.contains("14"))
        XCTAssertTrue(formatted.contains("30"))
    }
    
    // MARK: - TimelineConfig Tests
    
    func testTimelineConfigDefaults() {
        let config = TimelineConfig()
        
        XCTAssertEqual(config.timeColumnWidth, 80)
        XCTAssertEqual(config.hourHeight, 100)
        XCTAssertTrue(config.showGridLines)
        XCTAssertTrue(config.showCurrentTimeIndicator)
        XCTAssertFalse(config.use24HourFormat)
    }
    
    func testTimelineConfigCustomization() {
        var config = TimelineConfig()
        config.hourHeight = 150
        config.use24HourFormat = true
        config.showGridLines = false
        
        XCTAssertEqual(config.hourHeight, 150)
        XCTAssertTrue(config.use24HourFormat)
        XCTAssertFalse(config.showGridLines)
    }
    
    // MARK: - OverlapManager Tests
    
    func testOverlapManagerNoOverlap() {
        let manager = OverlapManager()
        
        let appointments = [
            Appointment(
                id: "1",
                title: "First",
                startTime: TimeUtils.createTime(hour: 9, minute: 0),
                endTime: TimeUtils.createTime(hour: 10, minute: 0),
                color: .blue,
                backgroundColor: .white
            ),
            Appointment(
                id: "2",
                title: "Second",
                startTime: TimeUtils.createTime(hour: 11, minute: 0),
                endTime: TimeUtils.createTime(hour: 12, minute: 0),
                color: .blue,
                backgroundColor: .white
            )
        ]
        
        let positioned = manager.calculatePositions(appointments)
        
        XCTAssertEqual(positioned.count, 2)
        XCTAssertTrue(positioned.allSatisfy { $0.totalColumns == 1 })
    }
    
    func testOverlapManagerWithOverlap() {
        let manager = OverlapManager()
        
        let appointments = [
            Appointment(
                id: "1",
                title: "First",
                startTime: TimeUtils.createTime(hour: 9, minute: 0),
                endTime: TimeUtils.createTime(hour: 10, minute: 0),
                color: .blue,
                backgroundColor: .white
            ),
            Appointment(
                id: "2",
                title: "Second",
                startTime: TimeUtils.createTime(hour: 9, minute: 30),
                endTime: TimeUtils.createTime(hour: 10, minute: 30),
                color: .blue,
                backgroundColor: .white
            )
        ]
        
        let positioned = manager.calculatePositions(appointments)
        
        XCTAssertEqual(positioned.count, 2)
        
        // Both should have totalColumns = 2 since they overlap
        XCTAssertTrue(positioned.allSatisfy { $0.totalColumns == 2 })
        
        // They should be in different columns
        let columns = positioned.map { $0.column }
        XCTAssertNotEqual(columns[0], columns[1])
    }
    
    func testOverlapManagerMultipleOverlaps() {
        let manager = OverlapManager()
        
        let appointments = [
            Appointment(
                id: "1",
                title: "First",
                startTime: TimeUtils.createTime(hour: 9, minute: 0),
                endTime: TimeUtils.createTime(hour: 11, minute: 0),
                color: .blue,
                backgroundColor: .white
            ),
            Appointment(
                id: "2",
                title: "Second",
                startTime: TimeUtils.createTime(hour: 9, minute: 30),
                endTime: TimeUtils.createTime(hour: 10, minute: 30),
                color: .blue,
                backgroundColor: .white
            ),
            Appointment(
                id: "3",
                title: "Third",
                startTime: TimeUtils.createTime(hour: 10, minute: 0),
                endTime: TimeUtils.createTime(hour: 11, minute: 30),
                color: .blue,
                backgroundColor: .white
            )
        ]
        
        let positioned = manager.calculatePositions(appointments)
        
        XCTAssertEqual(positioned.count, 3)
        
        // All three overlap at some point
        let maxColumns = positioned.map { $0.totalColumns }.max() ?? 0
        XCTAssertGreaterThan(maxColumns, 1)
    }
}
