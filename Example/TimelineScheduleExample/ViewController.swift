//
//  ViewController.swift
//  TimelineScheduleExample
//
//  Demo application for TimelineSchedule library
//

import UIKit
import TimelineSchedule

class ViewController: UIViewController {
    
    private let timelineView = TimelineScheduleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Timeline Schedule"
        view.backgroundColor = .systemBackground
        
        setupTimelineView()
        setupAppointments()
    }
    
    private func setupTimelineView() {
        // Add timeline view to view hierarchy
        view.addSubview(timelineView)
        timelineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timelineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timelineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timelineView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Configure timeline
        var config = TimelineConfig()
        config.hourHeight = 120
        config.use24HourFormat = false
        config.showGridLines = true
        config.showCurrentTimeIndicator = true
        config.currentTimeIndicatorColor = .systemRed
        // Set fixed time range from 7 AM to 9 PM (21:00)
        config.fixedStartHour = 7
        config.fixedEndHour = 21
        
        timelineView.setConfig(config)
        
        // Set up tap handler
        timelineView.onAppointmentTap = { [weak self] appointment in
            self?.showAppointmentDetails(appointment)
        }
    }
    
    private func setupAppointments() {
        let appointments = createSampleAppointments()
        timelineView.setAppointments(appointments)
        
        // Scroll to current time after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.timelineView.scrollToCurrentTime()
        }
    }
    
    private func createSampleAppointments() -> [Appointment] {
        return [
            // Early Morning (06:30 - 08:00) - Will be clipped at 7:00
            Appointment(
                id: "0",
                title: "Early Morning Meeting",
                subtitle: "Starts before visible range",
                startTime: TimeUtils.createTime(hour: 6, minute: 30),
                endTime: TimeUtils.createTime(hour: 8, minute: 0),
                color: UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1.0), // Orange
                backgroundColor: UIColor(red: 255/255, green: 243/255, blue: 224/255, alpha: 1.0)
            ),
            // Robert Fox - Checked out (08:00 - 08:45)
            Appointment(
                id: "1",
                title: "Robert Fox",
                subtitle: "Checked out",
                startTime: TimeUtils.createTime(hour: 8, minute: 0),
                endTime: TimeUtils.createTime(hour: 8, minute: 45),
                color: UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0), // Red
                backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 238/255, alpha: 1.0)
            ),
            // Abril Lewis - Physician (08:00 - 08:45)
            Appointment(
                id: "2",
                title: "Abril Lewis",
                subtitle: "Physician",
                startTime: TimeUtils.createTime(hour: 8, minute: 0),
                endTime: TimeUtils.createTime(hour: 8, minute: 45),
                color: UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0), // Purple
                backgroundColor: UIColor(red: 243/255, green: 229/255, blue: 245/255, alpha: 1.0)
            ),
            // Cody Fisher - Checked in (09:00 - 10:30)
            Appointment(
                id: "3",
                title: "Cody Fisher",
                subtitle: "Checked in",
                startTime: TimeUtils.createTime(hour: 9, minute: 0),
                endTime: TimeUtils.createTime(hour: 10, minute: 30),
                color: UIColor(red: 233/255, green: 30/255, blue: 99/255, alpha: 1.0), // Pink
                backgroundColor: UIColor(red: 252/255, green: 228/255, blue: 236/255, alpha: 1.0)
            ),
            // Annette Black - Checked in (09:15 - 10:45)
            Appointment(
                id: "4",
                title: "Annette Black",
                subtitle: "Checked in",
                startTime: TimeUtils.createTime(hour: 9, minute: 15),
                endTime: TimeUtils.createTime(hour: 10, minute: 45),
                color: UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0), // Purple
                backgroundColor: UIColor(red: 243/255, green: 229/255, blue: 245/255, alpha: 1.0)
            ),
            // Kathryn Murphy - Checked in (10:00 - 10:45)
            Appointment(
                id: "5",
                title: "Kathryn Murphy",
                subtitle: "Checked in",
                startTime: TimeUtils.createTime(hour: 10, minute: 0),
                endTime: TimeUtils.createTime(hour: 10, minute: 45),
                color: UIColor(red: 103/255, green: 58/255, blue: 183/255, alpha: 1.0), // Deep Purple
                backgroundColor: UIColor(red: 237/255, green: 231/255, blue: 246/255, alpha: 1.0)
            ),
            // Brooklyn Simmon - Confirmed (10:15 - 11:45)
            Appointment(
                id: "6",
                title: "Brooklyn Simmon",
                subtitle: "Confirmed",
                startTime: TimeUtils.createTime(hour: 10, minute: 15),
                endTime: TimeUtils.createTime(hour: 11, minute: 45),
                color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0), // Blue
                backgroundColor: UIColor(red: 227/255, green: 242/255, blue: 253/255, alpha: 1.0)
            ),
            // Arlene McCoy - Confirmed (11:00 - 11:30)
            Appointment(
                id: "7",
                title: "Arlene McCoy",
                subtitle: "Confirmed",
                startTime: TimeUtils.createTime(hour: 11, minute: 0),
                endTime: TimeUtils.createTime(hour: 11, minute: 30),
                color: UIColor(red: 0/255, green: 188/255, blue: 212/255, alpha: 1.0), // Cyan
                backgroundColor: UIColor(red: 224/255, green: 247/255, blue: 250/255, alpha: 1.0)
            ),
            // Seminar (12:00 - 13:30)
            Appointment(
                id: "8",
                title: "Seminar",
                subtitle: nil,
                startTime: TimeUtils.createTime(hour: 12, minute: 0),
                endTime: TimeUtils.createTime(hour: 13, minute: 30),
                color: UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1.0), // Blue Grey
                backgroundColor: UIColor(red: 236/255, green: 239/255, blue: 241/255, alpha: 1.0)
            ),
            // Late Evening (18:00 - 22:00) - Will be clipped at 21:00
            Appointment(
                id: "9",
                title: "Evening Event",
                subtitle: "Extends beyond visible range",
                startTime: TimeUtils.createTime(hour: 18, minute: 0),
                endTime: TimeUtils.createTime(hour: 22, minute: 0),
                color: UIColor(red: 103/255, green: 58/255, blue: 183/255, alpha: 1.0), // Deep Purple
                backgroundColor: UIColor(red: 237/255, green: 231/255, blue: 246/255, alpha: 1.0)
            )
        ]
    }
    
    private func showAppointmentDetails(_ appointment: Appointment) {
        let alert = UIAlertController(
            title: appointment.title,
            message: """
            \(appointment.subtitle ?? "")
            
            Time: \(TimeUtils.formatTime(appointment.startTime)) - \(TimeUtils.formatTime(appointment.endTime))
            Duration: \(appointment.durationInMinutes) minutes
            """,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
