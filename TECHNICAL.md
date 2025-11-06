# Technical Documentation - iOS Timeline Schedule

This document provides detailed technical information about the architecture, implementation, and usage of the Timeline Schedule library for iOS.

---

## Architecture Overview

The Timeline Schedule library follows a modular architecture with clear separation of concerns:

```
TimelineSchedule/
├── Models/
│   ├── Appointment.swift        # Data model for appointments
│   └── TimelineConfig.swift     # Configuration data structure
├── TimelineScheduleView.swift   # Main custom UIScrollView component
└── Utils/
    ├── TimeUtils.swift          # Time-related utility functions
    └── OverlapManager.swift     # Overlap detection and positioning
```

---

## Core Components

### 1. TimelineScheduleView

The main custom view that extends `UIScrollView` and handles the rendering of the timeline.

**Responsibilities:**
- Rendering the timeline grid
- Drawing time labels
- Positioning appointments
- Handling overlapping appointments
- Drawing the current time indicator
- Managing user interactions (tap, long press)

**Key Methods:**

```swift
class TimelineScheduleView: UIScrollView {
    
    // Configuration
    func setConfig(_ config: TimelineConfig)
    
    // Data
    func setAppointments(_ appointments: [Appointment])
    
    // Interaction
    var onAppointmentTap: ((Appointment) -> Void)?
    var onAppointmentLongPress: ((Appointment) -> Void)?
    
    // Navigation
    func scrollToTime(_ date: Date)
    func scrollToCurrentTime()
    
    // Internal rendering
    private func drawGrid()
    private func drawVerticalDivider()
    private func renderAppointments()
    private func drawCurrentTimeIndicator()
}
```

### 2. Appointment Model

Simple struct representing an appointment or event.

```swift
struct Appointment {
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

**Properties:**
- `id`: Unique identifier for the appointment
- `title`: Main display text
- `subtitle`: Optional secondary text
- `startTime`, `endTime`: Date objects representing the time range
- `color`: Border/accent color
- `backgroundColor`: Card background color
- `avatarURL`: Optional URL for avatar image (future feature)

### 3. TimelineConfig

Configuration struct with all customization options.

```swift
struct TimelineConfig {
    // Time column settings
    var timeColumnWidth: CGFloat
    var timeLabelFontSize: CGFloat
    var timeLabelColor: UIColor
    var hourHeight: CGFloat
    var customTimeLabels: [String]?
    
    // Grid settings
    var showGridLines: Bool
    var gridLineColor: UIColor
    var gridLineWidth: CGFloat
    
    // Divider settings
    var showVerticalDivider: Bool
    var verticalDividerColor: UIColor
    var verticalDividerWidth: CGFloat
    
    // Current time indicator
    var showCurrentTimeIndicator: Bool
    var currentTimeIndicatorColor: UIColor
    var currentTimeIndicatorWidth: CGFloat
    var currentTimeDotRadius: CGFloat
    
    // Card settings
    var appointmentPadding: CGFloat
    var cardCornerRadius: CGFloat
    var cardShadowOpacity: Float
    var cardShadowRadius: CGFloat
    var cardShadowOffset: CGSize
    
    // Text settings
    var titleFontSize: CGFloat
    var subtitleFontSize: CGFloat
    var titleFontWeight: UIFont.Weight
    var subtitleFontWeight: UIFont.Weight
    
    // Avatar settings
    var showAvatar: Bool
    var avatarSize: CGFloat
    
    // Time format
    var use24HourFormat: Bool
}
```

### 4. OverlapManager

Handles the detection and positioning of overlapping appointments.

```swift
class OverlapManager {
    struct PositionedAppointment {
        let appointment: Appointment
        let column: Int
        let totalColumns: Int
    }
    
    func calculatePositions(_ appointments: [Appointment]) -> [PositionedAppointment]
}
```

**Algorithm:**
1. Sort appointments by start time
2. Group overlapping appointments together
3. For each group, calculate column assignments
4. Return positioned appointments with column information

### 5. TimeUtils

Utility functions for time operations.

```swift
class TimeUtils {
    static func formatTime(_ date: Date, use24Hour: Bool) -> String
    static func getHour(from date: Date) -> Int
    static func getMinute(from date: Date) -> Int
    static func createTime(hour: Int, minute: Int) -> Date
    static func minutesFromMidnight(_ date: Date) -> Int
    static func now() -> Date
    static func isToday(_ date: Date) -> Bool
}
```

---

## Rendering Pipeline

### 1. View Hierarchy

```
TimelineScheduleView (UIScrollView)
└── contentContainer (UIView)
    ├── timeColumnView (UIView)
    │   └── UILabel (for each time label)
    ├── appointmentContainerView (UIView)
    │   └── UIView (for each appointment card)
    │       └── UIStackView
    │           ├── titleLabel
    │           └── subtitleLabel
    └── currentTimeIndicatorView (UIView)
        └── CAShapeLayer (dot and line)
```

### 2. Layout Process

1. **Calculate time range** from appointments
2. **Build time labels** (custom or auto-generated)
3. **Draw grid lines** if enabled
4. **Draw vertical divider** if enabled
5. **Calculate appointment positions** using OverlapManager
6. **Create appointment views** with proper frames
7. **Draw current time indicator** if enabled
8. **Update content size** of scroll view

### 3. Coordinate System

- **Y-axis**: Represents time (0 = start hour)
- **X-axis**: Divided into columns for overlapping appointments
- **Time-to-pixel conversion**: `y = (hoursSinceStart * hourHeight)`

```swift
let minutesSinceMidnight = TimeUtils.minutesFromMidnight(date)
let hoursSinceStart = (CGFloat(minutesSinceMidnight) / 60.0) - CGFloat(startHour)
let yPosition = hoursSinceStart * config.hourHeight
```

---

## Overlap Detection Algorithm

### Step 1: Group Overlapping Appointments

```swift
for appointment in sorted {
    var addedToGroup = false
    
    for i in 0..<groups.count {
        if groups[i].contains(where: { $0.overlaps(with: appointment) }) {
            groups[i].append(appointment)
            addedToGroup = true
            break
        }
    }
    
    if !addedToGroup {
        groups.append([appointment])
    }
}
```

### Step 2: Calculate Columns Within Each Group

```swift
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
```

### Step 3: Position Appointments

```swift
let columnWidth = appointmentContainerView.bounds.width / CGFloat(totalColumns)
let left = columnWidth * CGFloat(column)
let width = columnWidth - config.appointmentPadding

let frame = CGRect(x: left, y: top, width: width, height: height)
```

---

## Performance Considerations

### 1. Efficient Rendering

- **Layer-based drawing** for grid lines and dividers
- **Single pass layout** for all appointments
- **Minimal view hierarchy** to reduce overhead

### 2. Memory Management

- **Weak references** in closures to prevent retain cycles
- **View reuse** where possible
- **Lazy initialization** of subviews

### 3. Scroll Performance

- **Pre-calculated positions** stored in positioned appointments
- **No drawing during scroll** (all views pre-created)
- **Efficient hit testing** for touch events

### 4. Timer Management

```swift
private func startCurrentTimeTimer() {
    timeUpdateTimer?.invalidate()
    timeUpdateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
        self?.updateCurrentTimeIndicator()
    }
}

deinit {
    timeUpdateTimer?.invalidate()
}
```

---

## Customization Points

### 1. Custom Appointment Views

You can subclass `TimelineScheduleView` to customize appointment rendering:

```swift
class CustomTimelineView: TimelineScheduleView {
    
    override func createAppointmentView(for positioned: OverlapManager.PositionedAppointment) -> UIView {
        // Custom appointment view creation
        let view = super.createAppointmentView(for: positioned)
        // Add custom styling or subviews
        return view
    }
}
```

### 2. Dynamic Configuration

Update configuration at runtime:

```swift
var config = timelineView.config
config.hourHeight = 150
config.showGridLines = false
timelineView.setConfig(config)
```

### 3. Custom Time Labels

Replace standard time labels with custom labels:

```swift
var config = TimelineConfig()
config.customTimeLabels = [
    "Early Morning",
    "Morning",
    "Afternoon",
    "Evening"
]
```

---

## Best Practices

### 1. Appointment Creation

```swift
// ✅ Good: Use TimeUtils for consistent time creation
let appointment = Appointment(
    id: UUID().uuidString,
    title: "Meeting",
    startTime: TimeUtils.createTime(hour: 9, minute: 0),
    endTime: TimeUtils.createTime(hour: 10, minute: 0),
    color: .systemBlue,
    backgroundColor: .systemBackground
)

// ❌ Bad: Using arbitrary dates may cause positioning issues
let appointment = Appointment(
    id: "1",
    title: "Meeting",
    startTime: Date(timeIntervalSinceNow: 3600),
    endTime: Date(timeIntervalSinceNow: 7200),
    color: .systemBlue,
    backgroundColor: .systemBackground
)
```

### 2. Performance with Large Datasets

```swift
// ✅ Good: Batch updates
let appointments = fetchAllAppointments()
timelineView.setAppointments(appointments)

// ❌ Bad: Multiple updates in a loop
for appointment in appointments {
    timelineView.setAppointments([appointment]) // This redraws each time!
}
```

### 3. Memory Management

```swift
// ✅ Good: Weak self in closures
timelineView.onAppointmentTap = { [weak self] appointment in
    self?.handleTap(appointment)
}

// ❌ Bad: Strong reference cycle
timelineView.onAppointmentTap = { appointment in
    self.handleTap(appointment) // Retains self!
}
```

---

## Testing

### Unit Tests

The library includes comprehensive unit tests:

```swift
func testAppointmentOverlap() {
    let app1 = Appointment(...)
    let app2 = Appointment(...)
    
    XCTAssertTrue(app1.overlaps(with: app2))
}

func testOverlapManagerCalculations() {
    let manager = OverlapManager()
    let positioned = manager.calculatePositions(appointments)
    
    XCTAssertEqual(positioned.count, appointments.count)
}
```

Run tests:

```bash
swift test
```

Or in Xcode:
- Product > Test (⌘U)

---

## API Reference

### TimelineScheduleView

| Property/Method | Type | Description |
|----------------|------|-------------|
| `config` | `TimelineConfig` | Configuration object |
| `appointments` | `[Appointment]` | List of appointments to display |
| `onAppointmentTap` | `((Appointment) -> Void)?` | Tap handler |
| `onAppointmentLongPress` | `((Appointment) -> Void)?` | Long press handler |
| `setConfig(_:)` | `(TimelineConfig) -> Void` | Update configuration |
| `setAppointments(_:)` | `([Appointment]) -> Void` | Update appointments |
| `scrollToTime(_:)` | `(Date) -> Void` | Scroll to specific time |
| `scrollToCurrentTime()` | `() -> Void` | Scroll to current time |

### Extension Functions

```swift
// Scroll to specific appointment
extension TimelineScheduleView {
    func scrollToAppointment(_ appointment: Appointment) {
        scrollToTime(appointment.startTime)
    }
}

// Add appointment dynamically
extension TimelineScheduleView {
    func addAppointment(_ appointment: Appointment) {
        var current = self.appointments
        current.append(appointment)
        setAppointments(current)
    }
}

// Remove appointment
extension TimelineScheduleView {
    func removeAppointment(withId id: String) {
        let filtered = appointments.filter { $0.id != id }
        setAppointments(filtered)
    }
}
```

---

## Troubleshooting

### Common Issues

#### 1. Appointments Not Displaying

**Problem:** Appointments are set but not visible.

**Solutions:**
- Check that `startTime` < `endTime`
- Verify appointments are for today using `TimeUtils.createTime()`
- Ensure `appointments` array is not empty
- Check that colors have sufficient contrast

#### 2. Layout Issues

**Problem:** Appointments are positioned incorrectly.

**Solutions:**
- Ensure proper Auto Layout constraints on `TimelineScheduleView`
- Call `setNeedsLayout()` after configuration changes
- Verify parent view has non-zero frame

#### 3. Current Time Indicator Not Showing

**Problem:** Indicator doesn't appear.

**Solutions:**
- Set `config.showCurrentTimeIndicator = true`
- Verify current time is within appointment range
- Check indicator color isn't same as background

#### 4. Performance Issues

**Problem:** Scrolling is laggy with many appointments.

**Solutions:**
- Reduce `hourHeight` for less vertical space
- Disable shadows: `config.cardShadowOpacity = 0`
- Limit visible time range

---

## Migration from Android Version

If you're migrating from the Android version:

| Android | iOS |
|---------|-----|
| `TimelineView` | `TimelineScheduleView` |
| `setOnAppointmentClickListener` | `onAppointmentTap` |
| `Color.parseColor()` | `UIColor(red:green:blue:alpha:)` |
| `dp` units | CGFloat points |
| XML layout | Programmatic UIKit |
| Canvas drawing | CAShapeLayer |

---

## Future Enhancements

Planned features for future releases:

- [ ] SwiftUI wrapper for native SwiftUI support
- [ ] Week view with multiple days
- [ ] Drag-and-drop appointment editing
- [ ] Appointment resizing
- [ ] Avatar image loading from URLs
- [ ] Accessibility labels and hints
- [ ] VoiceOver support improvements
- [ ] Dynamic Type support
- [ ] Dark mode optimizations
- [ ] iPad split view optimizations

---

## Contributing

Contributions are welcome! Areas where help is needed:

- Performance optimizations
- Additional test coverage
- Documentation improvements
- Example apps for different use cases
- Accessibility enhancements

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## Resources

- [Apple UIKit Documentation](https://developer.apple.com/documentation/uikit)
- [Swift Package Manager Documentation](https://swift.org/package-manager/)
- [GitHub Repository](https://github.com/fadhyyusuf/ios-timeline-schedule)
- [Android Version](https://github.com/fadhyyusuf/timelineschedule)

---

Made with ❤️ and AI assistance
