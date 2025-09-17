# Interactive Widgets Setup Guide

## Overview

The MindfulTherapy app includes interactive widgets for iOS 17+ that allow users to:
- **Quick Mood Log**: Tap to log mood directly from home screen
- **Mood Streak**: View current streak and weekly progress
- **Weekly Mood Chart**: Visual overview of mood patterns

## Implementation Steps

### 1. Create Widget Extension Target

In Xcode, add a new Widget Extension target:

1. File → New → Target
2. Choose "Widget Extension" 
3. Name: "MindfulTherapyWidgets"
4. Include Configuration Intent: ✅
5. Add to meditation-therapy project

### 2. Configure Widget Bundle

Replace the generated widget code with:

```swift
import WidgetKit
import SwiftUI
import MindfulTherapyFeature

@main
struct MindfulTherapyWidgetBundle: WidgetBundle {
    var body: some Widget {
        if #available(iOS 17, *) {
            MoodTrackingWidgets.MoodQuickLogWidget()
            MoodTrackingWidgets.MoodStreakWidget() 
            MoodTrackingWidgets.WeeklyMoodWidget()
        }
    }
}
```

### 3. Add Required Entitlements

Add to `MindfulTherapyWidgets.entitlements`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.application-groups</key>
    <array>
        <string>group.com.mindfultherapy.shared</string>
    </array>
</dict>
</plist>
```

### 4. Shared Data Container

Update both app and widget targets to use App Groups for data sharing:

```swift
// Shared UserDefaults
extension UserDefaults {
    static let shared = UserDefaults(suiteName: "group.com.mindfultherapy.shared")!
}

// Store widget data
UserDefaults.shared.set(moodEntries, forKey: "recentMoodEntries")
UserDefaults.shared.set(currentStreak, forKey: "moodStreak")
```

### 5. Widget-App Communication

The widgets use App Intents to communicate with the main app:

```swift
// In main app, handle widget actions
.onReceive(NotificationCenter.default.publisher(for: .logMoodFromShortcuts)) { notification in
    // Handle mood logging from widget
}
```

### 6. Widget Configuration

Users can:
- Add widgets from home screen widget gallery
- Long press to configure widget size
- Interact directly with mood buttons (iOS 17+)
- View real-time streak and progress updates

## Widget Features

### Quick Mood Log Widget
- **Sizes**: Small, Medium
- **Interactive**: Tap mood buttons to log instantly
- **Updates**: Shows last mood entry and timestamp
- **Privacy**: Respects app privacy settings

### Mood Streak Widget  
- **Size**: Small
- **Display**: Current streak in days
- **Progress**: Weekly goal visualization with dots
- **Updates**: Refreshes hourly

### Weekly Mood Chart Widget
- **Sizes**: Medium, Large
- **Visualization**: 7-day bar chart
- **Colors**: Mood-coded bars (green=good, red=low)
- **Updates**: Daily at midnight

## Technical Details

### iOS Compatibility
- **iOS 17+**: Full interactive widgets
- **iOS 16**: Static widgets only
- **iOS 15**: Widget not available

### Performance
- Widgets use lightweight data structures
- Timeline updates optimized for battery life
- Shared data containers for efficient communication

### Accessibility
- Full VoiceOver support
- High contrast mode compatible
- Large text scaling supported
- Color-blind friendly mood indicators

## Usage Analytics

Track widget engagement:
- Mood logs from widgets vs in-app
- Most popular widget sizes
- Daily widget interaction patterns
- Conversion from widget to app usage

## Privacy & Security

- No sensitive data displayed on lock screen
- Mood data anonymized in widgets
- Respects system privacy settings
- Optional: Hide sensitive information mode

## Troubleshooting

### Common Issues

1. **Widget not updating**
   - Check App Groups configuration
   - Verify timeline provider implementation
   - Ensure shared data container access

2. **Interactive buttons not working**
   - Requires iOS 17+
   - Check App Intent registration
   - Verify button intent configuration

3. **Data not syncing**
   - Confirm UserDefaults shared suite name
   - Check entitlements for App Groups
   - Verify data serialization format

### Debug Tips

```swift
// Widget debugging
#if DEBUG
print("Widget timeline entry: \(entry)")
print("Shared data: \(UserDefaults.shared.object(forKey: "moodStreak"))")
#endif
```

## Future Enhancements

- **Live Activities**: Real-time meditation session progress
- **Lock Screen Widgets**: iOS 16+ lock screen mood tracking
- **Siri Integration**: "Hey Siri, log my mood as happy"
- **Smart Stack**: Context-aware widget suggestions
- **Complications**: Apple Watch complications support