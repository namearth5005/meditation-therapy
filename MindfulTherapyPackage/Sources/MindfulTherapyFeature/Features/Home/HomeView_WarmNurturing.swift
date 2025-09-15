import SwiftUI

// MARK: - Design Iteration 2: Soft & Supportive
// Inspired by: Gentle minimalism + Notion's soft aesthetics
// Focus: Subtle warmth, supportive interactions, elegant simplicity

public struct HomeView_WarmNurturing: View {
    @State private var selectedTab = 0
    @State private var dailyMood: Int? = nil
    @State private var showMoodPicker = false
    
    // Soft color palette extension
    private let softColors = SoftColorPalette()
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            homeContent
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Home")
                }
                .tag(0)
            
            chatContent
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
                .tag(1)
            
            meditateContent
                .tabItem {
                    Image(systemName: "moon.stars.fill")
                    Text("Meditate")
                }
                .tag(2)
            
            progressContent
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Progress")
                }
                .tag(3)
        }
        .accentColor(softColors.primary)
    }
    
    // MARK: - Home Content
    private var homeContent: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.lg) {
                // Warm welcome header
                welcomeHeader
                
                // Mood check-in with emotional support
                emotionalCheckInCard
                
                // Breathing exercise quick access
                breathingExerciseCard
                
                // Personal meditation recommendations
                personalMeditationCard
                
                // Supportive therapy invitation
                therapyInvitationCard
                
                // Encouraging progress view
                encouragingProgressCard
                
                Spacer(minLength: DesignSystem.Spacing.xl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(softColors.backgroundLight)
    }
    
    private var welcomeHeader: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                    Text(greetingText)
                        .font(DesignSystem.Typography.h2)
                        .fontWeight(.medium)
                        .foregroundStyle(softColors.textPrimary)
                    
                    Text("Take a moment for yourself")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(softColors.textSecondary)
                }
                
                Spacer()
                
                // Profile with warm styling
                Button {
                    // Settings
                } label: {
                    ZStack {
                        Circle()
                            .fill(softColors.accent1)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                }
            }
            
            // Motivational quote card
            motivationalQuoteCard
        }
        .padding(.top, DesignSystem.Spacing.lg)
    }
    
    private var motivationalQuoteCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                Text("Take it one breath at a time")
                    .font(DesignSystem.Typography.body)
                    .fontWeight(.regular)
                    .foregroundStyle(softColors.textPrimary)
                
                Text("— A gentle reminder")
                    .font(DesignSystem.Typography.bodySmall)
                    .foregroundStyle(softColors.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "leaf.fill")
                .font(.system(size: 24))
                .foregroundStyle(softColors.heartColor)
        }
        .padding(DesignSystem.Spacing.lg)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(Color.white)
                .shadow(color: softColors.shadowColor, radius: 4, x: 0, y: 1)
        }
    }
    
    private var emotionalCheckInCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "heart.text.square.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(softColors.accent1)
                
                Text("How's your heart today?")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.semibold)
                    .foregroundStyle(softColors.textPrimary)
                
                Spacer()
            }
            
            if let mood = dailyMood {
                emotionalMoodDisplay(mood: mood)
            } else {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Take a moment to check in with yourself")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(softColors.textSecondary)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        showMoodPicker = true
                    } label: {
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("Share how you're feeling")
                        }
                    }
                    .buttonStyle(SoftButtonStyle())
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.white.opacity(0.95))
                .shadow(color: softColors.shadowColor, radius: 6, x: 0, y: 2)
        }
    }
    
    private func emotionalMoodDisplay(mood: Int) -> some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack {
                Text("You're feeling:")
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(softColors.textSecondary)
                
                Spacer()
            }
            
            HStack {
                Text(moodEmoji(for: mood))
                    .font(.system(size: 32))
                
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(emotionalMoodText(for: mood))
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundStyle(softColors.primary)
                    
                    Text(emotionalSupportMessage(for: mood))
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(softColors.textSecondary)
                }
                
                Spacer()
            }
        }
    }
    
    private var breathingExerciseCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                HStack {
                    Image(systemName: "wind")
                        .font(.system(size: 20))
                        .foregroundStyle(softColors.breathingColor)
                    
                    Text("Quick Breathing")
                        .font(DesignSystem.Typography.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundStyle(softColors.textPrimary)
                }
                
                Text("Take 3 minutes to reset")
                    .font(DesignSystem.Typography.bodySmall)
                    .foregroundStyle(softColors.textSecondary)
            }
            
            Spacer()
            
            Button {
                // Start breathing exercise
            } label: {
                ZStack {
                    Circle()
                        .fill(softColors.breathingColor)
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "play.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(DesignSystem.Spacing.lg)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(softColors.breathingColor.opacity(0.1))
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .stroke(softColors.breathingColor.opacity(0.3), lineWidth: 1)
                }
        }
    }
    
    private var personalMeditationCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.system(size: 20))
                    .foregroundStyle(softColors.sparkleColor)
                
                Text("Just for You")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.semibold)
                    .foregroundStyle(softColors.textPrimary)
                
                Spacer()
            }
            
            VStack(spacing: DesignSystem.Spacing.md) {
                HStack {
                    VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                        Text("Self-Compassion Practice")
                            .font(DesignSystem.Typography.bodyLarge)
                            .fontWeight(.semibold)
                            .foregroundStyle(softColors.textPrimary)
                        
                        Text("Be gentle with yourself • 12 min")
                            .font(DesignSystem.Typography.bodySmall)
                            .foregroundStyle(softColors.textSecondary)
                    }
                    
                    Spacer()
                    
                    Button {
                        selectedTab = 2
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                                .fill(softColors.primary)
                                .frame(width: 60, height: 36)
                            
                            Text("Start")
                                .font(DesignSystem.Typography.bodySmall)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                    }
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(softColors.progressBackground)
                            .frame(height: 4)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(softColors.primary)
                            .frame(width: geometry.size.width * 0.3, height: 4)
                    }
                }
                .frame(height: 4)
                
                HStack {
                    Text("30% complete")
                        .font(DesignSystem.Typography.caption)
                        .foregroundStyle(softColors.textSecondary)
                    
                    Spacer()
                    
                    Text("4 sessions left")
                        .font(DesignSystem.Typography.caption)
                        .foregroundStyle(softColors.textSecondary)
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(
                    LinearGradient(
                        colors: [softColors.meditationGradient1, softColors.meditationGradient2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: softColors.shadowColor, radius: 8, x: 0, y: 3)
        }
    }
    
    private var therapyInvitationCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(softColors.therapyColor)
                
                Text("Need Support?")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.semibold)
                    .foregroundStyle(softColors.textPrimary)
                
                Spacer()
            }
            
            VStack(spacing: DesignSystem.Spacing.md) {
                Text("I'm here to listen and support you through whatever you're experiencing.")
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(softColors.textSecondary)
                    .multilineTextAlignment(.center)
                
                Button {
                    selectedTab = 1
                } label: {
                    HStack {
                        Image(systemName: "heart.circle.fill")
                        Text("Start a caring conversation")
                    }
                }
                .buttonStyle(SoftTherapyButtonStyle())
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.white.opacity(0.9))
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(softColors.therapyColor.opacity(0.3), lineWidth: 2)
                }
        }
    }
    
    private var encouragingProgressCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(softColors.achievementColor)
                
                Text("Your Journey")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.semibold)
                    .foregroundStyle(softColors.textPrimary)
                
                Spacer()
                
                Button("View All") {
                    selectedTab = 3
                }
                .font(DesignSystem.Typography.bodySmall)
                .foregroundStyle(softColors.primary)
            }
            
            VStack(spacing: DesignSystem.Spacing.md) {
                // Achievement highlights
                HStack(spacing: DesignSystem.Spacing.lg) {
                    achievementStat("🔥", value: "7", label: "day streak", color: softColors.streakColor)
                    achievementStat("💝", value: "12", label: "sessions", color: softColors.sessionColor)
                    achievementStat("⏰", value: "89", label: "minutes", color: softColors.timeColor)
                }
                
                // Encouraging message
                Text("You're building beautiful habits! 🌱")
                    .font(DesignSystem.Typography.body)
                    .fontWeight(.medium)
                    .foregroundStyle(softColors.primary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.white.opacity(0.95))
                .shadow(color: softColors.shadowColor, radius: 6, x: 0, y: 2)
        }
    }
    
    private func achievementStat(_ emoji: String, value: String, label: String, color: Color) -> some View {
        VStack(spacing: DesignSystem.Spacing.xs) {
            Text(emoji)
                .font(.system(size: 20))
            
            Text(value)
                .font(DesignSystem.Typography.h4)
                .fontWeight(.bold)
                .foregroundStyle(color)
            
            Text(label)
                .font(DesignSystem.Typography.caption)
                .foregroundStyle(softColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Placeholder Content
    private var chatContent: some View {
        VStack {
            Text("Caring AI Chat")
                .font(DesignSystem.Typography.h2)
            Text("Coming soon...")
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(softColors.backgroundLight)
    }
    
    private var meditateContent: some View {
        VStack {
            Text("Meditation Library")
                .font(DesignSystem.Typography.h2)
            Text("Coming soon...")
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(softColors.backgroundLight)
    }
    
    private var progressContent: some View {
        VStack {
            Text("Your Progress")
                .font(DesignSystem.Typography.h2)
            Text("Coming soon...")
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(softColors.backgroundLight)
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
    
    private var greetingEmoji: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "🌅"
        case 12..<17: return "☀️"
        case 17..<21: return "🌆"
        default: return "🌙"
        }
    }
    
    private func moodEmoji(for mood: Int) -> String {
        switch mood {
        case 1: return "💙" // Using heart instead of sad face for warmth
        case 2: return "🤗"
        case 3: return "😌"
        case 4: return "😊"
        case 5: return "🥰"
        default: return "😌"
        }
    }
    
    private func emotionalMoodText(for mood: Int) -> String {
        switch mood {
        case 1: return "Having a tough time"
        case 2: return "Feeling low"
        case 3: return "Doing okay"
        case 4: return "Feeling good"
        case 5: return "Feeling wonderful"
        default: return "Doing okay"
        }
    }
    
    private func emotionalSupportMessage(for mood: Int) -> String {
        switch mood {
        case 1: return "That's okay. You're not alone in this."
        case 2: return "These feelings are temporary. You're strong."
        case 3: return "Taking it one step at a time."
        case 4: return "I'm glad you're feeling positive today!"
        case 5: return "Your joy is beautiful! Keep shining."
        default: return "Every feeling is valid."
        }
    }
}

// MARK: - Soft & Supportive Color Palette
private struct SoftColorPalette {
    let primary = Color(hex: "8B7355") // Warm taupe
    let backgroundLight = Color(hex: "FEFEFE") // Pure white
    let backgroundWarm = Color(hex: "FAFAF9") // Off-white
    let textPrimary = Color(hex: "2A2A2A") // Soft black
    let textSecondary = Color(hex: "6B6B6B") // Medium gray
    let accent1 = Color(hex: "D4B5A0") // Soft beige
    let accent2 = Color(hex: "A8A8A8") // Light gray
    let heartColor = Color(hex: "B8A082") // Muted brown
    let breathingColor = Color(hex: "9B9B9B") // Neutral gray
    let sparkleColor = Color(hex: "C4B5A0") // Warm beige
    let therapyColor = Color(hex: "A3A3A3") // Cool gray
    let achievementColor = Color(hex: "8B7355") // Warm brown
    let streakColor = Color(hex: "7A6B5D") // Muted brown
    let sessionColor = Color(hex: "9A8B7A") // Soft brown
    let timeColor = Color(hex: "8A8A8A") // Medium gray
    let shadowColor = Color.black.opacity(0.04)
    let progressBackground = Color(hex: "F5F5F5")
    let meditationGradient1 = Color(hex: "F8F6F4").opacity(0.9)
    let meditationGradient2 = Color(hex: "FAF8F6").opacity(0.9)
}

// MARK: - Soft Button Styles
private struct SoftButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.medium)
            .foregroundStyle(Color.white)
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                    .fill(Color(hex: "8B7355"))
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

private struct SoftTherapyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.medium)
            .foregroundStyle(Color.white)
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                    .fill(Color(hex: "A3A3A3"))
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    HomeView_WarmNurturing()
}