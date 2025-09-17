import SwiftUI
import Charts

// MARK: - 3D Meditation Analytics Dashboard
// Revolutionary 3D data visualization using Chart3D from iOS 26

@available(iOS 18.0, *)
public struct MeditationAnalytics3DView: View {
    @State private var selectedVisualization: VisualizationType = .progressJourney
    @State private var timeRange: TimeRange = .lastMonth
    @State private var showingDetails = false
    @State private var selectedDataPoint: MeditationAnalytics?
    
    private let colors = PerfectBlendColors()
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Control Header with Glass Effects
                controlHeader
                    .glassEffect()
                
                // Main 3D Visualization Area
                mainVisualizationArea
                    .backgroundExtensionEffect()
                
                // Insights Summary
                insightsSummary
                    .glassEffect(.regular.tint(.blue.opacity(0.1)))
            }
            .background(Color(.systemBackground))
            .navigationTitle("Analytics")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Details") {
                        showingDetails = true
                    }
                    .buttonStyle(.glass)
                }
            }
        }
        .sheet(isPresented: $showingDetails) {
            DetailedAnalyticsView()
        }
    }
    
    // MARK: - Control Header
    private var controlHeader: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            // Visualization Type Picker
            Picker("Visualization", selection: $selectedVisualization) {
                ForEach(VisualizationType.allCases, id: \.self) { type in
                    Text(type.displayName).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            // Time Range Selector
            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(TimeRange.allCases, id: \.self) { range in
                    Button(range.displayName) {
                        withAnimation(.spring(response: 0.6)) {
                            timeRange = range
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(timeRange == range ? colors.primary : .secondary)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    // MARK: - Main Visualization Area
    private var mainVisualizationArea: some View {
        VStack {
            switch selectedVisualization {
            case .progressJourney:
                progress3DChart
            case .categoryPerformance:
                categoryPerformance3DChart
            case .wellnessSurface:
                wellnessSurfaceChart
            case .moodCorrelation:
                moodCorrelation3DChart
            }
        }
        .frame(height: 400)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(Color(.systemBackground))
                .glassEffect(.interactive)
        }
        .padding()
    }
    
    // MARK: - 3D Progress Journey Chart
    private var progress3DChart: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Your Meditation Journey")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            Text("Progress over time showing duration, mood improvement, and effectiveness")
                .font(.caption)
                .foregroundStyle(colors.textSecondary)
            
            // Native iOS 26 Chart3D - 3D Point Chart
            Chart3D(filteredAnalytics) { session in
                PointMark(
                    x: .value("Days", session.daysSinceStart),
                    y: .value("Duration (min)", session.duration),
                    z: .value("Mood Improvement", session.moodImprovement)
                )
                .foregroundStyle(by: .value("Category", session.category.title))
                .symbol(by: .value("Category", session.category.title))
            }
            .glassEffect(.regular.tint(.blue.opacity(0.2)))
            .onTapGesture { location in
                // Handle 3D chart interaction
                handleChartTap(at: location)
            }
        }
    }
    
    // MARK: - 3D Category Performance Chart
    private var categoryPerformance3DChart: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Category Performance Analysis")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            Text("Effectiveness vs. preference vs. frequency across meditation types")
                .font(.caption)
                .foregroundStyle(colors.textSecondary)
            
            Chart3D(MeditationAnalyticsData.categoryPerformance) { performance in
                PointMark(
                    x: .value("Effectiveness", performance.averageEffectiveness),
                    y: .value("Preference", performance.userPreferenceRating),
                    z: .value("Frequency", Double(performance.totalSessions))
                )
                .foregroundStyle(performance.category.gradientColors.first ?? .blue)
                .symbol(.circle)
                // Size represents session count
                .symbolSize(.constant(performance.size * 100))
            }
            .glassEffect(.interactive)
        }
    }
    
    // MARK: - 3D Wellness Surface Chart
    private var wellnessSurfaceChart: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Optimal Wellness Landscape")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            Text("Surface plot showing ideal meditation times and durations")
                .font(.caption)
                .foregroundStyle(colors.textSecondary)
            
            Chart3D {
                SurfacePlot(x: "Time of Day", y: "Duration (min)", z: "Wellness Score") { hour, duration in
                    MeditationAnalyticsData.wellnessScore(timeOfDay: hour, duration: duration)
                }
                .foregroundStyle(.normalBased)
            }
            .glassEffect(.regular.tint(.green.opacity(0.2)))
        }
    }
    
    // MARK: - 3D Mood Correlation Chart
    private var moodCorrelation3DChart: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Mood & Time Correlation")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            Text("Relationship between time of day, session length, and mood improvement")
                .font(.caption)
                .foregroundStyle(colors.textSecondary)
            
            Chart3D(filteredAnalytics) { session in
                PointMark(
                    x: .value("Time of Day", session.timeOfDay),
                    y: .value("Duration", session.duration),
                    z: .value("Mood Improvement", session.moodImprovement)
                )
                .foregroundStyle(
                    .linearGradient(
                        colors: [.blue, .purple, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
            .glassEffect()
        }
    }
    
    // MARK: - Insights Summary
    private var insightsSummary: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack {
                Text("Key Insights")
                    .font(.headline)
                    .foregroundStyle(colors.textPrimary)
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                InsightCard(
                    title: "Best Time",
                    value: "8:00 AM",
                    description: "Peak effectiveness",
                    color: colors.accent
                )
                
                InsightCard(
                    title: "Avg Improvement",
                    value: "+2.3",
                    description: "Mood score increase",
                    color: colors.success
                )
                
                InsightCard(
                    title: "Streak",
                    value: "12 days",
                    description: "Current streak",
                    color: colors.warning
                )
                
                InsightCard(
                    title: "Total Time",
                    value: "24h 15m",
                    description: "This month",
                    color: colors.primary
                )
            }
        }
        .padding()
    }
    
    // MARK: - Helper Properties & Methods
    private var filteredAnalytics: [MeditationAnalytics] {
        let cutoffDate = Calendar.current.date(byAdding: timeRange.calendarComponent, value: timeRange.value, to: Date()) ?? Date()
        return MeditationAnalyticsData.sampleSessions.filter { $0.date >= cutoffDate }
    }
    
    private func handleChartTap(at location: CGPoint) {
        // Implementation for 3D chart interaction
        // Find nearest data point and show details
        withAnimation(.spring()) {
            showingDetails = true
        }
    }
}

// MARK: - Supporting Types
@available(iOS 18.0, *)
enum VisualizationType: String, CaseIterable {
    case progressJourney = "progress"
    case categoryPerformance = "categories"
    case wellnessSurface = "surface"
    case moodCorrelation = "correlation"
    
    var displayName: String {
        switch self {
        case .progressJourney: return "Progress"
        case .categoryPerformance: return "Categories"
        case .wellnessSurface: return "Surface"
        case .moodCorrelation: return "Mood"
        }
    }
}

@available(iOS 18.0, *)
enum TimeRange: String, CaseIterable {
    case lastWeek = "week"
    case lastMonth = "month"
    case lastThreeMonths = "quarter"
    case allTime = "all"
    
    var displayName: String {
        switch self {
        case .lastWeek: return "Week"
        case .lastMonth: return "Month"
        case .lastThreeMonths: return "3M"
        case .allTime: return "All"
        }
    }
    
    var calendarComponent: Calendar.Component {
        switch self {
        case .lastWeek: return .day
        case .lastMonth: return .month
        case .lastThreeMonths: return .month
        case .allTime: return .year
        }
    }
    
    var value: Int {
        switch self {
        case .lastWeek: return -7
        case .lastMonth: return -1
        case .lastThreeMonths: return -3
        case .allTime: return -10
        }
    }
}

// MARK: - Insight Card Component
@available(iOS 18.0, *)
struct InsightCard: View {
    let title: String
    let value: String
    let description: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(color)
            
            Text(description)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
                .glassEffect(.regular.tint(color.opacity(0.2)))
        }
    }
}

// MARK: - Detailed Analytics View
@available(iOS 18.0, *)
struct DetailedAnalyticsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: DesignSystem.Spacing.lg) {
                    // Detailed statistics and insights
                    Text("Detailed Analytics")
                        .font(.largeTitle)
                        .padding()
                    
                    // Additional detailed charts and insights
                }
            }
            .navigationTitle("Detailed View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .glassEffect()
        }
    }
}

#Preview {
    MeditationAnalytics3DView()
}