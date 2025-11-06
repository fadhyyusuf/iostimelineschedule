# Timeline Schedule - iOS Library

> **⚠️ AI-Generated Project Disclaimer**  
> This project was created with the assistance of Artificial Intelligence (AI). While the code has been reviewed and tested, users should verify functionality for their specific use cases.

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/)
[![Swift Version](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)
[![iOS Version](https://img.shields.io/badge/iOS-13.0+-green.svg)](https://www.apple.com/ios/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

A modern, flexible, and customizable timeline schedule view library for iOS applications built with UIKit. Perfect for appointment booking systems, calendar views, scheduling apps, and any application that needs to display time-based events in a vertical timeline format.

## ✨ Features

- 📅 **Vertical Timeline Layout** - Display appointments in a clean, scrollable vertical timeline
- ⏰ **Flexible Time Range** - Support for 12-hour and 24-hour formats
- 🎨 **Fully Customizable** - Colors, sizes, fonts, and styling options
- 📱 **Responsive Design** - Automatic column layout for overlapping appointments
- 🔍 **Current Time Indicator** - Real-time visual indicator showing current time
- 🎯 **Touch Handlers** - Handle appointment taps and long presses with ease
- 🏷️ **Custom Time Labels** - Set your own time labels
- 🌈 **Color Coding** - Distinguish appointments by color
- ⚡ **Smooth Scrolling** - Optimized performance for large datasets
- 📐 **Grid Lines** - Optional grid lines for better time visualization
- 🔄 **Real-time Updates** - Dynamically update appointments
- 🎨 **UIKit Based** - Built entirely with UIKit for maximum compatibility

## 📸 Screenshots

*Coming soon*

---

## 🚀 Quick Start

### Installation

#### Swift Package Manager

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/fadhyyusuf/ios-timeline-schedule.git", from: "1.0.0")
]
```

Or add it via Xcode:
1. File > Add Packages...
2. Enter repository URL: `https://github.com/fadhyyusuf/ios-timeline-schedule`
3. Select version or branch
4. Click "Add Package"

### Basic Usage

1. **Import the library:**

```swift
import TimelineSchedule
```

2. **Create and configure the timeline view:**

```swift
import UIKit
import TimelineSchedule

class ViewController: UIViewController {
    
    private let timelineView = TimelineScheduleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add to view hierarchy
        view.addSubview(timelineView)
        timelineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timelineView.topAnchor.constraint(equalTo: view.topAnchor),
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
        
        timelineView.setConfig(config)
        
        // Set appointments
        let appointments = createAppointments()
        timelineView.setAppointments(appointments)
        
        // Handle taps
        timelineView.onAppointmentTap = { appointment in
            print("Tapped: \(appointment.title)")
        }
    }
    
    private func createAppointments() -> [Appointment] {
        return [
            Appointment(
                id: "1",
                title: "Doctor Appointment",
                subtitle: "Dr. Smith",
                startTime: TimeUtils.createTime(hour: 8, minute: 0),
                endTime: TimeUtils.createTime(hour: 9, minute: 0),
                color: .systemBlue,
                backgroundColor: .systemBackground
            ),
            Appointment(
                id: "2",
                title: "Team Meeting",
                subtitle: "Conference Room A",
                startTime: TimeUtils.createTime(hour: 10, minute: 0),
                endTime: TimeUtils.createTime(hour: 11, minute: 30),
                color: .systemGreen,
                backgroundColor: .systemBackground
            )
        ]
    }
}
```

---

## 🎨 Customization

### Timeline Configuration

```swift
var config = TimelineConfig()

// Time column settings
config.timeColumnWidth = 80
config.timeLabelFontSize = 12
config.timeLabelColor = .systemGray
config.hourHeight = 120

// Custom time labels (optional)
config.customTimeLabels = [
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    // ... more labels
]

// Grid settings
config.showGridLines = true
config.gridLineColor = .systemGray4
config.gridLineWidth = 1

// Divider settings
config.showVerticalDivider = true
config.verticalDividerColor = .systemGray4
config.verticalDividerWidth = 2

// Current time indicator
config.showCurrentTimeIndicator = true
config.currentTimeIndicatorColor = .systemRed
config.currentTimeIndicatorWidth = 2
config.currentTimeDotRadius = 6

// Card styling
config.appointmentPadding = 4
config.cardCornerRadius = 8
config.cardShadowOpacity = 0.1
config.cardShadowRadius = 2

// Text styling
config.titleFontSize = 14
config.subtitleFontSize = 12
config.titleFontWeight = .semibold
config.subtitleFontWeight = .regular

// Time format
config.use24HourFormat = false

timelineView.setConfig(config)
```

### Custom Time Labels

You can set custom time labels instead of using the default hourly labels:

```swift
var config = TimelineConfig()
config.customTimeLabels = [
    "Early Morning",
    "Morning",
    "Late Morning",
    "Noon",
    "Afternoon",
    "Evening"
]

timelineView.setConfig(config)
```

---

## 📖 API Reference

### TimelineScheduleView

Main view component for displaying appointments.

**Properties:**

```swift
var config: TimelineConfig { get set }
var appointments: [Appointment] { get set }
var onAppointmentTap: ((Appointment) -> Void)? { get set }
var onAppointmentLongPress: ((Appointment) -> Void)? { get set }
```

**Methods:**

```swift
func setAppointments(_ appointments: [Appointment])
func setConfig(_ config: TimelineConfig)
func scrollToTime(_ date: Date)
func scrollToCurrentTime()
```

### Appointment

Represents an appointment or event in the timeline.

```swift
public struct Appointment {
    let id: String
    let title: String
    let subtitle: String?
    let startTime: Date
    let endTime: Date
    let color: UIColor
    let backgroundColor: UIColor
    let avatarURL: String?
    
    var durationInMinutes: Int { get }
    func overlaps(with other: Appointment) -> Bool
}
```

### TimelineConfig

Configuration object for customizing the timeline appearance.

See the **Customization** section above for all available configuration options.

### TimeUtils

Utility class for time operations.

```swift
static func formatTime(_ date: Date, use24Hour: Bool = false) -> String
static func getHour(from date: Date) -> Int
static func getMinute(from date: Date) -> Int
static func createTime(hour: Int, minute: Int = 0) -> Date
static func minutesFromMidnight(_ date: Date) -> Int
static func now() -> Date
static func isToday(_ date: Date) -> Bool
```

---

## 🔧 Requirements

- **iOS 13.0+**
- **Swift 5.7+**
- **Xcode 14.0+**
- **UIKit**

---

## 📱 Example App

The repository includes a complete example application demonstrating all features:

1. Clone the repository
2. Open `Example/TimelineScheduleExample.xcodeproj`
3. Run the app

---

## 🏗️ Architecture

### Components

```
TimelineSchedule/
├── Models/
│   ├── Appointment.swift        # Data model for appointments
│   └── TimelineConfig.swift     # Configuration data class
├── TimelineScheduleView.swift   # Main view component
└── Utils/
    ├── TimeUtils.swift          # Time utility functions
    └── OverlapManager.swift     # Overlap calculation logic
```

### Key Features Implementation

- **Custom UIScrollView**: Extends UIScrollView for smooth scrolling
- **Layer-based rendering**: Uses CAShapeLayer for efficient drawing
- **Smart overlap detection**: Automatic column layout calculation
- **Real-time updates**: Timer-based current time indicator
- **Gesture handling**: UITapGestureRecognizer and UILongPressGestureRecognizer

---

## 🎯 Use Cases

- 📅 **Appointment booking systems** (medical, salon, consulting)
- 🏢 **Meeting room schedulers**
- 🎓 **School/university timetables**
- 🏋️ **Gym class schedules**
- 🎭 **Event calendars**
- 📊 **Project timeline views**
- 🚗 **Service scheduling apps**

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

```
MIT License

Copyright (c) 2025 Fadhy Yusuf

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👤 Author

**Fadhy Yusuf**

- GitHub: [@fadhyyusuf](https://github.com/fadhyyusuf)
- Android Version: [timelineschedule](https://github.com/fadhyyusuf/timelineschedule)

---

## 🌟 Show Your Support

Give a ⭐️ if this project helped you!

---

## 📞 Contact

For questions, issues, or feature requests, please open an issue on GitHub.

---

## 🔄 Related Projects

- **Android Version**: [timelineschedule](https://github.com/fadhyyusuf/timelineschedule) - The original Android library

---

Made with ❤️ and AI assistance
