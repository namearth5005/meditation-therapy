import SwiftUI

// MARK: - Design Iteration 3: Clean & Focused
// Inspired by: Linear + Bear + Things 3 + Arc Browser
// Focus: Essential functionality, purposeful design, effortless interactions

public struct HomeView_CleanFocused: View {
    @State private var selectedTab = 0
    @State private var dailyMood: Int? = nil
    @State private var showMoodPicker = false
    
    private let cleanColors = CleanColorPalette()
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            homeContent
                .tabItem {
                    Image(systemName: "circle")
                    Text("Home")
                }
                .tag(0)
            
            chatContent
                .tabItem {
                    Image(systemName: "message")
                    Text("Chat")
                }
                .tag(1)
            
            meditateContent
                .tabItem {
                    Image(systemName: "circle.dotted")
                    Text("Meditate")
                }
                .tag(2)
            
            progressContent
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Progress")
                }
                .tag(3)
        }
        .accentColor(cleanColors.primary)
    }
    
    // MARK: - Home Content
    private var homeContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xxl) {
                // Simple header
                headerSection
                
                // Today's intention
                intentionCard
                
                // Essential actions
                essentialActionsCard
                
                // Weekly overview
                weeklyOverviewCard
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
            .padding(.top, DesignSystem.Spacing.xl)
        }
        .background(cleanColors.background)
    }
    
    private var headerSection: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(currentTimeGreeting)
                        .font(DesignSystem.Typography.h3)
                        .fontWeight(.medium)
                        .foregroundStyle(cleanColors.textPrimary)
                    
                    Text("What would you like to focus on?")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(cleanColors.textSecondary)
                }
                
                Spacer()
                
                Button {
                    // Profile action
                } label: {
                    Circle()
                        .fill(cleanColors.surfaceSecondary)
                        .frame(width: 36, height: 36)
                        .overlay {
                            Image(systemName: "person")
                                .font(.system(size: 16))
                                .foregroundStyle(cleanColors.textSecondary)
                        }
                }
            }
        }
    }
    
    private var intentionCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Today's Focus")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(cleanColors.textPrimary)
                Spacer()
            }
            
            if let mood = dailyMood {
                HStack {
                    Text("Feeling")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(cleanColors.textSecondary)
                    
                    Text(moodText(for: mood))
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundStyle(cleanColors.primary)
                    
                    Spacer()
                    
                    Button("Update") {
                        showMoodPicker = true
                    }
                    .font(DesignSystem.Typography.bodySmall)
                    .foregroundStyle(cleanColors.textSecondary)
                }
            } else {
                Button {
                    showMoodPicker = true
                } label: {
                    HStack {
                        Text("Set your intention")
                            .font(DesignSystem.Typography.body)
                            .foregroundStyle(cleanColors.textSecondary)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12))
                            .foregroundStyle(cleanColors.textTertiary)
                    }
                    .padding(DesignSystem.Spacing.md)
                    .background {
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                            .fill(cleanColors.surfaceSecondary)
                    }
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(cleanColors.surfacePrimary)
        }
    }
    
    private var essentialActionsCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Quick Actions")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(cleanColors.textPrimary)
                Spacer()
            }
            
            VStack(spacing: DesignSystem.Spacing.sm) {
                actionItem(
                    title: "Start meditation",
                    subtitle: "10 minutes",
                    icon: "circle.dotted",
                    action: { selectedTab = 2 }
                )
                
                actionItem(
                    title: "Talk with AI",
                    subtitle: "Get support",
                    icon: "message",
                    action: { selectedTab = 1 }
                )
                
                actionItem(
                    title: "View progress",
                    subtitle: "This week",
                    icon: "chart.bar",
                    action: { selectedTab = 3 }
                )
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(cleanColors.surfacePrimary)
        }
    }
    
    private func actionItem(title: String, subtitle: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(cleanColors.primary)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(DesignSystem.Typography.body)
                        .fontWeight(.medium)
                        .foregroundStyle(cleanColors.textPrimary)
                    
                    Text(subtitle)
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(cleanColors.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(cleanColors.textTertiary)
            }
            .padding(DesignSystem.Spacing.md)
            .background(Color.clear)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .foregroundStyle(cleanColors.border)
        }
    }
    
    private var weeklyOverviewCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("This Week")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(cleanColors.textPrimary)
                
                Spacer()
                
                Text("Oct 7-13")
                    .font(DesignSystem.Typography.bodySmall)
                    .foregroundStyle(cleanColors.textSecondary)
            }
            
            HStack(spacing: DesignSystem.Spacing.xl) {
                weekStat("5", "sessions", cleanColors.primary)
                weekStat("3", "days active", cleanColors.accent)
                weekStat("32", "minutes", cleanColors.secondary)
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(cleanColors.surfacePrimary)
        }
    }
    
    private func weekStat(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: DesignSystem.Spacing.xs) {
            Text(value)
                .font(DesignSystem.Typography.h3)
                .fontWeight(.semibold)
                .foregroundStyle(color)
            
            Text(label)
                .font(DesignSystem.Typography.caption)
                .foregroundStyle(cleanColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Chat Content
    private var chatContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xxl) {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("AI Support")
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(cleanColors.textPrimary)
                    
                    Text("A safe space to share and reflect")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(cleanColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xxl)
                
                // Simple conversation starters
                VStack(spacing: DesignSystem.Spacing.lg) {
                    conversationStarter("I'm feeling overwhelmed")
                    conversationStarter("Help me process my thoughts")
                    conversationStarter("I need some encouragement")
                    conversationStarter("Something is on my mind")
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(cleanColors.background)
    }
    
    private func conversationStarter(_ text: String) -> some View {
        Button {
            // Start conversation
        } label: {
            HStack {
                Text(text)
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(cleanColors.textPrimary)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(cleanColors.textTertiary)
            }
            .padding(DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                    .fill(cleanColors.surfacePrimary)
            }
        }
    }
    
    // MARK: - Meditate Content
    private var meditateContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xxl) {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Meditation")
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(cleanColors.textPrimary)
                    
                    Text("Find your center")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(cleanColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xxl)
                
                // Today's practice
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Recommended")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(cleanColors.textPrimary)
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                            Text("Mindful Breathing")
                                .font(DesignSystem.Typography.bodyLarge)
                                .fontWeight(.medium)
                                .foregroundStyle(cleanColors.textPrimary)
                            
                            Text("Start with the basics")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(cleanColors.textSecondary)
                            
                            Text("8 minutes")
                                .font(DesignSystem.Typography.bodySmall)
                                .foregroundStyle(cleanColors.accent)
                        }
                        
                        Spacer()
                        
                        Button {
                            // Play meditation
                        } label: {
                            Circle()
                                .fill(cleanColors.primary)
                                .frame(width: 48, height: 48)
                                .overlay {
                                    Image(systemName: "play.fill")
                                        .font(.system(size: 18))
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .fill(cleanColors.surfacePrimary)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(cleanColors.background)
    }
    
    // MARK: - Progress Content
    private var progressContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xxl) {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Progress")
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(cleanColors.textPrimary)
                    
                    Text("Your journey so far")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(cleanColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xxl)
                
                // Simple stats
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Overview")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(cleanColors.textPrimary)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.md) {
                        progressRow("Current streak", "7 days", cleanColors.primary)
                        progressRow("Total sessions", "23", cleanColors.accent)
                        progressRow("Time practiced", "4h 32m", cleanColors.secondary)
                        progressRow("Average mood", "4.2/5", cleanColors.tertiary)
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .fill(cleanColors.surfacePrimary)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(cleanColors.background)
    }
    
    private func progressRow(_ label: String, _ value: String, _ color: Color) -> some View {
        HStack {
            Text(label)
                .font(DesignSystem.Typography.body)
                .foregroundStyle(cleanColors.textSecondary)
            
            Spacer()
            
            Text(value)
                .font(DesignSystem.Typography.bodyLarge)
                .fontWeight(.medium)
                .foregroundStyle(color)
        }
    }
    
    // MARK: - Helper Functions
    private var currentTimeGreeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"  
        case 17..<21: return "Good evening"
        default: return "Good evening"
        }
    }
    
    private func moodText(for mood: Int) -> String {
        switch mood {
        case 1: return "difficult"
        case 2: return "low"
        case 3: return "okay"
        case 4: return "good"
        case 5: return "great"
        default: return "okay"
        }
    }
}

// MARK: - Clean & Focused Color Palette
private struct CleanColorPalette {
    let primary = Color(hex: "1a1a1a")      // Near black
    let secondary = Color(hex: "4a4a4a")     // Dark gray
    let accent = Color(hex: "6a6a6a")        // Medium gray
    let tertiary = Color(hex: "8a8a8a")      // Light gray
    
    let background = Color(hex: "fefefe")     // Pure white
    let surfacePrimary = Color.white          // White cards
    let surfaceSecondary = Color(hex: "f8f8f8") // Light gray
    
    let textPrimary = Color(hex: "1a1a1a")   // Near black
    let textSecondary = Color(hex: "6a6a6a")  // Medium gray
    let textTertiary = Color(hex: "9a9a9a")   // Light gray
    
    let border = Color(hex: "e8e8e8")         // Very light gray
}

#Preview {
    HomeView_CleanFocused()
}