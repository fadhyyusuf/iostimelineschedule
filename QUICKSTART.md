# Quick Start Guide - iOS Timeline Schedule

This guide will help you get started with the Timeline Schedule library for iOS in just a few minutes.

## Installation

### Using Swift Package Manager (Recommended)

1. **In Xcode:**
   - File > Add Packages...
   - Enter: `https://github.com/fadhyyusuf/ios-timeline-schedule`
   - Select version or branch
   - Click "Add Package"

2. **In Package.swift:**

```swift
dependencies: [
    .package(url: "https://github.com/fadhyyusuf/ios-timeline-schedule.git", from: "1.0.0")
]
```

---

## Basic Implementation

### Step 1: Import the Library

```swift
import UIKit
import TimelineSchedule
```

### Step 2: Create Timeline View

```swift
class ViewController: UIViewController {
    
    private let timelineView = TimelineScheduleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimeline()
    }
    
    private func setupTimeline() {
        // Add to view hierarchy
        view.addSubview(timelineView)
        timelineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timelineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timelineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timelineView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
```

### Step 3: Create Appointments

```swift
private func createSampleAppointments() -> [Appointment] {
    return [
        Appointment(
            id: "1",
            title: "Morning Meeting",
            subtitle: "Team Sync",
            startTime: TimeUtils.createTime(hour: 9, minute: 0),
            endTime: TimeUtils.createTime(hour: 10, minute: 0),
            color: .systemBlue,
            backgroundColor: .systemBackground
        ),
        Appointment(
            id: "2",
            title: "Doctor Appointment",
            subtitle: "Dr. Smith - General Checkup",
            startTime: TimeUtils.createTime(hour: 11, minute: 0),
            endTime: TimeUtils.createTime(hour: 12, minute: 0),
            color: .systemGreen,
            backgroundColor: .systemBackground
        ),
        Appointment(
            id: "3",
            title: "Lunch Break",
            subtitle: "Restaurant",
            startTime: TimeUtils.createTime(hour: 13, minute: 0),
            endTime: TimeUtils.createTime(hour: 14, minute: 0),
            color: .systemOrange,
            backgroundColor: .systemBackground
        )
    ]
}
```

### Step 4: Configure and Display

```swift
private func setupTimeline() {
    // ... view setup code from Step 2 ...
    
    // Configure timeline
    var config = TimelineConfig()
    config.hourHeight = 120
    config.use24HourFormat = false
    config.showGridLines = true
    config.showCurrentTimeIndicator = true
    config.currentTimeIndicatorColor = .systemRed
    
    timelineView.setConfig(config)
    
    // Set appointments
    let appointments = createSampleAppointments()
    timelineView.setAppointments(appointments)
    
    // Handle taps
    timelineView.onAppointmentTap = { appointment in
        print("Tapped: \(appointment.title)")
        // Show details, navigate, etc.
    }
    
    // Optional: Scroll to current time
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
        self?.timelineView.scrollToCurrentTime()
    }
}
```

### Step 5: Run Your App

Build and run your app. You should see a timeline view with your appointments displayed!

---

## Common Customizations

### Use 24-Hour Format

```swift
var config = TimelineConfig()
config.use24HourFormat = true
```

### Custom Colors

```swift
var config = TimelineConfig()
config.gridLineColor = .systemGray5
config.timeLabelColor = .label
config.currentTimeIndicatorColor = .systemRed
```

### Adjust Hour Height

```swift
var config = TimelineConfig()
config.hourHeight = 150  // Taller hours for more detail
```

### Custom Card Styling

```swift
var config = TimelineConfig()
config.cardCornerRadius = 12
config.cardShadowOpacity = 0.2
config.cardShadowRadius = 4
```

### Hide Grid Lines

```swift
var config = TimelineConfig()
config.showGridLines = false
config.showVerticalDivider = false
```

---

## Advanced Usage

### Dynamic Appointment Updates

```swift
func updateAppointments() {
    let newAppointments = fetchAppointmentsFromAPI()
    timelineView.setAppointments(newAppointments)
}
```

### Custom Time Labels

```swift
var config = TimelineConfig()
config.customTimeLabels = [
    "Early Morning",
    "Morning",
    "Late Morning",
    "Noon",
    "Afternoon",
    "Evening",
    "Night"
]
timelineView.setConfig(config)
```

### Handling Long Press

```swift
timelineView.onAppointmentLongPress = { appointment in
    let alert = UIAlertController(
        title: "Options",
        message: "What would you like to do?",
        preferredStyle: .actionSheet
    )
    
    alert.addAction(UIAlertAction(title: "Edit", style: .default) { _ in
        // Edit appointment
    })
    
    alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
        // Delete appointment
    })
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    self.present(alert, animated: true)
}
```

### Programmatic Scrolling

```swift
// Scroll to specific time
let date = TimeUtils.createTime(hour: 14, minute: 30)
timelineView.scrollToTime(date)

// Scroll to current time
timelineView.scrollToCurrentTime()
```

---

## Troubleshooting

### Appointments Not Showing

- Ensure `startTime` is before `endTime`
- Check that times are set for today (use `TimeUtils.createTime()`)
- Verify appointments array is not empty

### Layout Issues

- Make sure to set proper constraints
- Call `setNeedsLayout()` after configuration changes
- Check that parent view has proper frame

### Current Time Indicator Not Visible

- Ensure current time is within appointment range
- Set `config.showCurrentTimeIndicator = true`
- Check indicator color contrast with background

---

## Next Steps

- Check out the [full README](README.md) for complete API documentation
- Explore the example app in the `Example/` folder
- Customize colors and styling to match your app's design

---

## Support

- GitHub Issues: [Report a bug](https://github.com/fadhyyusuf/ios-timeline-schedule/issues)
- Questions: Open a discussion on GitHub

---

Made with ❤️ and AI assistance
