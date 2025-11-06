//
//  TimelineConfig.swift
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
import UIKit

/// Configuration for customizing the timeline schedule view
public struct TimelineConfig {
    
    // MARK: - Time Column Settings
    
    /// Width of the time labels column on the left
    public var timeColumnWidth: CGFloat
    
    /// Font size for time labels
    public var timeLabelFontSize: CGFloat
    
    /// Color for time labels
    public var timeLabelColor: UIColor
    
    /// Height of each hour in points
    public var hourHeight: CGFloat
    
    /// Custom time labels (if nil, will auto-generate from appointments)
    public var customTimeLabels: [String]?
    
    // MARK: - Grid Settings
    
    /// Whether to show horizontal grid lines
    public var showGridLines: Bool
    
    /// Color for grid lines
    public var gridLineColor: UIColor
    
    /// Width of grid lines
    public var gridLineWidth: CGFloat
    
    // MARK: - Divider Settings
    
    /// Whether to show vertical divider between time and content
    public var showVerticalDivider: Bool
    
    /// Color for vertical divider
    public var verticalDividerColor: UIColor
    
    /// Width of vertical divider
    public var verticalDividerWidth: CGFloat
    
    // MARK: - Current Time Indicator Settings
    
    /// Whether to show current time indicator
    public var showCurrentTimeIndicator: Bool
    
    /// Color for current time indicator
    public var currentTimeIndicatorColor: UIColor
    
    /// Width of current time indicator line
    public var currentTimeIndicatorWidth: CGFloat
    
    /// Radius of the dot at the start of current time indicator
    public var currentTimeDotRadius: CGFloat
    
    // MARK: - Appointment Card Settings
    
    /// Padding between appointment cards
    public var appointmentPadding: CGFloat
    
    /// Corner radius for appointment cards
    public var cardCornerRadius: CGFloat
    
    /// Shadow opacity for appointment cards
    public var cardShadowOpacity: Float
    
    /// Shadow radius for appointment cards
    public var cardShadowRadius: CGFloat
    
    /// Shadow offset for appointment cards
    public var cardShadowOffset: CGSize
    
    // MARK: - Text Settings
    
    /// Font size for appointment titles
    public var titleFontSize: CGFloat
    
    /// Font size for appointment subtitles
    public var subtitleFontSize: CGFloat
    
    /// Font weight for appointment titles
    public var titleFontWeight: UIFont.Weight
    
    /// Font weight for appointment subtitles
    public var subtitleFontWeight: UIFont.Weight
    
    // MARK: - Avatar Settings
    
    /// Whether to show avatar images
    public var showAvatar: Bool
    
    /// Size of avatar images
    public var avatarSize: CGFloat
    
    // MARK: - Time Format Settings
    
    /// Whether to use 24-hour format (true) or 12-hour format (false)
    public var use24HourFormat: Bool
    
    // MARK: - Initialization
    
    /// Creates a timeline configuration with default values
    public init(
        timeColumnWidth: CGFloat = 80,
        timeLabelFontSize: CGFloat = 12,
        timeLabelColor: UIColor = .systemGray,
        hourHeight: CGFloat = 100,
        customTimeLabels: [String]? = nil,
        showGridLines: Bool = true,
        gridLineColor: UIColor = .separator,
        gridLineWidth: CGFloat = 1,
        showVerticalDivider: Bool = true,
        verticalDividerColor: UIColor = .separator,
        verticalDividerWidth: CGFloat = 1,
        showCurrentTimeIndicator: Bool = true,
        currentTimeIndicatorColor: UIColor = .systemRed,
        currentTimeIndicatorWidth: CGFloat = 2,
        currentTimeDotRadius: CGFloat = 6,
        appointmentPadding: CGFloat = 4,
        cardCornerRadius: CGFloat = 8,
        cardShadowOpacity: Float = 0.1,
        cardShadowRadius: CGFloat = 2,
        cardShadowOffset: CGSize = CGSize(width: 0, height: 1),
        titleFontSize: CGFloat = 14,
        subtitleFontSize: CGFloat = 12,
        titleFontWeight: UIFont.Weight = .semibold,
        subtitleFontWeight: UIFont.Weight = .regular,
        showAvatar: Bool = true,
        avatarSize: CGFloat = 40,
        use24HourFormat: Bool = false
    ) {
        self.timeColumnWidth = timeColumnWidth
        self.timeLabelFontSize = timeLabelFontSize
        self.timeLabelColor = timeLabelColor
        self.hourHeight = hourHeight
        self.customTimeLabels = customTimeLabels
        self.showGridLines = showGridLines
        self.gridLineColor = gridLineColor
        self.gridLineWidth = gridLineWidth
        self.showVerticalDivider = showVerticalDivider
        self.verticalDividerColor = verticalDividerColor
        self.verticalDividerWidth = verticalDividerWidth
        self.showCurrentTimeIndicator = showCurrentTimeIndicator
        self.currentTimeIndicatorColor = currentTimeIndicatorColor
        self.currentTimeIndicatorWidth = currentTimeIndicatorWidth
        self.currentTimeDotRadius = currentTimeDotRadius
        self.appointmentPadding = appointmentPadding
        self.cardCornerRadius = cardCornerRadius
        self.cardShadowOpacity = cardShadowOpacity
        self.cardShadowRadius = cardShadowRadius
        self.cardShadowOffset = cardShadowOffset
        self.titleFontSize = titleFontSize
        self.subtitleFontSize = subtitleFontSize
        self.titleFontWeight = titleFontWeight
        self.subtitleFontWeight = subtitleFontWeight
        self.showAvatar = showAvatar
        self.avatarSize = avatarSize
        self.use24HourFormat = use24HourFormat
    }
}
