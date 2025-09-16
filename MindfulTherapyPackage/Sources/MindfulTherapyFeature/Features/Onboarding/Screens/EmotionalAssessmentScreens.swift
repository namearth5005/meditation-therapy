import SwiftUI

// MARK: - Emotional Assessment Screen - Perfect Blend Design
public struct EmotionalAssessmentScreen_PerfectBlend: View {
    @Binding var responses: [Int]
    let onComplete: () -> Void
    
    @State private var currentQuestion = 0
    @State private var showProgress = false
    
    private let colors = PerfectBlendColors()
    private let questions = AssessmentQuestions.questions
    
    public init(responses: Binding<[Int]>, onComplete: @escaping () -> Void) {
        self._responses = responses
        self.onComplete = onComplete
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Progress indicator
            VStack(spacing: 16) {
                HStack {
                    Text("Question \(currentQuestion + 1) of \(questions.count)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(colors.textSecondary)
                    
                    Spacer()
                    
                    Button("Skip") {
                        // Skip to next or complete
                        nextQuestion()
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textTertiary)
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(colors.border)
                            .frame(height: 4)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(colors.primary)
                            .frame(
                                width: geometry.size.width * CGFloat(currentQuestion + 1) / CGFloat(questions.count),
                                height: 4
                            )
                            .animation(.easeInOut(duration: 0.3), value: currentQuestion)
                    }
                }
                .frame(height: 4)
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            .padding(.bottom, 32)
            
            ScrollView {
                VStack(spacing: 40) {
                    // Question
                    VStack(spacing: 16) {
                        Text(questions[currentQuestion].question)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                            .multilineTextAlignment(.center)
                        
                        if let subtitle = questions[currentQuestion].subtitle {
                            Text(subtitle)
                                .font(.system(size: 16))
                                .foregroundStyle(colors.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.horizontal, 32)
                    
                    // Answer options
                    VStack(spacing: 12) {
                        ForEach(0..<5, id: \.self) { rating in
                            answerOption(
                                rating: rating + 1,
                                label: ratingLabel(rating + 1, for: currentQuestion),
                                isSelected: responses.count > currentQuestion && responses[currentQuestion] == rating + 1
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer(minLength: 100)
                }
            }
            
            // Bottom navigation
            if responses.count > currentQuestion && responses[currentQuestion] > 0 {
                VStack(spacing: 16) {
                    Divider()
                        .foregroundStyle(colors.border)
                    
                    Button(action: nextQuestion) {
                        Text(currentQuestion == questions.count - 1 ? "Complete Assessment" : "Next Question")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(colors.background)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(colors.primary)
                            }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }
                .background(colors.background)
            }
        }
        .background(colors.background)
        .onAppear {
            if responses.count < questions.count {
                responses = Array(repeating: 0, count: questions.count)
            }
        }
    }
    
    private func answerOption(rating: Int, label: String, isSelected: Bool) -> some View {
        Button {
            responses[currentQuestion] = rating
        } label: {
            HStack(spacing: 16) {
                // Sophisticated rating indicator
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(isSelected ? colors.primary : colors.surfaceSecondary)
                            .frame(width: 32, height: 32)
                            .overlay {
                                Circle()
                                    .stroke(isSelected ? colors.primary : colors.border, lineWidth: 1)
                            }
                        
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(colors.background)
                        }
                    }
                    
                    // Enhanced label with contextual icon
                    HStack(spacing: 8) {
                        Image(systemName: iconForRating(rating, question: currentQuestion))
                            .font(.system(size: 16))
                            .foregroundStyle(isSelected ? colors.primary : colors.textTertiary)
                        
                        Text(label)
                            .font(.system(size: 16, weight: isSelected ? .medium : .regular))
                            .foregroundStyle(isSelected ? colors.textPrimary : colors.textSecondary)
                    }
                }
                
                Spacer()
                
                // Elegant selection indicator
                ZStack {
                    Circle()
                        .fill(isSelected ? colors.primary : Color.clear)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Circle()
                                .stroke(isSelected ? colors.primary : colors.border, lineWidth: 1.5)
                        }
                    
                    if isSelected {
                        Circle()
                            .fill(colors.background)
                            .frame(width: 6, height: 6)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? colors.primary.opacity(0.04) : colors.surfaceSecondary)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? colors.primary.opacity(0.2) : colors.border, lineWidth: 1)
                    }
            }
        }
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.easeOut(duration: 0.15), value: isSelected)
    }
    
    private func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentQuestion += 1
            }
        } else {
            onComplete()
        }
    }
    
    private func ratingLabel(_ rating: Int, for questionIndex: Int) -> String {
        switch questionIndex {
        case 0: // Anxiety/stress levels
            return ["Very Low", "Low", "Moderate", "High", "Very High"][rating - 1]
        case 1: // Sleep quality
            return ["Very Poor", "Poor", "Fair", "Good", "Excellent"][rating - 1]
        case 2: // Mood
            return ["Very Sad", "Sad", "Neutral", "Happy", "Very Happy"][rating - 1]
        case 3: // Energy levels
            return ["Exhausted", "Tired", "Neutral", "Energetic", "Very Energetic"][rating - 1]
        case 4: // Life satisfaction
            return ["Very Unsatisfied", "Unsatisfied", "Neutral", "Satisfied", "Very Satisfied"][rating - 1]
        default:
            return ["1", "2", "3", "4", "5"][rating - 1]
        }
    }
    
    private func iconForRating(_ rating: Int, question: Int) -> String {
        switch question {
        case 0: // Anxiety/stress levels - calm to stressed icons
            return ["leaf.fill", "leaf", "exclamationmark.triangle", "exclamationmark.triangle.fill", "bolt.fill"][rating - 1]
        case 1: // Sleep quality - poor to excellent sleep icons
            return ["moon.zzz", "moon.circle", "bed.double", "bed.double.fill", "sparkles"][rating - 1]
        case 2: // Mood - sad to happy emotional icons
            return ["cloud.rain.fill", "cloud.fill", "minus.circle", "sun.min", "sun.max.fill"][rating - 1]
        case 3: // Energy levels - tired to energetic icons
            return ["battery.0", "battery.25", "battery.50", "battery.75", "battery.100"][rating - 1]
        case 4: // Life satisfaction - unsatisfied to very satisfied
            return ["heart.slash", "heart", "heart.circle", "heart.circle.fill", "star.fill"][rating - 1]
        default:
            return "circle.fill"
        }
    }
}

// MARK: - Emotional Assessment Screen - Soft & Supportive Design
public struct EmotionalAssessmentScreen_SoftSupportive: View {
    @Binding var responses: [Int]
    let onComplete: () -> Void
    
    @State private var currentQuestion = 0
    
    private let colors = SoftSupportiveColors()
    private let questions = AssessmentQuestions.questions
    
    public init(responses: Binding<[Int]>, onComplete: @escaping () -> Void) {
        self._responses = responses
        self.onComplete = onComplete
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Warm progress section
            VStack(spacing: 20) {
                Text("Getting to Know You")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("Question \(currentQuestion + 1) of \(questions.count)")
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textSecondary)
                
                // Gentle progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(colors.surfaceSecondary)
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(
                                colors: [colors.primary, colors.accent],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(
                                width: geometry.size.width * CGFloat(currentQuestion + 1) / CGFloat(questions.count),
                                height: 8
                            )
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: currentQuestion)
                    }
                }
                .frame(height: 8)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 24)
            
            ScrollView {
                VStack(spacing: 40) {
                    // Gentle question presentation
                    VStack(spacing: 20) {
                        Text(questions[currentQuestion].question)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                        
                        if let subtitle = questions[currentQuestion].subtitle {
                            Text(subtitle)
                                .font(.system(size: 16))
                                .foregroundStyle(colors.textSecondary)
                                .multilineTextAlignment(.center)
                                .italic()
                        }
                        
                        Text("Take your time, there's no right or wrong answer")
                            .font(.system(size: 14))
                            .foregroundStyle(colors.textTertiary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 32)
                    
                    // Warm answer options
                    VStack(spacing: 16) {
                        ForEach(0..<5, id: \.self) { rating in
                            gentleAnswerOption(
                                rating: rating + 1,
                                label: ratingLabel(rating + 1, for: currentQuestion),
                                isSelected: responses.count > currentQuestion && responses[currentQuestion] == rating + 1
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer(minLength: 120)
                }
            }
            
            // Supportive navigation
            if responses.count > currentQuestion && responses[currentQuestion] > 0 {
                VStack(spacing: 16) {
                    Rectangle()
                        .fill(colors.border)
                        .frame(height: 1)
                    
                    Button(action: nextQuestion) {
                        HStack {
                            Text(currentQuestion == questions.count - 1 ? "Complete My Assessment" : "Next Question")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(colors.background)
                            
                            if currentQuestion < questions.count - 1 {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14))
                                    .foregroundStyle(colors.background)
                            } else {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(colors.background)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(
                                    colors: [colors.primary, colors.accent],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }
                .background(colors.background)
            }
        }
        .background(colors.background)
        .onAppear {
            if responses.count < questions.count {
                responses = Array(repeating: 0, count: questions.count)
            }
        }
    }
    
    private func gentleAnswerOption(rating: Int, label: String, isSelected: Bool) -> some View {
        Button {
            responses[currentQuestion] = rating
        } label: {
            HStack {
                HStack(spacing: 16) {
                    // Gentle rating indicator
                    ZStack {
                        Circle()
                            .fill(isSelected ? colors.primary : colors.surfaceSecondary)
                            .frame(width: 36, height: 36)
                        
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(colors.background)
                        } else {
                            Text("\(rating)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(colors.textSecondary)
                        }
                    }
                    
                    // Supportive label
                    Text(label)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(colors.textPrimary)
                }
                
                Spacer()
                
                // Heart selection indicator
                Image(systemName: isSelected ? "heart.fill" : "heart")
                    .font(.system(size: 18))
                    .foregroundStyle(isSelected ? colors.primary : colors.border)
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? colors.primary.opacity(0.08) : colors.surfaceSecondary)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? colors.primary.opacity(0.3) : Color.clear, lineWidth: 2)
                    }
            }
        }
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
    
    private func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                currentQuestion += 1
            }
        } else {
            onComplete()
        }
    }
    
    private func ratingLabel(_ rating: Int, for questionIndex: Int) -> String {
        switch questionIndex {
        case 0: // Anxiety/stress levels
            return ["Rarely stressed", "Sometimes tense", "Moderately anxious", "Often worried", "Constantly overwhelmed"][rating - 1]
        case 1: // Sleep quality
            return ["Very restless", "Poor sleep", "Some difficulties", "Sleep well", "Deep, peaceful rest"][rating - 1]
        case 2: // Mood
            return ["Feeling down", "Low spirits", "Balanced", "Positive mood", "Joyful & content"][rating - 1]
        case 3: // Energy levels
            return ["Very drained", "Low energy", "Steady", "Energized", "Vibrant & alive"][rating - 1]
        case 4: // Life satisfaction
            return ["Struggling", "Challenges", "Getting by", "Content", "Thriving"][rating - 1]
        default:
            return ["1", "2", "3", "4", "5"][rating - 1]
        }
    }
}

// MARK: - Emotional Assessment Screen - Clean & Focused Design
public struct EmotionalAssessmentScreen_CleanFocused: View {
    @Binding var responses: [Int]
    let onComplete: () -> Void
    
    @State private var currentQuestion = 0
    
    private let colors = CleanFocusedColors()
    private let questions = AssessmentQuestions.questions
    
    public init(responses: Binding<[Int]>, onComplete: @escaping () -> Void) {
        self._responses = responses
        self.onComplete = onComplete
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Minimal header
            VStack(spacing: 16) {
                Text("Assessment")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("\(currentQuestion + 1) / \(questions.count)")
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textSecondary)
                
                // Clean progress
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(colors.border)
                            .frame(height: 2)
                        
                        Rectangle()
                            .fill(colors.primary)
                            .frame(
                                width: geometry.size.width * CGFloat(currentQuestion + 1) / CGFloat(questions.count),
                                height: 2
                            )
                            .animation(.easeInOut(duration: 0.2), value: currentQuestion)
                    }
                }
                .frame(height: 2)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 24)
            
            Spacer()
            
            // Question
            VStack(spacing: 24) {
                Text(questions[currentQuestion].question)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                    .multilineTextAlignment(.center)
                
                if let subtitle = questions[currentQuestion].subtitle {
                    Text(subtitle)
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textSecondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            // Simple rating scale
            VStack(spacing: 20) {
                HStack {
                    Text("1")
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textTertiary)
                    
                    Spacer()
                    
                    Text("5")
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textTertiary)
                }
                .padding(.horizontal, 32)
                
                HStack(spacing: 16) {
                    ForEach(1...5, id: \.self) { rating in
                        Button {
                            responses[currentQuestion] = rating
                        } label: {
                            Circle()
                                .fill(responses.count > currentQuestion && responses[currentQuestion] == rating ? colors.primary : Color.clear)
                                .overlay {
                                    Circle()
                                        .stroke(colors.primary, lineWidth: 2)
                                }
                                .frame(width: 44, height: 44)
                                .overlay {
                                    if responses.count > currentQuestion && responses[currentQuestion] == rating {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(colors.background)
                                    } else {
                                        Text("\(rating)")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundStyle(colors.primary)
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal, 32)
            }
            
            Spacer()
            
            // Simple navigation
            if responses.count > currentQuestion && responses[currentQuestion] > 0 {
                Button(action: nextQuestion) {
                    Text(currentQuestion == questions.count - 1 ? "Complete" : "Next")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(colors.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colors.primary)
                        }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
        .background(colors.background)
        .onAppear {
            if responses.count < questions.count {
                responses = Array(repeating: 0, count: questions.count)
            }
        }
    }
    
    private func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            withAnimation(.easeInOut(duration: 0.2)) {
                currentQuestion += 1
            }
        } else {
            onComplete()
        }
    }
}

// MARK: - Assessment Questions
struct AssessmentQuestions {
    static let questions = [
        AssessmentQuestion(
            question: "How often does stress control your life?",
            subtitle: "Be honest - this determines your personalized breakthrough plan"
        ),
        AssessmentQuestion(
            question: "How would you rate your sleep quality?",
            subtitle: "Poor sleep destroys mental health - let's fix this first"
        ),
        AssessmentQuestion(
            question: "How has your mood been affecting your relationships?",
            subtitle: "Your loved ones notice more than you think"
        ),
        AssessmentQuestion(
            question: "Are low energy levels holding you back from your goals?",
            subtitle: "Imagine having unstoppable daily energy"
        ),
        AssessmentQuestion(
            question: "How satisfied are you with your life currently?",
            subtitle: "This is where your transformation journey begins"
        )
    ]
}

struct AssessmentQuestion {
    let question: String
    let subtitle: String?
}

#Preview("Perfect Blend Assessment") {
    EmotionalAssessmentScreen_PerfectBlend(
        responses: .constant([]),
        onComplete: {}
    )
}

#Preview("Soft Supportive Assessment") {
    EmotionalAssessmentScreen_SoftSupportive(
        responses: .constant([]),
        onComplete: {}
    )
}

#Preview("Clean Focused Assessment") {
    EmotionalAssessmentScreen_CleanFocused(
        responses: .constant([]),
        onComplete: {}
    )
}