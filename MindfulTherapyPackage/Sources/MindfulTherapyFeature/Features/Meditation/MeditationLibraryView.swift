import SwiftUI

// MARK: - Custom Shapes
private struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.25))
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height),
            control1: CGPoint(x: width * 0.1, y: height * 0.6),
            control2: CGPoint(x: width * 0.5, y: height * 0.9)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.25),
            control1: CGPoint(x: width * 0.5, y: height * 0.9),
            control2: CGPoint(x: width * 0.9, y: height * 0.6)
        )
        
        return path
    }
}

// MARK: - Meditation Library Gallery View
// Following S-tier design principles: Users First, Meticulous Craft, Focus & Efficiency

public struct MeditationLibraryView: View {
    @State private var selectedCategory: MeditationCategory? = nil
    @State private var searchText = ""
    
    private let colors = PerfectBlendColors()
    
    // Dynamic masonry-style grid with varied sizes
    private let columns = [
        GridItem(.flexible(), spacing: DesignSystem.Spacing.sm),
        GridItem(.flexible(), spacing: DesignSystem.Spacing.sm)
    ]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search and Filter Header
                searchHeader
                
                // Dynamic Gallery Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: DesignSystem.Spacing.sm) {
                        ForEach(Array(filteredMeditations.enumerated()), id: \.element.id) { index, meditation in
                            MeditationCard(
                                meditation: meditation,
                                colors: colors,
                                cardType: cardType(for: index)
                            )
                            .onTapGesture {
                                // Handle meditation selection
                                print("Selected: \(meditation.title)")
                            }
                        }
                    }
                    .padding(.horizontal, DesignSystem.Spacing.screenPadding)
                    .padding(.bottom, 100) // Tab bar spacing
                }
                .background(colors.background)
            }
            .navigationTitle("Meditation Library")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var searchHeader: some View {
        VStack(spacing: 20) {
            // Minimal Search Bar
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textTertiary)
                
                TextField("Search", text: $searchText)
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textPrimary)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(colors.textTertiary)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            }
            
            // Minimal Category Chips
            if !MeditationCategory.allCases.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(MeditationCategory.allCases, id: \.self) { category in
                            Button {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    selectedCategory = selectedCategory == category ? nil : category
                                }
                            } label: {
                                Text(category.displayName)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(selectedCategory == category ? .white : colors.textSecondary)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background {
                                        Capsule()
                                            .fill(selectedCategory == category ? colors.primary : Color(.systemGray6))
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, DesignSystem.Spacing.screenPadding)
                }
            }
        }
        .padding(.vertical, 20)
        .background(colors.background)
    }
    
    private var filteredMeditations: [MeditationSession] {
        var filtered = MeditationData.sessions
        
        // Filter by category
        if let selectedCategory = selectedCategory {
            filtered = filtered.filter { $0.category == selectedCategory }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter { meditation in
                meditation.title.localizedCaseInsensitiveContains(searchText) ||
                meditation.description.localizedCaseInsensitiveContains(searchText) ||
                meditation.instructor.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered
    }
    
    // Create varied card layouts for organic feel
    private func cardType(for index: Int) -> MeditationCardType {
        let pattern = [
            MeditationCardType.large,
            MeditationCardType.regular,
            MeditationCardType.regular,
            MeditationCardType.wide,
            MeditationCardType.regular,
            MeditationCardType.regular
        ]
        return pattern[index % pattern.count]
    }
}

// MARK: - Card Type Enum
enum MeditationCardType {
    case regular
    case large
    case wide
}

// MARK: - Meditation Card Component
private struct MeditationCard: View {
    let meditation: MeditationSession
    let colors: PerfectBlendColors
    let cardType: MeditationCardType
    
    @State private var isPressed = false
    
    var body: some View {
        let mainContent = VStack(spacing: 0) {
            artisticIllustrationArea
            textOverlayArea
        }
        
        return mainContent
            .background(cardBackground)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: isPressed)
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) {
                // Press completed
            } onPressingChanged: { pressing in
                isPressed = pressing
            }
    }
    
    private var artisticIllustrationArea: some View {
        ZStack(alignment: .topLeading) {
            // Background
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(meditation.category.artisticBackground)
                .frame(height: cardHeight)
            
            // Abstract elements
            meditation.category.artisticElements
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.lg))
            
            // Duration badge
            durationBadge
        }
    }
    
    private var durationBadge: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(meditation.duration)m")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        let backgroundFill = Color.black.opacity(0.2)
                        Capsule()
                            .fill(backgroundFill)
                    }
            }
            Spacer()
        }
        .padding(12)
    }
    
    private var textOverlayArea: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(meditation.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(colors.textPrimary)
                .lineLimit(1)
            
            if cardType == .large || cardType == .wide {
                Text(meditation.description)
                    .font(.system(size: 12))
                    .foregroundStyle(colors.textSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(colors.background)
    }
    
    private var cardBackground: some View {
        let shadowColor = Color.black.opacity(0.04)
        let shadowRadius: CGFloat = isPressed ? 4 : 12
        let shadowY: CGFloat = isPressed ? 2 : 6
        
        return RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
            .fill(colors.background)
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
    }
    
    private var cardHeight: CGFloat {
        switch cardType {
        case .regular: return 140
        case .large: return 180
        case .wide: return 160
        }
    }
}


// MARK: - Data Models
public enum MeditationCategory: String, CaseIterable, Sendable {
    case anxiety = "anxiety"
    case sleep = "sleep"
    case focus = "focus"
    case selfLove = "self_love"
    case energy = "energy"
    case stress = "stress"
    case beginners = "beginners"
    case advanced = "advanced"
    
    var displayName: String {
        switch self {
        case .anxiety: return "Anxiety Relief"
        case .sleep: return "Better Sleep"
        case .focus: return "Focus Boost"
        case .selfLove: return "Self-Love"
        case .energy: return "Energy"
        case .stress: return "Stress Relief"
        case .beginners: return "Beginners"
        case .advanced: return "Advanced"
        }
    }
    
    var icon: String {
        switch self {
        case .anxiety: return "leaf.fill"
        case .sleep: return "moon.stars.fill"
        case .focus: return "target"
        case .selfLove: return "heart.fill"
        case .energy: return "bolt.fill"
        case .stress: return "wind"
        case .beginners: return "graduationcap.fill"
        case .advanced: return "mountain.2.fill"
        }
    }
    
    var gradientColors: [Color] {
        switch self {
        case .anxiety:
            return [Color(hex: "84FAB0"), Color(hex: "8FD3F4")]
        case .sleep:
            return [Color(hex: "667eea"), Color(hex: "764ba2")]
        case .focus:
            return [Color(hex: "f093fb"), Color(hex: "f5576c")]
        case .selfLove:
            return [Color(hex: "ffecd2"), Color(hex: "fcb69f")]
        case .energy:
            return [Color(hex: "fdbb2d"), Color(hex: "22c1c3")]
        case .stress:
            return [Color(hex: "a8edea"), Color(hex: "fed6e3")]
        case .beginners:
            return [Color(hex: "d299c2"), Color(hex: "fef9d7")]
        case .advanced:
            return [Color(hex: "89f7fe"), Color(hex: "66a6ff")]
        }
    }
    
    // Artistic, minimalist backgrounds inspired by the reference image
    var artisticBackground: LinearGradient {
        switch self {
        case .anxiety:
            return LinearGradient(
                colors: [Color(hex: "A7F3D0"), Color(hex: "6EE7B7")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .sleep:
            return LinearGradient(
                colors: [Color(hex: "312E81"), Color(hex: "1E1B4B")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .focus:
            return LinearGradient(
                colors: [Color(hex: "F472B6"), Color(hex: "EC4899")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .selfLove:
            return LinearGradient(
                colors: [Color(hex: "FED7AA"), Color(hex: "FDBA74")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .energy:
            return LinearGradient(
                colors: [Color(hex: "FEF08A"), Color(hex: "FDE047")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .stress:
            return LinearGradient(
                colors: [Color(hex: "BFDBFE"), Color(hex: "93C5FD")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .beginners:
            return LinearGradient(
                colors: [Color(hex: "E9D5FF"), Color(hex: "DDD6FE")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .advanced:
            return LinearGradient(
                colors: [Color(hex: "1F2937"), Color(hex: "111827")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    // Abstract artistic elements for each category
    @ViewBuilder
    var artisticElements: some View {
        switch self {
        case .anxiety:
            // Gentle leaves and organic shapes
            ZStack {
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .offset(x: 30, y: -20)
                
                Ellipse()
                    .fill(.white.opacity(0.08))
                    .frame(width: 80, height: 40)
                    .rotationEffect(.degrees(45))
                    .offset(x: -20, y: 40)
            }
            
        case .sleep:
            // Stars and moon elements
            ZStack {
                ForEach(0..<6, id: \.self) { index in
                    Circle()
                        .fill(.white.opacity(0.3))
                        .frame(width: CGFloat.random(in: 2...4))
                        .offset(
                            x: CGFloat.random(in: -40...40),
                            y: CGFloat.random(in: -30...30)
                        )
                }
                
                Circle()
                    .fill(.white.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .offset(x: 25, y: -15)
            }
            
        case .focus:
            // Geometric focus elements
            ZStack {
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.degrees(45))
                    .offset(x: 20, y: -25)
                
                Circle()
                    .stroke(.white.opacity(0.15), lineWidth: 2)
                    .frame(width: 50, height: 50)
                    .offset(x: -15, y: 20)
            }
            
        case .selfLove:
            // Heart and warm shapes
            ZStack {
                Heart()
                    .fill(.white.opacity(0.15))
                    .frame(width: 25, height: 25)
                    .offset(x: 30, y: -20)
                
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 40, height: 40)
                    .offset(x: -20, y: 30)
            }
            
        case .energy:
            // Lightning and energetic shapes
            ZStack {
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 4, height: 30)
                    .rotationEffect(.degrees(15))
                    .offset(x: 25, y: -10)
                
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 20, height: 20)
                    .offset(x: -25, y: 25)
            }
            
        case .stress:
            // Flowing water-like shapes
            ZStack {
                Ellipse()
                    .fill(.white.opacity(0.1))
                    .frame(width: 60, height: 20)
                    .offset(x: 20, y: -15)
                
                Ellipse()
                    .fill(.white.opacity(0.08))
                    .frame(width: 40, height: 15)
                    .offset(x: -15, y: 25)
            }
            
        case .beginners:
            // Simple, welcoming shapes
            ZStack {
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 35, height: 35)
                    .offset(x: 20, y: -20)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.opacity(0.08))
                    .frame(width: 25, height: 25)
                    .offset(x: -20, y: 20)
            }
            
        case .advanced:
            // Complex, sophisticated elements
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 30, y: 15))
                    path.addLine(to: CGPoint(x: 15, y: 30))
                    path.closeSubpath()
                }
                .fill(.white.opacity(0.12))
                .offset(x: 25, y: -15)
                
                Circle()
                    .stroke(.white.opacity(0.1), lineWidth: 1)
                    .frame(width: 40, height: 40)
                    .offset(x: -15, y: 25)
            }
        }
    }
}

public struct MeditationSession: Identifiable, Sendable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let duration: Int // minutes
    public let instructor: String
    public let category: MeditationCategory
    public let rating: Double
    public let isNew: Bool
    public let isPremium: Bool
    
    public init(title: String, description: String, duration: Int, instructor: String, category: MeditationCategory, rating: Double, isNew: Bool = false, isPremium: Bool = false) {
        self.title = title
        self.description = description
        self.duration = duration
        self.instructor = instructor
        self.category = category
        self.rating = rating
        self.isNew = isNew
        self.isPremium = isPremium
    }
}

// MARK: - Sample Data
public struct MeditationData {
    public static let sessions: [MeditationSession] = [
        MeditationSession(
            title: "Morning Anxiety Relief",
            description: "Start your day with calm confidence and peaceful energy",
            duration: 10,
            instructor: "Sarah Chen",
            category: .anxiety,
            rating: 4.8,
            isNew: true
        ),
        MeditationSession(
            title: "Deep Sleep Journey",
            description: "Drift into peaceful, restorative sleep with guided relaxation",
            duration: 20,
            instructor: "Michael Torres",
            category: .sleep,
            rating: 4.9
        ),
        MeditationSession(
            title: "Laser Focus Boost",
            description: "Sharpen your concentration and eliminate mental clutter",
            duration: 15,
            instructor: "Dr. Lisa Park",
            category: .focus,
            rating: 4.7
        ),
        MeditationSession(
            title: "Self-Compassion Practice",
            description: "Cultivate loving-kindness and acceptance for yourself",
            duration: 12,
            instructor: "Emma Rodriguez",
            category: .selfLove,
            rating: 4.9
        ),
        MeditationSession(
            title: "Energy Awakening",
            description: "Revitalize your body and mind with energizing breathwork",
            duration: 8,
            instructor: "James Wilson",
            category: .energy,
            rating: 4.6
        ),
        MeditationSession(
            title: "Stress Release Flow",
            description: "Let go of tension and find your natural state of peace",
            duration: 18,
            instructor: "Maya Patel",
            category: .stress,
            rating: 4.8
        ),
        MeditationSession(
            title: "Mindfulness for Beginners",
            description: "Your gentle introduction to meditation practice",
            duration: 5,
            instructor: "Tom Anderson",
            category: .beginners,
            rating: 4.7
        ),
        MeditationSession(
            title: "Advanced Vipassana",
            description: "Deep insight meditation for experienced practitioners",
            duration: 45,
            instructor: "Zen Master Koji",
            category: .advanced,
            rating: 4.9,
            isPremium: true
        ),
        MeditationSession(
            title: "Quick Anxiety Reset",
            description: "Rapid relief for overwhelming moments",
            duration: 3,
            instructor: "Dr. Rachel Kim",
            category: .anxiety,
            rating: 4.5,
            isNew: true
        ),
        MeditationSession(
            title: "Bedtime Story Meditation",
            description: "Gentle storytelling to guide you into dreamland",
            duration: 25,
            instructor: "Sofia Martinez",
            category: .sleep,
            rating: 4.8
        )
    ]
}

#Preview {
    MeditationLibraryView()
}