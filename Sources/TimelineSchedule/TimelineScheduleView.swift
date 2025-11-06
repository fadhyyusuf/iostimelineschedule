//
//  TimelineScheduleView.swift
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

import UIKit

/// A custom view for displaying appointments in a timeline format
public class TimelineScheduleView: UIScrollView {
    
    // MARK: - Properties
    
    /// Configuration for the timeline
    public var config = TimelineConfig() {
        didSet {
            setupTimeline()
            
            // Restart timer if current time indicator setting changed
            if config.showCurrentTimeIndicator {
                startCurrentTimeTimer()
            } else {
                timeUpdateTimer?.invalidate()
                timeUpdateTimer = nil
            }
        }
    }
    
    /// List of appointments to display
    public var appointments: [Appointment] = [] {
        didSet {
            setupTimeline()
        }
    }
    
    /// Closure called when an appointment is tapped
    public var onAppointmentTap: ((Appointment) -> Void)?
    
    /// Closure called when an appointment is long pressed
    public var onAppointmentLongPress: ((Appointment) -> Void)?
    
    // Private properties
    private let overlapManager = OverlapManager()
    private let contentContainer = UIView()
    private let timeColumnView = UIView()
    private let appointmentContainerView = UIView()
    private let currentTimeIndicatorView = UIView()
    
    private var startHour = 8
    private var endHour = 18
    
    private var timeUpdateTimer: Timer?
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    deinit {
        timeUpdateTimer?.invalidate()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        // Configure scroll view
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = false
        bounces = true
        alwaysBounceVertical = true
        
        // Setup content container
        contentContainer.backgroundColor = .systemBackground
        addSubview(contentContainer)
        
        // Setup time column
        timeColumnView.backgroundColor = .systemBackground
        contentContainer.addSubview(timeColumnView)
        
        // Setup appointment container
        appointmentContainerView.backgroundColor = .clear
        contentContainer.addSubview(appointmentContainerView)
        
        // Setup current time indicator (on top)
        currentTimeIndicatorView.backgroundColor = .clear
        currentTimeIndicatorView.isUserInteractionEnabled = false
        contentContainer.addSubview(currentTimeIndicatorView)
        
        // Setup timer for current time indicator
        if config.showCurrentTimeIndicator {
            startCurrentTimeTimer()
        }
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update content container size
        contentContainer.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: calculateTotalHeight()
        )
        
        contentSize = contentContainer.bounds.size
        
        // Layout time column
        timeColumnView.frame = CGRect(
            x: 0,
            y: 0,
            width: config.timeColumnWidth,
            height: contentContainer.bounds.height
        )
        
        // Layout appointment container
        appointmentContainerView.frame = CGRect(
            x: config.timeColumnWidth,
            y: 0,
            width: bounds.width - config.timeColumnWidth,
            height: contentContainer.bounds.height
        )
        
        // Layout current time indicator
        currentTimeIndicatorView.frame = contentContainer.bounds
    }
    
    // MARK: - Public Methods
    
    /// Set appointments and refresh the timeline
    public func setAppointments(_ appointments: [Appointment]) {
        self.appointments = appointments
    }
    
    /// Set configuration and refresh the timeline
    public func setConfig(_ config: TimelineConfig) {
        self.config = config
    }
    
    /// Scroll to a specific time
    public func scrollToTime(_ date: Date) {
        let minutesFromMidnight = TimeUtils.minutesFromMidnight(date)
        let hoursSinceStart = (CGFloat(minutesFromMidnight) / 60.0) - CGFloat(startHour)
        let yPosition = hoursSinceStart * config.hourHeight
        
        setContentOffset(CGPoint(x: 0, y: max(0, yPosition - 100)), animated: true)
    }
    
    /// Scroll to current time
    public func scrollToCurrentTime() {
        scrollToTime(TimeUtils.now())
    }
    
    // MARK: - Private Methods
    
    private func setupTimeline() {
        // Update time range based on appointments
        updateTimeRange()
        
        // Clear existing views and layers
        timeColumnView.subviews.forEach { $0.removeFromSuperview() }
        appointmentContainerView.subviews.forEach { $0.removeFromSuperview() }
        currentTimeIndicatorView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        contentContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        // Build time labels
        buildTimeLabels()
        
        // Draw grid if enabled
        if config.showGridLines {
            drawGrid()
        }
        
        // Draw vertical divider if enabled
        if config.showVerticalDivider {
            drawVerticalDivider()
        }
        
        // Render appointments
        renderAppointments()
        
        // Draw current time indicator
        if config.showCurrentTimeIndicator {
            drawCurrentTimeIndicator()
        }
        
        // Update layout
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func updateTimeRange() {
        // Use fixed hours if specified
        if let fixedStart = config.fixedStartHour, let fixedEnd = config.fixedEndHour {
            startHour = max(0, min(23, fixedStart))
            endHour = max(startHour + 1, min(24, fixedEnd))
            return
        }
        
        guard !appointments.isEmpty else {
            startHour = 8
            endHour = 18
            return
        }
        
        var minHour = 24
        var maxHour = 0
        
        for appointment in appointments {
            let startH = TimeUtils.getHour(from: appointment.startTime)
            let endH = TimeUtils.getHour(from: appointment.endTime)
            
            minHour = min(minHour, startH)
            maxHour = max(maxHour, endH)
        }
        
        // Include current time if indicator is enabled
        if config.showCurrentTimeIndicator {
            let currentHour = TimeUtils.getHour(from: Date())
            minHour = min(minHour, currentHour)
            maxHour = max(maxHour, currentHour)
        }
        
        // Add padding
        startHour = max(0, minHour - 1)
        endHour = min(24, maxHour + 2)
    }
    
    private func buildTimeLabels() {
        let labels = config.customTimeLabels ?? generateTimeLabels()
        
        for (index, label) in labels.enumerated() {
            let timeLabel = UILabel()
            timeLabel.text = label
            timeLabel.font = UIFont.systemFont(ofSize: config.timeLabelFontSize)
            timeLabel.textColor = config.timeLabelColor
            timeLabel.textAlignment = .right
            
            // Position label at the top of each hour slot (like Android)
            let yPosition = CGFloat(index) * config.hourHeight
            timeLabel.frame = CGRect(
                x: 0,
                y: yPosition - 8, // Offset upward to align with grid line
                width: config.timeColumnWidth - 8,
                height: 20 // Fixed height for text
            )
            
            timeColumnView.addSubview(timeLabel)
        }
    }
    
    private func generateTimeLabels() -> [String] {
        var labels: [String] = []
        
        for hour in startHour...endHour {
            let date = TimeUtils.createTime(hour: hour, minute: 0)
            let timeString = TimeUtils.formatTime(date, use24Hour: config.use24HourFormat)
            labels.append(timeString)
        }
        
        return labels
    }
    
    private func drawGrid() {
        let gridLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        let labelCount = config.customTimeLabels?.count ?? (endHour - startHour + 1)
        
        for i in 0..<labelCount {
            let y = CGFloat(i) * config.hourHeight
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: bounds.width, y: y))
        }
        
        gridLayer.path = path.cgPath
        gridLayer.strokeColor = config.gridLineColor.cgColor
        gridLayer.lineWidth = config.gridLineWidth
        
        contentContainer.layer.insertSublayer(gridLayer, at: 0)
    }
    
    private func drawVerticalDivider() {
        let dividerLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        let x = config.timeColumnWidth
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: contentContainer.bounds.height))
        
        dividerLayer.path = path.cgPath
        dividerLayer.strokeColor = config.verticalDividerColor.cgColor
        dividerLayer.lineWidth = config.verticalDividerWidth
        
        contentContainer.layer.insertSublayer(dividerLayer, at: 1)
    }
    
    private func renderAppointments() {
        guard !appointments.isEmpty else { return }
        
        // Calculate positions for overlapping appointments
        let positioned = overlapManager.calculatePositions(appointments)
        
        // Create views for each positioned appointment
        for item in positioned {
            let appointmentView = createAppointmentView(for: item)
            appointmentContainerView.addSubview(appointmentView)
        }
    }
    
    private func createAppointmentView(for positioned: OverlapManager.PositionedAppointment) -> UIView {
        let appointment = positioned.appointment
        
        // Calculate frame
        let startMinutes = TimeUtils.minutesFromMidnight(appointment.startTime)
        let endMinutes = TimeUtils.minutesFromMidnight(appointment.endTime)
        
        // Clamp appointment times to visible range
        let visibleStartMinutes = startHour * 60
        let visibleEndMinutes = endHour * 60
        
        let clampedStartMinutes = max(startMinutes, visibleStartMinutes)
        let clampedEndMinutes = min(endMinutes, visibleEndMinutes)
        
        // Skip if appointment is completely outside visible range
        guard clampedStartMinutes < clampedEndMinutes else {
            return UIView(frame: .zero)
        }
        
        let hoursSinceStart = (CGFloat(clampedStartMinutes) / 60.0) - CGFloat(startHour)
        let duration = CGFloat(clampedEndMinutes - clampedStartMinutes) / 60.0
        
        let top = hoursSinceStart * config.hourHeight
        let height = duration * config.hourHeight - config.appointmentPadding
        
        let columnWidth = appointmentContainerView.bounds.width / CGFloat(positioned.totalColumns)
        let left = columnWidth * CGFloat(positioned.column)
        let width = columnWidth - config.appointmentPadding
        
        let frame = CGRect(x: left, y: top, width: width, height: height)
        
        // Create card view with background color from appointment
        let cardView = UIView(frame: frame)
        cardView.backgroundColor = appointment.backgroundColor
        cardView.layer.cornerRadius = config.cardCornerRadius
        cardView.clipsToBounds = false
        
        // Add shadow
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = config.cardShadowOpacity
        cardView.layer.shadowRadius = config.cardShadowRadius
        cardView.layer.shadowOffset = config.cardShadowOffset
        
        // Add left border accent (colored strip on left side like Android)
        let leftBorder = UIView()
        leftBorder.backgroundColor = appointment.color
        leftBorder.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(leftBorder)
        
        NSLayoutConstraint.activate([
            leftBorder.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            leftBorder.topAnchor.constraint(equalTo: cardView.topAnchor),
            leftBorder.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            leftBorder.widthAnchor.constraint(equalToConstant: 4)
        ])
        
        // Create content stack
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .leading
        
        // Add title
        let titleLabel = UILabel()
        titleLabel.text = appointment.title
        titleLabel.font = UIFont.systemFont(ofSize: config.titleFontSize, weight: config.titleFontWeight)
        titleLabel.textColor = .label // Use system label color for better contrast
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
        
        // Add subtitle if exists
        if let subtitle = appointment.subtitle {
            let subtitleLabel = UILabel()
            subtitleLabel.text = subtitle
            subtitleLabel.font = UIFont.systemFont(ofSize: config.subtitleFontSize, weight: config.subtitleFontWeight)
            subtitleLabel.textColor = .secondaryLabel // Use system secondary label color
            subtitleLabel.numberOfLines = 0
            stackView.addArrangedSubview(subtitleLabel)
        }
        
        // Add stack to card with padding (more padding on left to avoid overlap with border)
        cardView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12), // More padding for left border
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -8)
        ])
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAppointmentTap(_:)))
        cardView.addGestureRecognizer(tapGesture)
        cardView.tag = appointments.firstIndex(where: { $0.id == appointment.id }) ?? 0
        
        // Add long press gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleAppointmentLongPress(_:)))
        cardView.addGestureRecognizer(longPressGesture)
        
        return cardView
    }
    
    private func drawCurrentTimeIndicator() {
        let now = Date()
        let currentHour = TimeUtils.getHour(from: now)
        
        let currentMinutes = TimeUtils.minutesFromMidnight(now)
        let hoursSinceStart = (CGFloat(currentMinutes) / 60.0) - CGFloat(startHour)
        let y = hoursSinceStart * config.hourHeight
        
        // Only draw if y position is positive (within or after visible range)
        guard y >= 0 else { return }
        
        // Draw circular dot on the left edge (in time column area)
        let dotLayer = CAShapeLayer()
        let dotX = config.timeColumnWidth - config.currentTimeDotRadius - 4
        let dotPath = UIBezierPath(
            arcCenter: CGPoint(x: dotX, y: y),
            radius: config.currentTimeDotRadius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        dotLayer.path = dotPath.cgPath
        dotLayer.fillColor = config.currentTimeIndicatorColor.cgColor
        currentTimeIndicatorView.layer.addSublayer(dotLayer)
        
        // Draw horizontal line from the edge of dot to the right edge
        let lineLayer = CAShapeLayer()
        let linePath = UIBezierPath()
        let lineStartX = dotX + config.currentTimeDotRadius
        linePath.move(to: CGPoint(x: lineStartX, y: y))
        linePath.addLine(to: CGPoint(x: bounds.width, y: y))
        
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = config.currentTimeIndicatorColor.cgColor
        lineLayer.lineWidth = config.currentTimeIndicatorWidth
        currentTimeIndicatorView.layer.addSublayer(lineLayer)
    }
    
    private func calculateTotalHeight() -> CGFloat {
        let labelCount = config.customTimeLabels?.count ?? (endHour - startHour + 1)
        return CGFloat(labelCount) * config.hourHeight
    }
    
    // MARK: - Timer
    
    private func startCurrentTimeTimer() {
        timeUpdateTimer?.invalidate()
        timeUpdateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.updateCurrentTimeIndicator()
        }
    }
    
    private func updateCurrentTimeIndicator() {
        currentTimeIndicatorView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        if config.showCurrentTimeIndicator {
            drawCurrentTimeIndicator()
        }
    }
    
    // MARK: - Gesture Handlers
    
    @objc private func handleAppointmentTap(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        let index = view.tag
        guard index < appointments.count else { return }
        onAppointmentTap?(appointments[index])
    }
    
    @objc private func handleAppointmentLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        guard let view = gesture.view else { return }
        let index = view.tag
        guard index < appointments.count else { return }
        onAppointmentLongPress?(appointments[index])
    }
}
