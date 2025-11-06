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
            Appointment(
                id: "1",
                title: "Abril Lewis",
                subtitle: "Physician",
                startTime: TimeUtils.createTime(hour: 8, minute: 0),
                endTime: TimeUtils.createTime(hour: 8, minute: 30),
                color: UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                backgroundColor: UIColor(red: 243/255, green: 229/255, blue: 245/255, alpha: 1.0)
            ),
            Appointment(
                id: "2",
                title: "Angelica Ramos",
                subtitle: "Psychologist",
                startTime: TimeUtils.createTime(hour: 9, minute: 0),
                endTime: TimeUtils.createTime(hour: 10, minute: 0),
                color: UIColor(red: 233/255, green: 30/255, blue: 99/255, alpha: 1.0),
                backgroundColor: UIColor(red: 252/255, green: 228/255, blue: 236/255, alpha: 1.0)
            ),
            Appointment(
                id: "3",
                title: "Ashton Cox",
                subtitle: "Nurse Practitioner",
                startTime: TimeUtils.createTime(hour: 9, minute: 30),
                endTime: TimeUtils.createTime(hour: 11, minute: 0),
                color: UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1.0),
                backgroundColor: UIColor(red: 255/255, green: 243/255, blue: 224/255, alpha: 1.0)
            ),
            Appointment(
                id: "4",
                title: "Bradley Greer",
                subtitle: "Dentist",
                startTime: TimeUtils.createTime(hour: 10, minute: 0),
                endTime: TimeUtils.createTime(hour: 11, minute: 30),
                color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0),
                backgroundColor: UIColor(red: 227/255, green: 242/255, blue: 253/255, alpha: 1.0)
            ),
            Appointment(
                id: "5",
                title: "Caesar Vance",
                subtitle: "Orthopedic Surgeon",
                startTime: TimeUtils.createTime(hour: 12, minute: 0),
                endTime: TimeUtils.createTime(hour: 13, minute: 0),
                color: UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0),
                backgroundColor: UIColor(red: 232/255, green: 245/255, blue: 233/255, alpha: 1.0)
            ),
            Appointment(
                id: "6",
                title: "Cara Stevens",
                subtitle: "Dermatologist",
                startTime: TimeUtils.createTime(hour: 13, minute: 0),
                endTime: TimeUtils.createTime(hour: 14, minute: 30),
                color: UIColor(red: 103/255, green: 58/255, blue: 183/255, alpha: 1.0),
                backgroundColor: UIColor(red: 237/255, green: 231/255, blue: 246/255, alpha: 1.0)
            ),
            Appointment(
                id: "7",
                title: "Cedric Kelly",
                subtitle: "Cardiologist",
                startTime: TimeUtils.createTime(hour: 14, minute: 0),
                endTime: TimeUtils.createTime(hour: 15, minute: 30),
                color: UIColor(red: 0/255, green: 150/255, blue: 136/255, alpha: 1.0),
                backgroundColor: UIColor(red: 224/255, green: 242/255, blue: 241/255, alpha: 1.0)
            ),
            Appointment(
                id: "8",
                title: "Charde Marshall",
                subtitle: "Pediatrician",
                startTime: TimeUtils.createTime(hour: 15, minute: 0),
                endTime: TimeUtils.createTime(hour: 16, minute: 0),
                color: UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0),
                backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 238/255, alpha: 1.0)
            ),
            Appointment(
                id: "9",
                title: "Colleen Hurst",
                subtitle: "Neurologist",
                startTime: TimeUtils.createTime(hour: 16, minute: 30),
                endTime: TimeUtils.createTime(hour: 17, minute: 30),
                color: UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1.0),
                backgroundColor: UIColor(red: 232/255, green: 234/255, blue: 246/255, alpha: 1.0)
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
