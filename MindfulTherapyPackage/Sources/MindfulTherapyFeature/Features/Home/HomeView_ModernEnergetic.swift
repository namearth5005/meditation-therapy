import SwiftUI

// MARK: - Design Iteration 3: Modern & Energetic
// Inspired by: Nike Training Club + Strava + Modern iOS apps
// Focus: Motivation, progress, achievement, modern glassmorphism

public struct HomeView_ModernEnergetic: View {
    @State private var selectedTab = 0
    @State private var dailyMood: Int? = nil
    @State private var showMoodPicker = false
    @State private var animateProgress = false
    
    private let modernColors = ModernColorPalette()
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            homeContent
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Home")
                }
                .tag(0)
            
            chatContent
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Chat")
                }
                .tag(1)
            
            meditateContent
                .tabItem {
                    Image(systemName: "figure.mind.and.body")
                    Text("Meditate")
                }
                .tag(2)
            
            progressContent
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Progress")
                }
                .tag(3)
        }
        .accentColor(modernColors.primary)
    }
    
    // MARK: - Home Content
    private var homeContent: some View {
        ScrollView {
            LazyVStack(spacing: DesignSystem.Spacing.lg) {
                // Dynamic hero header
                dynamicHeroHeader
                
                // Quick stats dashboard
                quickStatsGrid
                
                // Today's focus
                todaysFocusCard
                
                // Achievement progress
                achievementProgressCard
                
                // Action center
                actionCenterCard
                
                // Weekly challenge
                weeklyChallengeCard
                
                Spacer(minLength: DesignSystem.Spacing.xl)
            }
            .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        }
        .background(
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: [modernColors.backgroundTop, modernColors.backgroundBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Animated background elements
                GeometryReader { geometry in
                    ForEach(0..<3) { i in
                        Circle()
                            .fill(modernColors.accent.opacity(0.03))
                            .frame(width: 200, height: 200)
                            .offset(
                                x: geometry.size.width * (0.2 + 0.3 * Double(i)),
                                y: geometry.size.height * (0.1 + 0.4 * Double(i))
                            )
                    }
                }
                .allowsHitTesting(false)
            }
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(0.5)) {
                animateProgress = true
            }
        }
    }
    
    private var dynamicHeroHeader: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                    Text(motivationalGreeting)
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [modernColors.primary, modernColors.accent],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Ready to level up your mindfulness?")
                        .font(DesignSystem.Typography.body)
                        .foregroundStyle(modernColors.textSecondary)
                }
                
                Spacer()
                
                // Notification/Profile button with badge
                ZStack(alignment: .topTrailing) {
                    Button {
                        // Profile
                    } label: {
                        AsyncImage(url: nil) { _ in
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [modernColors.primary, modernColors.accent],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                }
                        } placeholder: {
                            Circle()
                                .fill(DesignSystem.Colors.neutral300)
                                .frame(width: 44, height: 44)
                        }
                    }
                    
                    // Streak badge
                    Circle()
                        .fill(modernColors.success)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Text("7")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .offset(x: 6, y: -6)
                }
            }
            
            // Energy level indicator
            energyLevelIndicator
        }
        .padding(.top, DesignSystem.Spacing.lg)
    }
    
    private var energyLevelIndicator: some View {
        HStack {
            Text("Energy Level")
                .font(DesignSystem.Typography.bodySmall)
                .fontWeight(.medium)
                .foregroundStyle(modernColors.textSecondary)
            
            Spacer()
            
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { level in
                    Capsule()
                        .fill(level <= 3 ? modernColors.primary : modernColors.inactive)
                        .frame(width: 20, height: 8)
                        .scaleEffect(y: level <= 3 ? 1.0 : 0.6)
                        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(Double(level) * 0.1), value: animateProgress)
                }
            }
            
            Text("Good")
                .font(DesignSystem.Typography.bodySmall)
                .fontWeight(.semibold)
                .foregroundStyle(modernColors.primary)
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.vertical, DesignSystem.Spacing.md)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
        }
    }
    
    private var quickStatsGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: DesignSystem.Spacing.md) {
            statCard(
                icon: "flame.fill",
                value: "7",
                label: "Day Streak",
                color: modernColors.streakColor,
                trend: "+2 from last week"
            )
            
            statCard(
                icon: "timer",
                value: "24m",
                label: "Today",
                color: modernColors.timeColor,
                trend: "Personal record!"
            )
            
            statCard(
                icon: "brain.head.profile",
                value: "12",
                label: "Sessions",
                color: modernColors.sessionColor,
                trend: "This week"
            )
            
            statCard(
                icon: "target",
                value: "85%",
                label: "Goals Met",
                color: modernColors.goalColor,
                trend: "+15% improvement"
            )
        }
    }
    
    private func statCard(icon: String, value: String, label: String, color: Color, trend: String) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(color)
                
                Spacer()
                
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(modernColors.success)
            }
            
            Text(value)
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(modernColors.textPrimary)
            
            Text(label)
                .font(DesignSystem.Typography.bodySmall)
                .fontWeight(.medium)
                .foregroundStyle(modernColors.textSecondary)
            
            Text(trend)
                .font(DesignSystem.Typography.caption)
                .foregroundStyle(modernColors.success)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DesignSystem.Spacing.lg)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
        }
    }
    
    private var todaysFocusCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "target")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(modernColors.focus)
                
                Text("Today's Focus")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.bold)
                    .foregroundStyle(modernColors.textPrimary)
                
                Spacer()
                
                Text("12 min")
                    .font(DesignSystem.Typography.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(modernColors.textSecondary)
                    .padding(.horizontal, DesignSystem.Spacing.sm)
                    .padding(.vertical, DesignSystem.Spacing.xs)
                    .background {
                        Capsule()
                            .fill(modernColors.tagBackground)
                    }
            }
            
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                Text("Stress Relief Power Session")
                    .font(DesignSystem.Typography.bodyLarge)
                    .fontWeight(.bold)
                    .foregroundStyle(modernColors.textPrimary)
                
                Text("Scientifically designed breathing techniques to reduce cortisol levels and boost mental clarity.")
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(modernColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            HStack {
                Button {
                    selectedTab = 2
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Session")
                    }
                }
                .buttonStyle(ModernPrimaryButtonStyle())
                
                Button {
                    // More info
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 20))
                        .foregroundStyle(modernColors.textSecondary)
                }
                .frame(width: 44, height: 44)
                .background {
                    Circle()
                        .fill(modernColors.secondaryButtonBackground)
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(
                    LinearGradient(
                        colors: [modernColors.focusGradient1, modernColors.focusGradient2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                }
        }
    }
    
    private var achievementProgressCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(modernColors.achievement)
                
                Text("Achievement Progress")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.bold)
                    .foregroundStyle(modernColors.textPrimary)
                
                Spacer()
            }
            
            VStack(spacing: DesignSystem.Spacing.md) {
                achievementRow(
                    title: "Mindfulness Master",
                    subtitle: "Complete 30 meditation sessions",
                    progress: 0.4,
                    current: 12,
                    total: 30
                )
                
                achievementRow(
                    title: "Consistency Champion",
                    subtitle: "7-day meditation streak",
                    progress: 1.0,
                    current: 7,
                    total: 7,
                    completed: true
                )
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
        }
    }
    
    private func achievementRow(title: String, subtitle: String, progress: Double, current: Int, total: Int, completed: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text(title)
                        .font(DesignSystem.Typography.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(modernColors.textPrimary)
                    
                    Text(subtitle)
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundStyle(modernColors.textSecondary)
                }
                
                Spacer()
                
                if completed {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(modernColors.success)
                } else {
                    Text("\(current)/\(total)")
                        .font(DesignSystem.Typography.bodySmall)
                        .fontWeight(.semibold)
                        .foregroundStyle(modernColors.textSecondary)
                }
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(modernColors.progressBackground)
                        .frame(height: 6)
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: completed ? [modernColors.success, modernColors.success.opacity(0.7)] : [modernColors.primary, modernColors.accent],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: animateProgress ? geometry.size.width * progress : 0,
                            height: 6
                        )
                        .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.3), value: animateProgress)
                }
            }
            .frame(height: 6)
        }
    }
    
    private var actionCenterCard: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack {
                Text("Quick Actions")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.bold)
                    .foregroundStyle(modernColors.textPrimary)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                quickActionButton(
                    icon: "brain.head.profile",
                    title: "AI Chat",
                    subtitle: "Get support",
                    color: modernColors.chatColor
                ) {
                    selectedTab = 1
                }
                
                quickActionButton(
                    icon: "figure.mind.and.body",
                    title: "Meditate",
                    subtitle: "Find peace",
                    color: modernColors.meditateColor
                ) {
                    selectedTab = 2
                }
                
                quickActionButton(
                    icon: "heart.text.square",
                    title: "Mood Check",
                    subtitle: "Track feelings",
                    color: modernColors.moodColor
                ) {
                    showMoodPicker = true
                }
                
                quickActionButton(
                    icon: "chart.xyaxis.line",
                    title: "Progress",
                    subtitle: "See growth",
                    color: modernColors.progressColor
                ) {
                    selectedTab = 3
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
        }
    }
    
    private func quickActionButton(icon: String, title: String, subtitle: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: DesignSystem.Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(color)
                    .frame(width: 44, height: 44)
                    .background {
                        Circle()
                            .fill(color.opacity(0.1))
                    }
                
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Text(title)
                        .font(DesignSystem.Typography.bodySmall)
                        .fontWeight(.semibold)
                        .foregroundStyle(modernColors.textPrimary)
                    
                    Text(subtitle)
                        .font(DesignSystem.Typography.caption)
                        .foregroundStyle(modernColors.textSecondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(DesignSystem.Spacing.md)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                    .fill(color.opacity(0.05))
                    .overlay {
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                            .stroke(color.opacity(0.2), lineWidth: 1)
                    }
            }
        }
        .buttonStyle(.plain)
    }
    
    private var weeklyChallengeCard: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Image(systemName: "star.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(modernColors.challenge)
                
                Text("Weekly Challenge")
                    .font(DesignSystem.Typography.h4)
                    .fontWeight(.bold)
                    .foregroundStyle(modernColors.textPrimary)
                
                Spacer()
                
                Text("3 days left")
                    .font(DesignSystem.Typography.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(modernColors.textSecondary)
                    .padding(.horizontal, DesignSystem.Spacing.sm)
                    .padding(.vertical, DesignSystem.Spacing.xs)
                    .background {
                        Capsule()
                            .fill(modernColors.tagBackground)
                    }
            }
            
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                Text("Mindful Minutes Marathon")
                    .font(DesignSystem.Typography.bodyLarge)
                    .fontWeight(.bold)
                    .foregroundStyle(modernColors.textPrimary)
                
                Text("Meditate for 10 minutes daily this week to unlock the \"Consistency Champion\" badge.")
                    .font(DesignSystem.Typography.body)
                    .foregroundStyle(modernColors.textSecondary)
                
                // Challenge progress
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(modernColors.progressBackground)
                            .frame(height: 8)
                        
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [modernColors.challenge, modernColors.challengeAccent],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(
                                width: animateProgress ? geometry.size.width * 0.57 : 0,
                                height: 8
                            )
                            .animation(.spring(response: 1.0, dampingFraction: 0.8).delay(0.7), value: animateProgress)
                    }
                }
                .frame(height: 8)
                
                HStack {
                    Text("4/7 days complete")
                        .font(DesignSystem.Typography.bodySmall)
                        .fontWeight(.medium)
                        .foregroundStyle(modernColors.textSecondary)
                    
                    Spacer()
                    
                    Text("57%")
                        .font(DesignSystem.Typography.bodySmall)
                        .fontWeight(.bold)
                        .foregroundStyle(modernColors.challenge)
                }
            }
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(
                    LinearGradient(
                        colors: [modernColors.challengeGradient1, modernColors.challengeGradient2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                }
        }
    }
    
    // MARK: - Placeholder Content
    private var chatContent: some View {
        VStack {
            Text("AI Brain Chat")
                .font(DesignSystem.Typography.h2)
            Text("Coming soon...")
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(modernColors.backgroundTop)
    }
    
    private var meditateContent: some View {
        VStack {
            Text("Meditation Studio")
                .font(DesignSystem.Typography.h2)
            Text("Coming soon...")
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(modernColors.backgroundTop)
    }
    
    private var progressContent: some View {
        VStack {
            Text("Analytics Dashboard")
                .font(DesignSystem.Typography.h2)
            Text("Coming soon...")
                .foregroundStyle(DesignSystem.Colors.neutral500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(modernColors.backgroundTop)
    }
    
    // MARK: - Helper Functions
    private var motivationalGreeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Rise & Thrive"
        case 12..<17: return "Power Hour"
        case 17..<21: return "Wind Down"
        default: return "Rest Mode"
        }
    }
}

// MARK: - Modern Color Palette
private struct ModernColorPalette {
    let primary = Color(hex: "007AFF") // iOS blue
    let accent = Color(hex: "5856D6") // Purple
    let backgroundTop = Color(hex: "F8F9FA") // Light gray top
    let backgroundBottom = Color(hex: "FFFFFF") // White bottom
    let textPrimary = Color(hex: "1D1D1F") // Apple text
    let textSecondary = Color(hex: "6E6E73") // Secondary text
    let streakColor = Color(hex: "FF3B30") // Red
    let timeColor = Color(hex: "30D158") // Green
    let sessionColor = Color(hex: "BF5AF2") // Purple
    let goalColor = Color(hex: "FF9500") // Orange
    let focus = Color(hex: "0A84FF") // Blue
    let success = Color(hex: "30D158") // Green
    let achievement = Color(hex: "FFD60A") // Yellow
    let challenge = Color(hex: "FF375F") // Pink
    let challengeAccent = Color(hex: "FF6B9D")
    let inactive = Color(hex: "E5E5EA")
    let tagBackground = Color(hex: "E5E5EA")
    let progressBackground = Color(hex: "E5E5EA")
    let secondaryButtonBackground = Color(hex: "F2F2F7")
    let focusGradient1 = Color(hex: "0A84FF").opacity(0.1)
    let focusGradient2 = Color(hex: "5856D6").opacity(0.1)
    let challengeGradient1 = Color(hex: "FF375F").opacity(0.1)
    let challengeGradient2 = Color(hex: "FF6B9D").opacity(0.1)
    
    // Quick action colors
    let chatColor = Color(hex: "007AFF")
    let meditateColor = Color(hex: "30D158")
    let moodColor = Color(hex: "FF375F")
    let progressColor = Color(hex: "FF9500")
}

// MARK: - Modern Button Style
private struct ModernPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "007AFF"), Color(hex: "5856D6")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    HomeView_ModernEnergetic()
}