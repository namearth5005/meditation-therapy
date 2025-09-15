import SwiftUI

// MARK: - Design Iteration 4: Perfect Blend
// Inspired by: Minimalist Zen's rich functionality + Clean & Focused's sophisticated colors
// Focus: Rich content structure with elegant monochrome aesthetic

public struct HomeView_PerfectBlend: View {
    @State private var selectedTab = 0
    @State private var dailyMood: Int? = nil
    @State private var showMoodPicker = false
    
    private let blendColors = PerfectBlendColorPalette()
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            homeContent
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            chatContent
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                    Text("Chat")
                }
                .tag(1)
            
            meditateContent
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Meditate")
                }
                .tag(2)
            
            progressContent
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Progress")
                }
                .tag(3)
        }
        .accentColor(blendColors.primary)
    }
    
    // MARK: - Home Content
    private var homeContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Header with Clean & Focused styling
                headerSection
                
                // Daily Check-in with enhanced structure
                dailyCheckInCard
                
                // Recommended action
                recommendedActionCard
                
                // Quick therapy access
                quickTherapyCard
                
                // Weekly summary with sophisticated styling
                weeklySummaryCard
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
            .padding(.top, DesignSystem.Spacing.lg)
        }
        .background(blendColors.background)
    }
    
    private var headerSection: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(greetingText)
                        .font(DesignSystem.Typography.h3)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.textPrimary)
                    
                    Text("How can I support you today?")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                }
                
                Spacer()
                
                Button {
                    // Settings action
                } label: {
                    Circle()
                        .fill(blendColors.surfaceSecondary)
                        .frame(width: 36, height: 36)
                        .overlay {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 18))
                                .foregroundStyle(blendColors.textSecondary)
                        }
                }
            }
        }
    }
    
    private var dailyCheckInCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Daily Check-in")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(blendColors.textPrimary)
                Spacer()
            }
            
            if let mood = dailyMood {
                HStack {
                    Text("Today's mood:")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                    
                    Text(moodEmoji(for: mood))
                        .font(.system(size: 24))
                    
                    Text(moodText(for: mood))
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.primary)
                    
                    Spacer()
                    
                    Button("Update") {
                        showMoodPicker = true
                    }
                    .font(DesignSystem.Typography.bodySmall)
                    .foregroundStyle(blendColors.textTertiary)
                }
            } else {
                Button {
                    showMoodPicker = true
                } label: {
                    HStack {
                        Text("Check in with your mood")
                            .font(DesignSystem.Typography.body)
                            .foregroundStyle(blendColors.textSecondary)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12))
                            .foregroundStyle(blendColors.textTertiary)
                    }
                    .padding(DesignSystem.Spacing.md)
                    .background {
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                            .fill(blendColors.surfaceSecondary)
                    }
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(blendColors.surfacePrimary)
        }
    }
    
    private var recommendedActionCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Recommended for You")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(blendColors.textPrimary)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                    Text("Mindful Breathing")
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.textPrimary)
                    
                    Text("Center yourself with gentle awareness")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                    
                    Text("8 minutes")
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(blendColors.accent)
                }
                
                Spacer()
                
                Button {
                    selectedTab = 2
                } label: {
                    Circle()
                        .fill(blendColors.primary)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "play.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(blendColors.background)
                        }
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(blendColors.surfacePrimary)
        }
    }
    
    private var quickTherapyCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Need Support?")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(blendColors.textPrimary)
                Spacer()
            }
            
            Button {
                selectedTab = 1
            } label: {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .font(.system(size: 18))
                        .foregroundStyle(blendColors.background)
                    Text("Start a conversation")
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.background)
                }
                .padding(.vertical, DesignSystem.Spacing.md)
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.primary)
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(blendColors.surfacePrimary)
        }
    }
    
    private var weeklySummaryCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("This Week")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.medium)
                    .foregroundStyle(blendColors.textPrimary)
                
                Spacer()
                
                Button("View All") {
                    selectedTab = 3
                }
                .font(DesignSystem.Typography.bodySmall)
                .foregroundStyle(blendColors.textTertiary)
            }
            
            HStack(spacing: DesignSystem.Spacing.xl) {
                weekStat("7", "day streak", blendColors.primary)
                
                Divider()
                    .frame(height: 40)
                    .foregroundStyle(blendColors.border)
                
                weekStat("3", "conversations", blendColors.accent)
                
                Divider()
                    .frame(height: 40)
                    .foregroundStyle(blendColors.border)
                
                weekStat("45", "minutes", blendColors.secondary)
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(blendColors.surfacePrimary)
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
                .foregroundStyle(blendColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Enhanced Chat Content (Best of Minimalist Zen + Clean Colors)
    private var chatContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Header with Clean & Focused styling
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("AI Therapy")
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.textPrimary)
                    
                    Text("A safe space to share and explore your thoughts")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xl)
                
                // Quick starters with Clean & Focused colors
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("How can I help today?")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(blendColors.textPrimary)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.md) {
                        chatQuickStarter("I'm feeling anxious", icon: "cloud.rain.fill")
                        chatQuickStarter("Help me process my day", icon: "sun.max.fill")
                        chatQuickStarter("I need encouragement", icon: "heart.fill")
                        chatQuickStarter("Something is bothering me", icon: "bubble.left.and.bubble.right.fill")
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.surfacePrimary)
                }
                
                // Recent conversations with Clean & Focused colors
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Recent Conversations")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(blendColors.textPrimary)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.sm) {
                        recentChatItem("Yesterday", preview: "We talked about managing work stress")
                        recentChatItem("3 days ago", preview: "Explored feelings about relationships")
                        recentChatItem("1 week ago", preview: "Discussed sleep and anxiety patterns")
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.surfacePrimary)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(blendColors.background)
    }
    
    private func chatQuickStarter(_ text: String, icon: String) -> some View {
        Button {
            // Start conversation with this prompt
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(blendColors.primary)
                
                Text(text)
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(blendColors.textPrimary)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(blendColors.textTertiary)
            }
            .padding(DesignSystem.Spacing.md)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(blendColors.surfaceSecondary)
                    .overlay {
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                            .stroke(blendColors.border, lineWidth: 1)
                    }
            }
        }
    }
    
    private func recentChatItem(_ date: String, preview: String) -> some View {
        Button {
            // Open conversation
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(date)
                        .font(DesignSystem.Typography.bodySmall)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.primary)
                    
                    Text(preview)
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(blendColors.textTertiary)
            }
            .padding(DesignSystem.Spacing.md)
            .background(Color.clear)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .foregroundStyle(blendColors.border)
        }
    }
    
    // MARK: - Meditate Content
    private var meditateContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Meditation")
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.textPrimary)
                    
                    Text("Find your center with guided practices")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xl)
                
                // Today's Practice
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Today's Practice")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(blendColors.textPrimary)
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                            Text("Morning Clarity")
                                .font(DesignSystem.Typography.h4)
                                .fontWeight(.medium)
                                .foregroundStyle(blendColors.textPrimary)
                            
                            Text("Begin your day with focused attention")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(blendColors.textSecondary)
                            
                            Text("12 minutes")
                                .font(DesignSystem.Typography.bodySmall)
                                .foregroundStyle(blendColors.accent)
                        }
                        
                        Spacer()
                        
                        Button {
                            // Start meditation
                        } label: {
                            Circle()
                                .fill(blendColors.primary)
                                .frame(width: 48, height: 48)
                                .overlay {
                                    Image(systemName: "play.fill")
                                        .font(.system(size: 18))
                                        .foregroundStyle(blendColors.background)
                                }
                        }
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.surfacePrimary)
                }
                
                // Categories
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Meditation Library")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(blendColors.textPrimary)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.md) {
                        meditationCategory("Anxiety & Stress", sessions: 12, icon: "cloud.fill")
                        meditationCategory("Sleep & Rest", sessions: 8, icon: "moon.fill")
                        meditationCategory("Focus & Clarity", sessions: 10, icon: "eye.fill")
                        meditationCategory("Self-Compassion", sessions: 6, icon: "heart.fill")
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.surfacePrimary)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(blendColors.background)
    }
    
    private func meditationCategory(_ title: String, sessions: Int, icon: String) -> some View {
        Button {
            // Open category
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(blendColors.accent)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(title)
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.textPrimary)
                    
                    Text("\\(sessions) sessions")
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(blendColors.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(blendColors.textTertiary)
            }
            .padding(DesignSystem.Spacing.md)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .foregroundStyle(blendColors.border)
        }
    }
    
    // MARK: - Progress Content
    private var progressContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Your Journey")
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(blendColors.textPrimary)
                    
                    Text("Reflect on your growth and insights")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(blendColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xl)
                
                // This Week Summary
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("This Week")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(blendColors.textPrimary)
                        Spacer()
                        Text("Oct 7 - 13")
                            .font(DesignSystem.Typography.bodySmall)
                            .foregroundStyle(blendColors.textSecondary)
                    }
                    
                    HStack(spacing: DesignSystem.Spacing.xl) {
                        progressStat("7", label: "days active", color: blendColors.primary)
                        progressStat("3", label: "conversations", color: blendColors.accent)
                        progressStat("45", label: "minutes", color: blendColors.secondary)
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.surfacePrimary)
                }
                
                // Detailed Progress
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Meditation Progress")
                            .font(DesignSystem.Typography.h4)
                            .fontWeight(.medium)
                            .foregroundStyle(blendColors.textPrimary)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.md) {
                        progressRow("Current Streak", "7 days", blendColors.primary)
                        progressRow("Total Sessions", "24", blendColors.accent)
                        progressRow("Total Time", "6 hours 12 minutes", blendColors.secondary)
                        progressRow("Average Mood", "4.2/5", blendColors.tertiary)
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(blendColors.surfacePrimary)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(blendColors.background)
    }
    
    private func progressStat(_ value: String, label: String, color: Color) -> some View {
        VStack(spacing: DesignSystem.Spacing.xs) {
            Text(value)
                .font(DesignSystem.Typography.h2)
                .fontWeight(.semibold)
                .foregroundStyle(color)
            Text(label)
                .font(DesignSystem.Typography.caption)
                .foregroundStyle(blendColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func progressRow(_ label: String, _ value: String, _ color: Color) -> some View {
        HStack {
            Text(label)
                .font(DesignSystem.Typography.body)
                .foregroundStyle(blendColors.textSecondary)
            Spacer()
            Text(value)
                .font(DesignSystem.Typography.bodyLarge)
                .fontWeight(.medium)
                .foregroundStyle(color)
        }
    }
    
    // MARK: - Helper Functions
    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<21: return "Good evening"
        default: return "Good evening"
        }
    }
    
    private func moodEmoji(for mood: Int) -> String {
        switch mood {
        case 1: return "😢"
        case 2: return "😕"
        case 3: return "😐"
        case 4: return "😊"
        case 5: return "😄"
        default: return "😐"
        }
    }
    
    private func moodText(for mood: Int) -> String {
        switch mood {
        case 1: return "struggling"
        case 2: return "low"
        case 3: return "okay"
        case 4: return "good"
        case 5: return "great"
        default: return "okay"
        }
    }
}

// MARK: - Perfect Blend Color Palette
// Clean & Focused colors with sophisticated grays
private struct PerfectBlendColorPalette {
    let primary = Color(hex: "1a1a1a")        // Near black
    let secondary = Color(hex: "4a4a4a")       // Dark gray
    let accent = Color(hex: "6a6a6a")          // Medium gray
    let tertiary = Color(hex: "8a8a8a")        // Light gray
    
    let background = Color(hex: "fefefe")       // Pure white
    let surfacePrimary = Color.white            // White cards
    let surfaceSecondary = Color(hex: "f8f8f8") // Light gray backgrounds
    
    let textPrimary = Color(hex: "1a1a1a")     // Near black text
    let textSecondary = Color(hex: "6a6a6a")    // Medium gray text
    let textTertiary = Color(hex: "9a9a9a")     // Light gray text
    
    let border = Color(hex: "e8e8e8")           // Very light gray borders
}

#Preview {
    HomeView_PerfectBlend()
}