import SwiftUI
import Foundation

// MARK: - 3D Analytics Data Models
// Supporting Chart3D visualizations for meditation insights

@available(iOS 18.0, *)
public struct MeditationAnalytics: Identifiable, Sendable {
    public let id = UUID()
    public let date: Date
    public let duration: Double // minutes
    public let category: MeditationCategory
    public let moodBefore: Double // 1-10 scale
    public let moodAfter: Double // 1-10 scale
    public let focusLevel: Double // 1-10 scale
    public let relaxationLevel: Double // 1-10 scale
    public let stressReduction: Double // calculated improvement
    public let timeOfDay: Double // hour of day (0-24)
    public let dayOfWeek: Int // 1-7
    public let weatherMood: Double // external factor influence
    
    public var moodImprovement: Double {
        moodAfter - moodBefore
    }
    
    public var effectiveness: Double {
        (moodImprovement + (relaxationLevel / 2) + (focusLevel / 2)) / 3
    }
    
    public var daysSinceStart: Double {
        Date().timeIntervalSince(MeditationAnalytics.journeyStartDate) / (24 * 60 * 60)
    }
    
    public init(
        date: Date,
        duration: Double,
        category: MeditationCategory,
        moodBefore: Double,
        moodAfter: Double,
        focusLevel: Double,
        relaxationLevel: Double,
        stressReduction: Double,
        timeOfDay: Double,
        dayOfWeek: Int,
        weatherMood: Double = 5.0
    ) {
        self.date = date
        self.duration = duration
        self.category = category
        self.moodBefore = moodBefore
        self.moodAfter = moodAfter
        self.focusLevel = focusLevel
        self.relaxationLevel = relaxationLevel
        self.stressReduction = stressReduction
        self.timeOfDay = timeOfDay
        self.dayOfWeek = dayOfWeek
        self.weatherMood = weatherMood
    }
    
    static let journeyStartDate = Calendar.current.date(byAdding: .day, value: -90, to: Date()) ?? Date()
}

@available(iOS 18.0, *)
public struct WellnessMetrics: Identifiable, Sendable {
    public let id = UUID()
    public let week: Int
    public let averageMoodImprovement: Double
    public let totalMeditationTime: Double
    public let consistencyScore: Double // 1-10
    public let preferredCategories: [MeditationCategory]
    public let stressReductionTrend: Double
    public let sleepQuality: Double // 1-10
    public let energyLevel: Double // 1-10
    
    public init(
        week: Int,
        averageMoodImprovement: Double,
        totalMeditationTime: Double,
        consistencyScore: Double,
        preferredCategories: [MeditationCategory],
        stressReductionTrend: Double,
        sleepQuality: Double,
        energyLevel: Double
    ) {
        self.week = week
        self.averageMoodImprovement = averageMoodImprovement
        self.totalMeditationTime = totalMeditationTime
        self.consistencyScore = consistencyScore
        self.preferredCategories = preferredCategories
        self.stressReductionTrend = stressReductionTrend
        self.sleepQuality = sleepQuality
        self.energyLevel = energyLevel
    }
}

@available(iOS 18.0, *)
public struct CategoryPerformance: Identifiable, Sendable {
    public let id = UUID()
    public let category: MeditationCategory
    public let averageEffectiveness: Double
    public let totalSessions: Int
    public let averageDuration: Double
    public let moodImprovementScore: Double
    public let userPreferenceRating: Double // 1-10
    public let optimalTimeOfDay: Double // hour when most effective
    
    public var size: Double {
        min(max(Double(totalSessions) / 10.0, 0.5), 3.0) // Size for 3D visualization
    }
    
    public init(
        category: MeditationCategory,
        averageEffectiveness: Double,
        totalSessions: Int,
        averageDuration: Double,
        moodImprovementScore: Double,
        userPreferenceRating: Double,
        optimalTimeOfDay: Double
    ) {
        self.category = category
        self.averageEffectiveness = averageEffectiveness
        self.totalSessions = totalSessions
        self.averageDuration = averageDuration
        self.moodImprovementScore = moodImprovementScore
        self.userPreferenceRating = userPreferenceRating
        self.optimalTimeOfDay = optimalTimeOfDay
    }
}

// MARK: - Sample Analytics Data
@available(iOS 18.0, *)
public struct MeditationAnalyticsData {
    
    public static let sampleSessions: [MeditationAnalytics] = {
        var sessions: [MeditationAnalytics] = []
        let calendar = Calendar.current
        let startDate = MeditationAnalytics.journeyStartDate
        
        for day in 0..<90 {
            let date = calendar.date(byAdding: .day, value: day, to: startDate) ?? startDate
            let dayOfWeek = calendar.component(.weekday, from: date)
            
            // Simulate 0-2 sessions per day with realistic patterns
            let sessionsToday = Int.random(in: 0...2)
            
            for sessionIndex in 0..<sessionsToday {
                let category = MeditationCategory.allCases.randomElement() ?? .anxiety
                let timeOfDay = sessionIndex == 0 ? Double.random(in: 7...9) : Double.random(in: 18...21)
                let duration = Double.random(in: 5...30)
                
                let moodBefore = Double.random(in: 3...7)
                let baseImprovement = Double.random(in: 0.5...3.0)
                let moodAfter = min(10, moodBefore + baseImprovement)
                
                sessions.append(MeditationAnalytics(
                    date: date,
                    duration: duration,
                    category: category,
                    moodBefore: moodBefore,
                    moodAfter: moodAfter,
                    focusLevel: Double.random(in: 4...9),
                    relaxationLevel: Double.random(in: 5...10),
                    stressReduction: Double.random(in: 1...8),
                    timeOfDay: timeOfDay,
                    dayOfWeek: dayOfWeek,
                    weatherMood: Double.random(in: 4...8)
                ))
            }
        }
        
        return sessions.sorted { $0.date < $1.date }
    }()
    
    public static let weeklyMetrics: [WellnessMetrics] = {
        var metrics: [WellnessMetrics] = []
        
        for week in 1...12 {
            let weekSessions = sampleSessions.filter { session in
                let weekOfYear = Calendar.current.component(.weekOfYear, from: session.date)
                return weekOfYear == week + Calendar.current.component(.weekOfYear, from: MeditationAnalytics.journeyStartDate)
            }
            
            let avgMoodImprovement = weekSessions.isEmpty ? 0 : 
                weekSessions.map(\.moodImprovement).reduce(0, +) / Double(weekSessions.count)
            
            let totalTime = weekSessions.map(\.duration).reduce(0, +)
            let consistency = min(10, Double(weekSessions.count) * 1.5)
            
            metrics.append(WellnessMetrics(
                week: week,
                averageMoodImprovement: avgMoodImprovement,
                totalMeditationTime: totalTime,
                consistencyScore: consistency,
                preferredCategories: [.beginners, .anxiety, .sleep],
                stressReductionTrend: Double.random(in: 5...9),
                sleepQuality: Double.random(in: 6...9),
                energyLevel: Double.random(in: 6...9)
            ))
        }
        
        return metrics
    }()
    
    public static let categoryPerformance: [CategoryPerformance] = {
        MeditationCategory.allCases.map { category in
            let categorySessions = sampleSessions.filter { $0.category == category }
            
            return CategoryPerformance(
                category: category,
                averageEffectiveness: categorySessions.isEmpty ? 5.0 :
                    categorySessions.map(\.effectiveness).reduce(0, +) / Double(categorySessions.count),
                totalSessions: categorySessions.count,
                averageDuration: categorySessions.isEmpty ? 10.0 :
                    categorySessions.map(\.duration).reduce(0, +) / Double(categorySessions.count),
                moodImprovementScore: categorySessions.isEmpty ? 2.0 :
                    categorySessions.map(\.moodImprovement).reduce(0, +) / Double(categorySessions.count),
                userPreferenceRating: Double.random(in: 6...10),
                optimalTimeOfDay: Double.random(in: 7...20)
            )
        }
    }()
    
    // Mathematical function for wellness surface plot
    public static func wellnessScore(timeOfDay: Double, duration: Double) -> Double {
        // Simulate optimal meditation times and durations
        let timeOptimality = 1.0 - abs(timeOfDay - 8.0) / 12.0 // Morning peak
        let durationOptimality = min(duration / 20.0, 1.0) // Optimal around 20 minutes
        let interaction = sin(timeOfDay / 24.0 * 2 * .pi) * cos(duration / 30.0 * .pi)
        
        return max(0, min(10, (timeOptimality + durationOptimality + interaction) * 3.5))
    }
}

// MARK: - Extensions for MeditationCategory
extension MeditationCategory {
    public var focusIntensity: Double {
        switch self {
        case .meditation: return 8.5
        case .focus: return 9.0
        case .beginners: return 7.0
        case .anxiety: return 6.0
        case .stress: return 5.0
        case .energy: return 8.0
        case .sleep: return 3.0
        case .selfLove: return 4.0
        case .advanced: return 9.5
        }
    }
    
    public var relaxationIntensity: Double {
        switch self {
        case .meditation: return 8.0
        case .sleep: return 9.5
        case .anxiety: return 8.0
        case .stress: return 8.5
        case .selfLove: return 7.5
        case .beginners: return 7.0
        case .energy: return 4.0
        case .focus: return 5.0
        case .advanced: return 8.0
        }
    }
}