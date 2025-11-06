# 🎉 iOS Timeline Schedule v1.0.0 - Release Notes

**First stable release of the iOS Timeline Schedule library!**

## ✨ What's New

This is the initial release of the iOS Timeline Schedule library - a native iOS port of the popular Android timeline library.

### Core Features

- 📅 **Vertical Timeline Layout** - Beautiful scrollable timeline view
- ⏰ **Flexible Time Formats** - Support for both 12-hour and 24-hour formats
- 🎨 **Fully Customizable** - 30+ configuration options for complete control
- 📱 **Smart Overlap Handling** - Automatic multi-column layout for overlapping appointments
- 🔍 **Real-time Indicator** - Current time indicator that updates automatically
- 🎯 **Gesture Support** - Tap and long press handlers included
- 🏷️ **Custom Labels** - Override default time labels with your own
- 🌈 **Color Coding** - Per-appointment colors and backgrounds
- ⚡ **Performance** - Smooth scrolling with efficient rendering
- 📐 **Visual Options** - Grid lines, dividers, shadows, and more

## 📦 Installation

### Swift Package Manager (Recommended)

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/fadhyyusuf/iostimelineschedule.git", from: "1.0.0")
]
```

### Xcode

1. File > Add Packages...
2. Enter repository URL: `https://github.com/fadhyyusuf/iostimelineschedule`
3. Select version 1.0.0
4. Click "Add Package"

## 🚀 Quick Example

```swift
import UIKit
import TimelineSchedule

class ViewController: UIViewController {
    
    private let timelineView = TimelineScheduleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add to view
        view.addSubview(timelineView)
        timelineView.frame = view.bounds
        
        // Configure
        var config = TimelineConfig()
        config.hourHeight = 120
        config.showCurrentTimeIndicator = true
        timelineView.setConfig(config)
        
        // Set appointments
        let appointments = [
            Appointment(
                id: "1",
                title: "Morning Meeting",
                subtitle: "Conference Room A",
                startTime: TimeUtils.createTime(hour: 9, minute: 0),
                endTime: TimeUtils.createTime(hour: 10, minute: 0),
                color: .systemBlue,
                backgroundColor: .systemBackground
            ),
            Appointment(
                id: "2",
                title: "Lunch Break",
                subtitle: "Restaurant",
                startTime: TimeUtils.createTime(hour: 12, minute: 0),
                endTime: TimeUtils.createTime(hour: 13, minute: 0),
                color: .systemOrange,
                backgroundColor: .systemBackground
            )
        ]
        
        timelineView.setAppointments(appointments)
        
        // Handle taps
        timelineView.onAppointmentTap = { appointment in
            print("Tapped: \(appointment.title)")
        }
    }
}
```

## 🎨 Customization Example

```swift
var config = TimelineConfig()

// Time settings
config.hourHeight = 150
config.use24HourFormat = false
config.timeColumnWidth = 80

// Visual settings
config.showGridLines = true
config.gridLineColor = .systemGray5
config.showVerticalDivider = true

// Current time indicator
config.showCurrentTimeIndicator = true
config.currentTimeIndicatorColor = .systemRed
config.currentTimeDotRadius = 6

// Card styling
config.cardCornerRadius = 12
config.cardShadowOpacity = 0.15
config.cardShadowRadius = 4

// Text styling
config.titleFontSize = 16
config.subtitleFontSize = 14
config.titleFontWeight = .semibold

timelineView.setConfig(config)
```

## 📚 Documentation

Complete documentation is available:

- **[README.md](https://github.com/fadhyyusuf/iostimelineschedule/blob/master/README.md)** - Main documentation
- **[QUICKSTART.md](https://github.com/fadhyyusuf/iostimelineschedule/blob/master/QUICKSTART.md)** - Step-by-step guide
- **[TECHNICAL.md](https://github.com/fadhyyusuf/iostimelineschedule/blob/master/TECHNICAL.md)** - Technical deep dive
- **[COMPARISON.md](https://github.com/fadhyyusuf/iostimelineschedule/blob/master/COMPARISON.md)** - iOS vs Android comparison

## 🔧 Requirements

- **iOS 13.0+** - Minimum deployment target
- **Swift 5.7+** - Language version
- **Xcode 14.0+** - Development environment
- **UIKit** - Framework (no dependencies)

## 🧪 Testing

The library includes comprehensive unit tests:

```bash
swift test
```

Or run tests in Xcode:
- Product > Test (⌘U)

## 📱 Example App

A complete example app is included in the repository:

```
Example/TimelineScheduleExample/ViewController.swift
```

Shows:
- Basic setup
- Multiple appointments
- Overlapping handling
- Event handlers
- Customization options

## 🔗 Related Projects

**Android Version**: [timelineschedule](https://github.com/fadhyyusuf/timelineschedule)

This iOS library provides 95%+ feature parity with the Android version.

## 🤝 Contributing

Contributions are welcome! Please feel free to:

- 🐛 Report bugs via [Issues](https://github.com/fadhyyusuf/iostimelineschedule/issues)
- 💡 Request features via [Issues](https://github.com/fadhyyusuf/iostimelineschedule/issues)
- 🔧 Submit pull requests
- 📖 Improve documentation
- ⭐ Star the project!

## 📝 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

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
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

## 🙏 Acknowledgments

- Built with ❤️ and AI assistance
- Based on the Android Timeline Schedule library
- Thanks to the iOS developer community

## 📞 Support

Need help? Have questions?

- 📖 Check the [documentation](https://github.com/fadhyyusuf/iostimelineschedule)
- 🐛 [Report issues](https://github.com/fadhyyusuf/iostimelineschedule/issues)
- 💬 Start a [discussion](https://github.com/fadhyyusuf/iostimelineschedule/discussions)

## 🚀 What's Next?

Planned for future releases:

- SwiftUI wrapper
- Week view support
- Drag-and-drop editing
- Appointment resizing
- Avatar image loading
- Accessibility improvements
- Dark mode optimizations
- iPad-specific features

---

## 📊 Stats

- **Source Files**: 5
- **Lines of Code**: ~1,250
- **Documentation**: 9 comprehensive guides
- **Tests**: 12 unit tests
- **Example**: Complete demo app

---

## ⭐ Show Your Support

If this library helped you, please consider:

- ⭐ Starring the repository
- 🐦 Sharing on social media
- 📝 Writing a blog post
- 🎥 Creating a tutorial video
- 💬 Spreading the word

Every bit of support helps make this library better!

---

**Thank you for using iOS Timeline Schedule!** 🎉

Made with ❤️ and AI assistance | November 2025
