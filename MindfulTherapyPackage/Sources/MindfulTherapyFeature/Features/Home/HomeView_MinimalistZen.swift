import SwiftUI

// MARK: - Design Iteration 1: Minimalist Zen
// Inspired by: Calm app + Linear's clean aesthetics
// Focus: Maximum simplicity, breathable white space, gentle interactions

public struct HomeView_MinimalistZen: View {
    @State private var selectedTab = 0
    @State private var dailyMood: Int? = nil
    @State private var showMoodPicker = false
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            homeContent
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Chat Tab
            chatContent
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("Chat")
                }
                .tag(1)
            
            // Meditate Tab
            meditateContent
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Meditate")
                }
                .tag(2)
            
            // Progress Tab
            progressContent
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Progress")
                }
                .tag(3)
        }
        .accentColor(DesignSystem.Colors.primary)
    }
    
    // MARK: - Home Content
    private var homeContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Header with breathing space
                headerSection
                
                // Daily Mood Check-in
                moodCheckInCard
                
                // Recommended Meditation
                recommendedMeditationCard
                
                // Quick Therapy Access
                quickTherapyCard
                
                // Weekly Summary
                weeklySummaryCard
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
            .padding(.top, DesignSystem.Spacing.lg)
        }
        .background(DesignSystem.Colors.neutral100)
    }
    
    private var headerSection: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(greetingText)
                        .font(DesignSystem.Typography.h3)
                        .foregroundStyle(DesignSystem.Colors.neutral700)
                    
                    Text("How are you feeling today?")
                        .font(DesignSystem.Typography.bodyLarge)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                }
                
                Spacer()
                
                // Profile/Settings button
                Button {
                    // Settings action
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(DesignSystem.Colors.primary)
                }
                .buttonStyle(.icon)
            }
        }
    }
    
    private var moodCheckInCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Daily Check-in")
                    .font(DesignSystem.Typography.h4)
                    .foregroundStyle(DesignSystem.Colors.neutral700)
                Spacer()
            }
            
            if let mood = dailyMood {
                HStack {
                    Text("Today's mood:")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                    
                    Text(moodEmoji(for: mood))
                        .font(.system(size: 24))
                    
                    Text(moodText(for: mood))
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundStyle(DesignSystem.Colors.primary)
                    
                    Spacer()
                }
            } else {
                Button {
                    showMoodPicker = true
                } label: {
                    Text("Check in with your mood")
                }
                .buttonStyle(.secondary)
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(Color.white)
                .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
        }
    }
    
    private var recommendedMeditationCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Recommended for You")
                    .font(DesignSystem.Typography.h4)
                    .foregroundStyle(DesignSystem.Colors.neutral700)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                    Text("Morning Mindfulness")
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundStyle(DesignSystem.Colors.neutral700)
                    
                    Text("Start your day with intention • 10 min")
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                }
                
                Spacer()
                
                Button {
                    // Play meditation
                } label: {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(DesignSystem.Colors.calm)
                }
                .buttonStyle(.icon)
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(LinearGradient(
                    colors: [DesignSystem.Colors.calm.opacity(0.1), DesignSystem.Colors.peace.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .stroke(DesignSystem.Colors.calm.opacity(0.3), lineWidth: 1)
                }
        }
    }
    
    private var quickTherapyCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Need to Talk?")
                    .font(DesignSystem.Typography.h4)
                    .foregroundStyle(DesignSystem.Colors.neutral700)
                Spacer()
            }
            
            Button {
                // Start therapy session
                selectedTab = 1
            } label: {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .font(.system(size: 20))
                    Text("Start a conversation")
                        .fontWeight(.medium)
                }
            }
            .buttonStyle(.primary)
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(Color.white)
                .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
        }
    }
    
    private var weeklySummaryCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("This Week")
                    .font(DesignSystem.Typography.h4)
                    .foregroundStyle(DesignSystem.Colors.neutral700)
                Spacer()
                Button("View All") {
                    selectedTab = 3
                }
                .buttonStyle(.tertiary)
            }
            
            HStack(spacing: DesignSystem.Spacing.lg) {
                // Meditation streak
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Text("7")
                        .font(DesignSystem.Typography.h3)
                        .fontWeight(.bold)
                        .foregroundStyle(DesignSystem.Colors.success)
                    Text("day streak")
                        .font(DesignSystem.Typography.caption)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(height: 40)
                
                // Therapy sessions
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Text("3")
                        .font(DesignSystem.Typography.h3)
                        .fontWeight(.bold)
                        .foregroundStyle(DesignSystem.Colors.primary)
                    Text("conversations")
                        .font(DesignSystem.Typography.caption)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(height: 40)
                
                // Total time
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Text("45")
                        .font(DesignSystem.Typography.h3)
                        .fontWeight(.bold)
                        .foregroundStyle(DesignSystem.Colors.focus)
                    Text("minutes")
                        .font(DesignSystem.Typography.caption)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(Color.white)
                .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
        }
    }
    
    // MARK: - Chat Content
    private var chatContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Header
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("AI Therapy")
                        .font(DesignSystem.Typography.h2)
                        .foregroundStyle(DesignSystem.Colors.neutral700)
                    
                    Text("A safe space to share and explore your thoughts")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xl)
                
                // Quick starters
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("How can I help today?")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
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
                        .fill(Color.white)
                        .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
                }
                
                // Recent conversations
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Recent Conversations")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
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
                        .fill(Color.white)
                        .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(DesignSystem.Colors.neutral100)
    }
    
    private func chatQuickStarter(_ text: String, icon: String) -> some View {
        Button {
            // Start conversation with this prompt
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(DesignSystem.Colors.primary)
                
                Text(text)
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(DesignSystem.Colors.neutral600)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(DesignSystem.Colors.neutral400)
            }
            .padding(DesignSystem.Spacing.md)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(DesignSystem.Colors.primary.opacity(0.05))
                    .overlay {
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                            .stroke(DesignSystem.Colors.primary.opacity(0.1), lineWidth: 1)
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
                        .foregroundStyle(DesignSystem.Colors.primary)
                    
                    Text(preview)
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(DesignSystem.Colors.neutral600)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(DesignSystem.Colors.neutral400)
            }
            .padding(DesignSystem.Spacing.md)
            .background(Color.clear)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .foregroundStyle(DesignSystem.Colors.neutral200)
        }
    }
    
    // MARK: - Meditate Content
    private var meditateContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Header
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Meditation")
                        .font(DesignSystem.Typography.h2)
                        .foregroundStyle(DesignSystem.Colors.neutral700)
                    
                    Text("Find your center with guided practices")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xl)
                
                // Daily Practice
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Today's Practice")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                            Text("Morning Clarity")
                                .font(DesignSystem.Typography.h4)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignSystem.Colors.neutral700)
                            
                            Text("Begin your day with focused attention")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral500)
                            
                            Text("12 minutes")
                                .font(DesignSystem.Typography.bodySmall)
                                .foregroundStyle(DesignSystem.Colors.calm)
                        }
                        
                        Spacer()
                        
                        Button {
                            // Start meditation
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 48))
                                .foregroundStyle(DesignSystem.Colors.calm)
                        }
                        .buttonStyle(.icon)
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(LinearGradient(
                            colors: [DesignSystem.Colors.calm.opacity(0.08), DesignSystem.Colors.peace.opacity(0.08)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .overlay {
                            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                                .stroke(DesignSystem.Colors.calm.opacity(0.2), lineWidth: 1)
                        }
                }
                
                // Categories
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Meditation Library")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
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
                        .fill(Color.white)
                        .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(DesignSystem.Colors.neutral100)
    }
    
    private func meditationCategory(_ title: String, sessions: Int, icon: String) -> some View {
        Button {
            // Open category
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(DesignSystem.Colors.peace)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(title)
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundStyle(DesignSystem.Colors.neutral700)
                    
                    Text("\(sessions) sessions")
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundStyle(DesignSystem.Colors.neutral400)
            }
            .padding(DesignSystem.Spacing.md)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .foregroundStyle(DesignSystem.Colors.neutral200)
        }
    }
    
    // MARK: - Progress Content
    private var progressContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Header
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Your Journey")
                        .font(DesignSystem.Typography.h2)
                        .foregroundStyle(DesignSystem.Colors.neutral700)
                    
                    Text("Reflect on your growth and insights")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(DesignSystem.Colors.neutral500)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, DesignSystem.Spacing.xl)
                
                // This Week Summary
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("This Week")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
                        Spacer()
                        Text("Oct 7 - 13")
                            .font(DesignSystem.Typography.bodySmall)
                            .foregroundStyle(DesignSystem.Colors.neutral500)
                    }
                    
                    HStack(spacing: DesignSystem.Spacing.xl) {
                        progressStat("7", label: "days active", color: DesignSystem.Colors.success)
                        progressStat("3", label: "conversations", color: DesignSystem.Colors.primary)
                        progressStat("45", label: "minutes", color: DesignSystem.Colors.focus)
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(Color.white)
                        .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
                }
                
                // Meditation Progress
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Meditation Progress")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.md) {
                        HStack {
                            Text("Current Streak")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral600)
                            Spacer()
                            Text("7 days")
                                .font(DesignSystem.Typography.bodyLarge)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignSystem.Colors.calm)
                        }
                        
                        HStack {
                            Text("Total Sessions")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral600)
                            Spacer()
                            Text("24")
                                .font(DesignSystem.Typography.bodyLarge)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignSystem.Colors.peace)
                        }
                        
                        HStack {
                            Text("Total Time")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral600)
                            Spacer()
                            Text("6 hours 12 minutes")
                                .font(DesignSystem.Typography.bodyLarge)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignSystem.Colors.focus)
                        }
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(Color.white)
                        .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
                }
                
                // Mood Insights
                VStack(spacing: DesignSystem.Spacing.lg) {
                    HStack {
                        Text("Mood Insights")
                            .font(DesignSystem.Typography.h4)
                            .foregroundStyle(DesignSystem.Colors.neutral700)
                        Spacer()
                    }
                    
                    VStack(spacing: DesignSystem.Spacing.md) {
                        HStack {
                            Text("Most Common")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral600)
                            Spacer()
                            HStack {
                                Text("😊")
                                Text("Good")
                                    .font(DesignSystem.Typography.bodyLarge)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(DesignSystem.Colors.success)
                            }
                        }
                        
                        HStack {
                            Text("Average This Week")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral600)
                            Spacer()
                            Text("4.2/5")
                                .font(DesignSystem.Typography.bodyLarge)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignSystem.Colors.primary)
                        }
                        
                        HStack {
                            Text("Improvement")
                                .font(DesignSystem.Typography.body)
                                .foregroundStyle(DesignSystem.Colors.neutral600)
                            Spacer()
                            Text("+0.8 from last week")
                                .font(DesignSystem.Typography.bodyLarge)
                                .fontWeight(.semibold)
                                .foregroundStyle(DesignSystem.Colors.success)
                        }
                    }
                }
                .padding(DesignSystem.Spacing.cardPadding)
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(Color.white)
                        .shadow(color: DesignSystem.Shadow.sm, radius: 2, x: 0, y: 1)
                }
                
                Spacer(minLength: DesignSystem.Spacing.xxxl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(DesignSystem.Colors.neutral100)
    }
    
    private func progressStat(_ value: String, label: String, color: Color) -> some View {
        VStack(spacing: DesignSystem.Spacing.xs) {
            Text(value)
                .font(DesignSystem.Typography.h2)
                .fontWeight(.bold)
                .foregroundStyle(color)
            Text(label)
                .font(DesignSystem.Typography.caption)
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Helper Functions
    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<21: return "Good evening"
        default: return "Good night"
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
        case 1: return "Struggling"
        case 2: return "Low"
        case 3: return "Okay"
        case 4: return "Good"
        case 5: return "Great"
        default: return "Okay"
        }
    }
}

#Preview {
    HomeView_MinimalistZen()
}