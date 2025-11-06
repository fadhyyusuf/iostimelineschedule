# Changelog

All notable changes to the Timeline Schedule iOS library will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-11-06

### Added

- Initial release of Timeline Schedule library for iOS
- Vertical timeline view for displaying appointments using UIKit
- Automatic handling of overlapping appointments with multi-column layout
- Current time indicator with animated dot (auto-updates every minute)
- Customizable timeline configuration via `TimelineConfig`
- Support for 12-hour and 24-hour time formats
- Custom time labels feature
- Configurable grid lines (horizontal)
- Configurable vertical divider between time and content
- Appointment tap and long press gesture handlers
- Customizable colors for all UI elements
- Customizable card styling (corner radius, shadow)
- Customizable text sizes and weights for titles and subtitles
- Smooth scrolling behavior with UIScrollView
- Support for appointment titles and subtitles
- Color-coded appointments with custom background colors
- Responsive column layout for overlapping events
- Comprehensive documentation:
  - README.md with full documentation
  - QUICKSTART.md with step-by-step guide
  - Example app demonstrating all features
- Swift Package Manager support
- iOS 13.0+ compatibility
- Built entirely with UIKit (no SwiftUI dependencies)

### Core Components

- `TimelineScheduleView`: Main custom UIScrollView component
- `Appointment`: Data model for appointments
- `TimelineConfig`: Configuration struct with all customization options
- `OverlapManager`: Intelligent overlap detection and column calculation
- `TimeUtils`: Utility functions for time operations

### Features in Detail

#### Timeline View
- Clean, scrollable vertical timeline layout
- Automatic calculation of timeline height based on appointments
- Efficient layer-based rendering for performance
- Support for arbitrary time ranges
- Programmatic scrolling to specific times

#### Appointment Management
- Simple data model with `Appointment` struct
- Support for:
  - Unique IDs
  - Title and optional subtitle
  - Start and end times (Date objects)
  - Custom colors (border and background)
  - Tap and long press handling
  - Duration calculation

#### Overlapping Appointments
- Automatic detection of overlapping appointments
- Smart column calculation algorithm
- Dynamic width adjustment based on number of overlapping events
- Visual separation with configurable padding

#### Current Time Indicator
- Real-time position indicator
- Customizable line color and width
- Animated dot at the timeline edge
- Auto-updates every minute via Timer
- Can be disabled via configuration

#### Customization Options
- Time column width and font settings
- Grid line visibility, color, and width
- Vertical divider visibility, color, and width
- Current time indicator color, width, and dot radius
- Card corner radius, shadow properties
- Title and subtitle font sizes and weights
- Appointment padding
- Custom time labels support

---

## Version History

- **v1.0.0** - Initial iOS release (based on Android version)

---

## Upcoming Features

Features planned for future releases:

- [ ] Week view support
- [ ] Drag and drop appointment editing
- [ ] Appointment resizing
- [ ] Multiple day view
- [ ] Avatar image loading from URLs
- [ ] Accessibility improvements
- [ ] Dark mode optimizations
- [ ] iPad-specific optimizations
- [ ] SwiftUI wrapper
- [ ] Animations for appointment updates

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

---

## Links

- [GitHub Repository](https://github.com/fadhyyusuf/ios-timeline-schedule)
- [Android Version](https://github.com/fadhyyusuf/timelineschedule)
- [Report Issues](https://github.com/fadhyyusuf/ios-timeline-schedule/issues)
- [Request Features](https://github.com/fadhyyusuf/ios-timeline-schedule/issues/new)

---

Made with ❤️ and AI assistance
