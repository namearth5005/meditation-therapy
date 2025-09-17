import SwiftUI
import WebKit

// MARK: - Native WebView Integration for Guided Content
// Using iOS 26's native SwiftUI WebView capabilities

@available(iOS 18.0, *)
public struct MeditationWebContentView: View {
    @State private var webPage = WebPage()
    @State private var isLoading = true
    @State private var loadingProgress: Double = 0
    let contentURL: URL
    
    private let colors = PerfectBlendColors()
    
    public init(contentURL: URL) {
        self.contentURL = contentURL
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Native iOS 26 WebView
                WebView(webPage)
                    .glassEffect(.regular.tint(.blue.opacity(0.1)))
                    .onAppear {
                        webPage.load(contentURL)
                    }
                    .onChange(of: webPage.isLoading) { _, newValue in
                        isLoading = newValue
                    }
                    .onChange(of: webPage.estimatedProgress) { _, newValue in
                        loadingProgress = newValue
                    }
                
                // Loading Overlay
                if isLoading {
                    loadingOverlay
                }
            }
            .navigationTitle(webPage.title ?? "Meditation Guide")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Refresh") {
                            if #available(iOS 26.0, *) {
                                webPage.reload()
                            }
                        }
                        
                        Button("Share") {
                            // Share content
                        }
                        
                        Button("Open in Safari") {
                            UIApplication.shared.open(contentURL)
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    .buttonStyle(.glass)
                }
            }
        }
    }
    
    private var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: DesignSystem.Spacing.lg) {
                ProgressView()
                    .scaleEffect(1.2)
                    .tint(colors.primary)
                
                Text("Loading meditation content...")
                    .font(.body)
                    .foregroundStyle(colors.textPrimary)
                
                if loadingProgress > 0 && loadingProgress < 1 {
                    ProgressView(value: loadingProgress)
                        .frame(width: 200)
                        .tint(colors.primary)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                    .fill(.regularMaterial)
                    .glassEffect()
            }
        }
    }
}

// MARK: - Native iOS 26 WebPage Class  
class WebPage: ObservableObject {
    @Published var title: String?
    @Published var isLoading = false
    @Published var estimatedProgress: Double = 0
    @Published var canGoBack = false
    @Published var canGoForward = false
    
    private var webView: WKWebView?
    
    func load(_ url: URL) {
        // Implementation would interface with native SwiftUI WebView
        // This is a conceptual implementation for iOS 26
        isLoading = true
        title = url.host
        
        // Simulate loading progress
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.estimatedProgress += 0.1
            if self.estimatedProgress >= 1.0 {
                self.isLoading = false
                self.estimatedProgress = 1.0
                timer.invalidate()
            }
        }
    }
    
    func reload() {
        // Reload implementation
    }
    
    func goBack() {
        // Navigation implementation
    }
    
    func goForward() {
        // Navigation implementation
    }
}


// MARK: - Meditation Content Hub
@available(iOS 18.0, *)
public struct MeditationContentHubView: View {
    @State private var selectedContent: ContentType = .guides
    @State private var searchText = ""
    
    private let colors = PerfectBlendColors()
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Content Type Selector
                contentTypeSelector
                    .glassEffect(.regular.tint(.blue.opacity(0.05)))
                
                // Search Bar
                searchBar
                    .padding()
                
                // Content Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: DesignSystem.Spacing.md) {
                        ForEach(filteredContent, id: \.title) { content in
                            ContentCard(content: content)
                        }
                    }
                    .padding()
                }
                .scrollEdgeEffectStyle(.soft, for: .all)
            }
            .background(Color(.systemBackground))
            .backgroundExtensionEffect()
            .navigationTitle("Meditation Content")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var contentTypeSelector: some View {
        HStack(spacing: 0) {
            ForEach(ContentType.allCases, id: \.self) { type in
                Button {
                    withAnimation(.spring()) {
                        selectedContent = type
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: type.icon)
                            .font(.title3)
                        Text(type.title)
                            .font(.caption)
                    }
                    .foregroundStyle(selectedContent == type ? colors.primary : .secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                .buttonStyle(.plain)
            }
        }
        .background {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(colors.primary.opacity(0.1))
                    .frame(width: geometry.size.width / CGFloat(ContentType.allCases.count))
                    .offset(x: geometry.size.width / CGFloat(ContentType.allCases.count) * CGFloat(ContentType.allCases.firstIndex(of: selectedContent) ?? 0))
                    .animation(.spring(), value: selectedContent)
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Search meditation content...", text: $searchText)
                .textFieldStyle(.plain)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(.regularMaterial)
                .glassEffect()
        }
    }
    
    private var filteredContent: [MeditationContent] {
        let baseContent = MeditationContentData.content(for: selectedContent)
        
        if searchText.isEmpty {
            return baseContent
        } else {
            return baseContent.filter { content in
                content.title.localizedCaseInsensitiveContains(searchText) ||
                content.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

// MARK: - Content Card Component
@available(iOS 18.0, *)
struct ContentCard: View {
    let content: MeditationContent
    private let colors = PerfectBlendColors()
    
    var body: some View {
        NavigationLink {
            if let url = content.url {
                MeditationWebContentView(contentURL: url)
            } else {
                Text("Content not available")
            }
        } label: {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                // Content Image/Icon
                ZStack {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                        .fill(.linearGradient(
                            colors: content.type.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 120)
                    
                    Image(systemName: content.type.icon)
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(content.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(colors.textPrimary)
                        .lineLimit(2)
                    
                    Text(content.description)
                        .font(.caption)
                        .foregroundStyle(colors.textSecondary)
                        .lineLimit(3)
                    
                    HStack {
                        Label(content.duration, systemImage: "clock")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        if content.isPremium {
                            Image(systemName: "crown.fill")
                                .font(.caption2)
                                .foregroundStyle(.orange)
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .buttonStyle(.plain)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(.regularMaterial)
                .glassEffect(.regular.tint(content.type.gradientColors.first?.opacity(0.1) ?? .clear))
        }
    }
}

// MARK: - Supporting Types
@available(iOS 18.0, *)
enum ContentType: String, CaseIterable {
    case guides = "guides"
    case videos = "videos"
    case articles = "articles"
    case exercises = "exercises"
    
    var title: String {
        switch self {
        case .guides: return "Guides"
        case .videos: return "Videos"
        case .articles: return "Articles"
        case .exercises: return "Exercises"
        }
    }
    
    var icon: String {
        switch self {
        case .guides: return "book.fill"
        case .videos: return "play.rectangle.fill"
        case .articles: return "doc.text.fill"
        case .exercises: return "figure.mind.and.body"
        }
    }
    
    var gradientColors: [Color] {
        switch self {
        case .guides: return [.blue, .purple]
        case .videos: return [.red, .pink]
        case .articles: return [.green, .mint]
        case .exercises: return [.orange, .yellow]
        }
    }
}

@available(iOS 18.0, *)
struct MeditationContent {
    let title: String
    let description: String
    let type: ContentType
    let duration: String
    let url: URL?
    let isPremium: Bool
    
    init(title: String, description: String, type: ContentType, duration: String, urlString: String? = nil, isPremium: Bool = false) {
        self.title = title
        self.description = description
        self.type = type
        self.duration = duration
        self.url = urlString != nil ? URL(string: urlString!) : nil
        self.isPremium = isPremium
    }
}

// MARK: - Sample Content Data
@available(iOS 18.0, *)
struct MeditationContentData {
    static func content(for type: ContentType) -> [MeditationContent] {
        switch type {
        case .guides:
            return [
                MeditationContent(
                    title: "Beginner's Guide to Mindfulness",
                    description: "Learn the fundamentals of mindfulness meditation with step-by-step instructions",
                    type: .guides,
                    duration: "10 min read",
                    urlString: "https://example.com/beginners-guide"
                ),
                MeditationContent(
                    title: "Advanced Breathing Techniques",
                    description: "Master advanced pranayama practices for deeper meditation states",
                    type: .guides,
                    duration: "15 min read",
                    urlString: "https://example.com/breathing-techniques",
                    isPremium: true
                ),
                MeditationContent(
                    title: "Meditation Postures Guide",
                    description: "Find the perfect posture for your meditation practice",
                    type: .guides,
                    duration: "8 min read",
                    urlString: "https://example.com/postures"
                )
            ]
            
        case .videos:
            return [
                MeditationContent(
                    title: "5-Minute Morning Meditation",
                    description: "Start your day with this energizing guided meditation",
                    type: .videos,
                    duration: "5 min",
                    urlString: "https://example.com/morning-meditation"
                ),
                MeditationContent(
                    title: "Body Scan Relaxation",
                    description: "Progressive relaxation through mindful body awareness",
                    type: .videos,
                    duration: "20 min",
                    urlString: "https://example.com/body-scan"
                ),
                MeditationContent(
                    title: "Walking Meditation Tutorial",
                    description: "Learn mindful walking techniques for active meditation",
                    type: .videos,
                    duration: "12 min",
                    urlString: "https://example.com/walking-meditation",
                    isPremium: true
                )
            ]
            
        case .articles:
            return [
                MeditationContent(
                    title: "The Science of Meditation",
                    description: "Research-backed benefits of regular meditation practice",
                    type: .articles,
                    duration: "12 min read",
                    urlString: "https://example.com/science-meditation"
                ),
                MeditationContent(
                    title: "Meditation in Daily Life",
                    description: "How to integrate mindfulness into your busy schedule",
                    type: .articles,
                    duration: "8 min read",
                    urlString: "https://example.com/daily-meditation"
                ),
                MeditationContent(
                    title: "Dealing with Racing Thoughts",
                    description: "Strategies for managing an overactive mind during meditation",
                    type: .articles,
                    duration: "6 min read",
                    urlString: "https://example.com/racing-thoughts"
                )
            ]
            
        case .exercises:
            return [
                MeditationContent(
                    title: "4-7-8 Breathing Exercise",
                    description: "Calming breath pattern for stress relief and better sleep",
                    type: .exercises,
                    duration: "3 min",
                    urlString: "https://example.com/478-breathing"
                ),
                MeditationContent(
                    title: "Loving-Kindness Practice",
                    description: "Cultivate compassion for yourself and others",
                    type: .exercises,
                    duration: "10 min",
                    urlString: "https://example.com/loving-kindness"
                ),
                MeditationContent(
                    title: "Mindful Eating Exercise",
                    description: "Transform meals into mindfulness opportunities",
                    type: .exercises,
                    duration: "15 min",
                    urlString: "https://example.com/mindful-eating",
                    isPremium: true
                )
            ]
        }
    }
}

#Preview {
    MeditationContentHubView()
}