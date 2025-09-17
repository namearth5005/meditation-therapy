import SwiftUI
import Foundation

// MARK: - Enhanced Meditation Session with Glass Effects & 3D Visualizations
// Integrating iOS 26 Liquid Glass design with @Animatable breathing patterns

@available(iOS 18.0, *)
public struct EnhancedMeditationSessionView: View {
    @State private var sessionState: SessionState = .ready
    @State private var currentSession: ActiveMeditationSession?
    @State private var selectedDuration: TimeInterval = 10 * 60
    @State private var selectedType: MeditationCategory = .anxiety
    @State private var breathingPhase: Double = 0
    @State private var sessionTimer: Timer?
    @Namespace private var glassEffectNamespace
    
    private let colors = PerfectBlendColors()
    
    private let availableDurations: [(String, TimeInterval)] = [
        ("5 min", 5 * 60),
        ("10 min", 10 * 60),
        ("15 min", 15 * 60),
        ("20 min", 20 * 60),
        ("30 min", 30 * 60)
    ]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Background Extension Effect
                backgroundView
                    .backgroundExtensionEffect()
                
                VStack(spacing: 0) {
                    switch sessionState {
                    case .ready:
                        sessionSetupView
                    case .active:
                        activeSessionView
                    case .completed(let summary):
                        sessionCompletedView(summary)
                    }
                }
            }
            .navigationTitle("Mindful Session")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Spacer()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Analytics") {
                        // Navigate to 3D analytics
                    }
                    .buttonStyle(.glass)
                }
            }
        }
    }
    
    // MARK: - Background View
    private var backgroundView: some View {
        LinearGradient(
            colors: [
                colors.background,
                selectedType.gradientColors.first?.opacity(0.1) ?? colors.background,
                colors.background
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // MARK: - Session Setup View
    private var sessionSetupView: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Hero Section with Glass Effects
                heroSection
                    .glassEffect(.regular.tint(selectedType.gradientColors.first?.opacity(0.2) ?? .clear))
                
                // Glass Effect Container for Controls
                GlassEffectContainer {
                    sessionTypeSelection
                        .glassEffectID("session-controls", in: glassEffectNamespace)
                    
                    durationSelection
                        .glassEffectID("session-controls", in: glassEffectNamespace)
                }
                
                // Start Button with Glass Effect
                startSessionButton
                    .glassEffect(.interactive)
            }
            .padding()
        }
        .scrollEdgeEffectStyle(.soft, for: .all)
    }
    
    private var heroSection: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            // Animated Icon based on selected category
            ZStack {
                Circle()
                    .fill(.regularMaterial)
                    .frame(width: 120, height: 120)
                
                AnimatedCategoryIcon(category: selectedType)
                    .font(.system(size: 50))
                    .foregroundStyle(selectedType.gradientColors.first ?? .blue)
            }
            
            VStack(spacing: DesignSystem.Spacing.sm) {
                Text("Ready to Begin")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(colors.textPrimary)
                
                Text("Choose your meditation style and duration")
                    .font(.body)
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, DesignSystem.Spacing.xl)
    }
    
    private var sessionTypeSelection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
            Text("Meditation Type")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                ForEach(MeditationCategory.allCases, id: \.self) { type in
                    EnhancedSessionTypeCard(
                        category: type,
                        isSelected: selectedType == type
                    ) {
                        withAnimation(.spring(response: 0.6)) {
                            selectedType = type
                        }
                    }
                    .glassEffect(.regular.tint(type.gradientColors.first?.opacity(0.1) ?? .clear))
                }
            }
        }
    }
    
    private var durationSelection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
            Text("Duration")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                ForEach(availableDurations, id: \.0) { label, duration in
                    DurationChipGlass(
                        label: label,
                        isSelected: selectedDuration == duration
                    ) {
                        withAnimation(.spring()) {
                            selectedDuration = duration
                        }
                    }
                }
            }
        }
    }
    
    private var startSessionButton: some View {
        Button {
            startSession()
        } label: {
            HStack(spacing: DesignSystem.Spacing.sm) {
                Image(systemName: "play.fill")
                Text("Begin Session")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                    .fill(.linearGradient(
                        colors: selectedType.gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
            }
            .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Active Session View
    private var activeSessionView: some View {
        VStack(spacing: DesignSystem.Spacing.xl) {
            Spacer()
            
            // Enhanced Progress Visualization
            ZStack {
                // Background Circle
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 8)
                    .frame(width: 280, height: 280)
                
                // Progress Circle
                Circle()
                    .trim(from: 0, to: currentSession?.progress ?? 0)
                    .stroke(
                        .linearGradient(
                            colors: selectedType.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 280, height: 280)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: currentSession?.progress)
                
                // @Animatable Breathing Visualization
                BreathingVisualization(
                    breathingPhase: breathingPhase,
                    category: selectedType
                )
                .frame(width: 200, height: 200)
                
                // Time Display
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Text(formatTime(currentSession?.remainingTime ?? 0))
                        .font(.system(size: 42, weight: .light, design: .monospaced))
                        .foregroundStyle(colors.textPrimary)
                    
                    Text(selectedType.title)
                        .font(.title3)
                        .foregroundStyle(colors.textSecondary)
                }
            }
            .glassEffect(.regular.tint(selectedType.gradientColors.first?.opacity(0.1) ?? .clear))
            
            // Session Guidance
            sessionGuidanceView
            
            Spacer()
            
            // Glass Effect Controls
            GlassEffectContainer {
                sessionControlButtons
                    .glassEffectID("active-controls", in: glassEffectNamespace)
            }
            .padding(.bottom, DesignSystem.Spacing.xl)
        }
        .padding()
        .onAppear {
            startSessionTimer()
            startBreathingAnimation()
        }
        .onDisappear {
            sessionTimer?.invalidate()
        }
    }
    
    private var sessionGuidanceView: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text(getSessionGuidance(for: selectedType))
                .font(.body)
                .foregroundStyle(colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if selectedType == .anxiety || selectedType == .stress {
                Text("Follow the breathing pattern above")
                    .font(.caption)
                    .foregroundStyle(colors.textSecondary)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(.regularMaterial)
                .glassEffect(.regular.tint(.blue.opacity(0.05)))
        }
        .padding(.horizontal)
    }
    
    private var sessionControlButtons: some View {
        HStack(spacing: DesignSystem.Spacing.lg) {
            Button("Pause") {
                pauseSession()
            }
            .buttonStyle(.glass)
            .foregroundStyle(.blue)
            
            Spacer()
            
            Button("End Session") {
                endSession()
            }
            .buttonStyle(.glass)
            .foregroundStyle(.red)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Session Completed View
    private func sessionCompletedView(_ summary: SessionSummary) -> some View {
        VStack(spacing: DesignSystem.Spacing.xl) {
            Spacer()
            
            // Completion Animation
            ZStack {
                Circle()
                    .fill(.green.opacity(0.1))
                    .frame(width: 120, height: 120)
                    .glassEffect(.regular.tint(.green.opacity(0.2)))
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.green)
            }
            
            VStack(spacing: DesignSystem.Spacing.sm) {
                Text("Session Complete!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(colors.textPrimary)
                
                Text("Well done completing your \(summary.type.title.lowercased())")
                    .font(.body)
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // Session Statistics
            sessionStatsView(summary)
            
            Spacer()
            
            Button("Start New Session") {
                resetSession()
            }
            .buttonStyle(.glass)
            .padding(.bottom, DesignSystem.Spacing.xl)
        }
        .padding()
    }
    
    private func sessionStatsView(_ summary: SessionSummary) -> some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: DesignSystem.Spacing.md) {
            StatCard(
                title: "Duration",
                value: formatDuration(summary.actualDuration),
                color: .blue
            )
            
            StatCard(
                title: "Type",
                value: summary.type.title,
                color: .purple
            )
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.regularMaterial)
                .glassEffect()
        }
        .padding(.horizontal)
    }
    
    // MARK: - Session Management
    private func startSession() {
        let session = ActiveMeditationSession(
            type: selectedType,
            plannedDuration: selectedDuration,
            startTime: Date()
        )
        
        currentSession = session
        
        withAnimation(.spring(response: 0.8)) {
            sessionState = .active
        }
    }
    
    private func startSessionTimer() {
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            guard var session = currentSession else { return }
            
            session.updateProgress()
            currentSession = session
            
            if session.remainingTime <= 0 {
                sessionTimer?.invalidate()
                endSession()
            }
        }
    }
    
    private func startBreathingAnimation() {
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            breathingPhase = 1.0
        }
    }
    
    private func pauseSession() {
        sessionTimer?.invalidate()
        // Implementation for pause functionality
    }
    
    private func endSession() {
        guard let session = currentSession else { return }
        
        sessionTimer?.invalidate()
        
        let summary = SessionSummary(
            type: session.type,
            plannedDuration: session.plannedDuration,
            actualDuration: Date().timeIntervalSince(session.startTime),
            completedAt: Date()
        )
        
        withAnimation(.spring(response: 0.8)) {
            sessionState = .completed(summary)
        }
    }
    
    private func resetSession() {
        currentSession = nil
        breathingPhase = 0
        
        withAnimation(.spring()) {
            sessionState = .ready
        }
    }
    
    // MARK: - Helper Methods
    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func formatDuration(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        return "\(minutes)m"
    }
    
    private func getSessionGuidance(for category: MeditationCategory) -> String {
        switch category {
        case .meditation:
            return "Focus on your breath. Notice when your mind wanders and gently bring attention back to breathing."
        case .anxiety:
            return "Take slow, deep breaths. With each exhale, release anxiety and tension from your body."
        case .sleep:
            return "Relax your entire body. Let go of the day's worries and prepare for restful sleep."
        case .focus:
            return "Concentrate on a single point. When distractions arise, acknowledge them and return to focus."
        case .stress:
            return "Breathe deeply and imagine stress melting away with each exhale. Find your center of calm."
        case .energy:
            return "Feel energy flowing through your body with each breath. Embrace vitality and alertness."
        case .selfLove:
            return "Send loving-kindness to yourself. Embrace self-compassion and acceptance."
        case .beginners:
            return "Simply notice your breathing. There's no wrong way to meditate. Be gentle with yourself."
        case .advanced:
            return "Deepen your practice with advanced mindfulness techniques. Explore the depths of awareness."
        }
    }
}

// MARK: - Supporting Types
@available(iOS 18.0, *)
enum SessionState {
    case ready
    case active
    case completed(SessionSummary)
}

@available(iOS 18.0, *)
struct ActiveMeditationSession {
    let type: MeditationCategory
    let plannedDuration: TimeInterval
    let startTime: Date
    
    var elapsedTime: TimeInterval {
        Date().timeIntervalSince(startTime)
    }
    
    var remainingTime: TimeInterval {
        max(0, plannedDuration - elapsedTime)
    }
    
    var progress: Double {
        min(1.0, elapsedTime / plannedDuration)
    }
    
    mutating func updateProgress() {
        // Update any time-dependent properties if needed
    }
}

@available(iOS 18.0, *)
struct SessionSummary {
    let type: MeditationCategory
    let plannedDuration: TimeInterval
    let actualDuration: TimeInterval
    let completedAt: Date
}
@available(iOS 26.0, *)
struct BreathingVisualizationModern: Shape {
    var breathingPhase: Double
    var category: MeditationCategory
    
    var animatableData: Double {
        get { breathingPhase }
        set { breathingPhase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Create breathing pattern based on category
        let baseRadius = rect.width / 4
        let breathingRadius = baseRadius * (0.7 + 0.3 * sin(breathingPhase * .pi))
        
        switch category {
        case .anxiety, .stress:
            // Gentle circular breathing pattern
            path.addEllipse(in: CGRect(
                x: rect.midX - breathingRadius,
                y: rect.midY - breathingRadius,
                width: breathingRadius * 2,
                height: breathingRadius * 2
            ))
            
        case .energy:
            // Dynamic star-like pattern
            let points = 8
            let outerRadius = breathingRadius
            let innerRadius = breathingRadius * 0.6
            
            for i in 0..<points * 2 {
                let angle = Double(i) * .pi / Double(points)
                let radius = i % 2 == 0 ? outerRadius : innerRadius
                let x = rect.midX + cos(angle) * radius
                let y = rect.midY + sin(angle) * radius
                
                if i == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            path.closeSubpath()
            
        default:
            // Default circular pattern
            path.addEllipse(in: CGRect(
                x: rect.midX - breathingRadius,
                y: rect.midY - breathingRadius,
                width: breathingRadius * 2,
                height: breathingRadius * 2
            ))
        }
        
        return path
    }
}

struct BreathingVisualization: Shape {
    var breathingPhase: Double
    var category: MeditationCategory
    
    var animatableData: Double {
        get { breathingPhase }
        set { breathingPhase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Create breathing pattern based on category
        let baseRadius = rect.width / 4
        let breathingRadius = baseRadius * (0.7 + 0.3 * sin(breathingPhase * .pi))
        
        switch category {
        case .anxiety, .stress:
            // Gentle circular breathing pattern
            path.addEllipse(in: CGRect(
                x: rect.midX - breathingRadius,
                y: rect.midY - breathingRadius,
                width: breathingRadius * 2,
                height: breathingRadius * 2
            ))
            
        case .energy:
            // Dynamic star-like pattern
            let points = 8
            let outerRadius = breathingRadius
            let innerRadius = breathingRadius * 0.6
            
            for i in 0..<points * 2 {
                let angle = Double(i) * .pi / Double(points)
                let radius = i % 2 == 0 ? outerRadius : innerRadius
                let x = rect.midX + cos(angle) * radius
                let y = rect.midY + sin(angle) * radius
                
                if i == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            path.closeSubpath()
            
        default:
            // Default circular pattern
            path.addEllipse(in: CGRect(
                x: rect.midX - breathingRadius,
                y: rect.midY - breathingRadius,
                width: breathingRadius * 2,
                height: breathingRadius * 2
            ))
        }
        
        return path
    }
}

// MARK: - Enhanced Components
@available(iOS 18.0, *)
struct AnimatedCategoryIcon: View {
    let category: MeditationCategory
    @State private var isAnimating = false
    
    var body: some View {
        Image(systemName: category.icon)
            .scaleEffect(isAnimating ? 1.1 : 1.0)
            .rotationEffect(.degrees(isAnimating ? 5 : -5))
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

@available(iOS 18.0, *)
struct EnhancedSessionTypeCard: View {
    let category: MeditationCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: DesignSystem.Spacing.sm) {
                Image(systemName: category.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : category.gradientColors.first ?? .blue)
                
                Text(category.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(isSelected ? .white : .primary)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(.linearGradient(
                            colors: category.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                } else {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(.regularMaterial)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

@available(iOS 18.0, *)
struct DurationChipGlass: View {
    let label: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, DesignSystem.Spacing.md)
                .padding(.vertical, DesignSystem.Spacing.sm)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.blue)
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.regularMaterial)
                    }
                }
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(isSelected ? .blue.opacity(0.3) : .clear))
    }
}

@available(iOS 18.0, *)
struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(color)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(color.opacity(0.1))
                .glassEffect(.regular.tint(color.opacity(0.1)))
        }
    }
}

#Preview {
    EnhancedMeditationSessionView()
}
