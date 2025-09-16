import SwiftUI

// MARK: - Onboarding Coordinator
// Manages the onboarding flow across all design iterations

public struct OnboardingCoordinator: View {
    @State private var selectedDesign = 0
    @State private var currentStep: OnboardingStep = .welcome
    @State private var isOnboardingComplete = false
    
    // Onboarding data
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var emotionalAssessment: [Int] = []
    @State private var memoryPreference: MemoryPreference = .thirtyDays
    @State private var hasAcceptedPrivacy = false
    @State private var allowsNotifications = false
    
    private let designOptions = [
        "Perfect Blend",
        "Soft & Supportive", 
        "Clean & Focused"
    ]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !isOnboardingComplete {
                    // Design selector (for testing)
                    designSelector
                        .background(Color.white)
                    
                    // Current onboarding step
                    currentOnboardingView
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                } else {
                    // Onboarding complete - show main app
                    Text("Onboarding Complete!")
                        .font(.title)
                        .foregroundStyle(.primary)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: currentStep)
            .animation(.easeInOut(duration: 0.3), value: selectedDesign)
        }
    }
    
    private var designSelector: some View {
        VStack(spacing: 12) {
            Text("Choose Onboarding Design")
                .font(.headline)
                .foregroundStyle(.primary)
            
            HStack(spacing: 8) {
                ForEach(0..<designOptions.count, id: \.self) { index in
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedDesign = index
                        }
                    } label: {
                        Text(designOptions[index])
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(
                                selectedDesign == index 
                                ? .white 
                                : .primary
                            )
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(
                                        selectedDesign == index 
                                        ? Color.black
                                        : Color.gray.opacity(0.1)
                                    )
                            }
                    }
                }
            }
        }
        .padding()
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
    
    @ViewBuilder
    private var currentOnboardingView: some View {
        switch selectedDesign {
        case 0:
            perfectBlendOnboardingView
        case 1:
            softSupportiveOnboardingView
        case 2:
            cleanFocusedOnboardingView
        default:
            perfectBlendOnboardingView
        }
    }
    
    // MARK: - Perfect Blend Onboarding Flow
    @ViewBuilder
    private var perfectBlendOnboardingView: some View {
        switch currentStep {
        case .welcome:
            WelcomeScreen_PerfectBlend(
                onContinue: { moveToStep(.authentication) }
            )
        case .authentication:
            AuthenticationScreen_PerfectBlend(
                email: $userEmail,
                password: $userPassword,
                onSignUp: { moveToStep(.emotionalAssessment) },
                onSignIn: { moveToStep(.emotionalAssessment) }
            )
        case .emotionalAssessment:
            EmotionalAssessmentScreen_PerfectBlend(
                responses: $emotionalAssessment,
                onComplete: { moveToStep(.memoryPreference) }
            )
        case .memoryPreference:
            MemoryPreferenceScreen_PerfectBlend(
                selection: $memoryPreference,
                onContinue: { moveToStep(.privacyConsent) }
            )
        case .privacyConsent:
            PrivacyConsentScreen_PerfectBlend(
                hasAcceptedPrivacy: $hasAcceptedPrivacy,
                allowsNotifications: $allowsNotifications,
                onComplete: { completeOnboarding() }
            )
        }
    }
    
    // MARK: - Soft & Supportive Onboarding Flow
    @ViewBuilder
    private var softSupportiveOnboardingView: some View {
        switch currentStep {
        case .welcome:
            WelcomeScreen_SoftSupportive(
                onContinue: { moveToStep(.authentication) }
            )
        case .authentication:
            AuthenticationScreen_SoftSupportive(
                email: $userEmail,
                password: $userPassword,
                onSignUp: { moveToStep(.emotionalAssessment) },
                onSignIn: { moveToStep(.emotionalAssessment) }
            )
        case .emotionalAssessment:
            EmotionalAssessmentScreen_SoftSupportive(
                responses: $emotionalAssessment,
                onComplete: { moveToStep(.memoryPreference) }
            )
        case .memoryPreference:
            MemoryPreferenceScreen_SoftSupportive(
                selection: $memoryPreference,
                onContinue: { moveToStep(.privacyConsent) }
            )
        case .privacyConsent:
            PrivacyConsentScreen_SoftSupportive(
                hasAcceptedPrivacy: $hasAcceptedPrivacy,
                allowsNotifications: $allowsNotifications,
                onComplete: { completeOnboarding() }
            )
        }
    }
    
    // MARK: - Clean & Focused Onboarding Flow
    @ViewBuilder
    private var cleanFocusedOnboardingView: some View {
        switch currentStep {
        case .welcome:
            WelcomeScreen_CleanFocused(
                onContinue: { moveToStep(.authentication) }
            )
        case .authentication:
            AuthenticationScreen_CleanFocused(
                email: $userEmail,
                password: $userPassword,
                onSignUp: { moveToStep(.emotionalAssessment) },
                onSignIn: { moveToStep(.emotionalAssessment) }
            )
        case .emotionalAssessment:
            EmotionalAssessmentScreen_CleanFocused(
                responses: $emotionalAssessment,
                onComplete: { moveToStep(.memoryPreference) }
            )
        case .memoryPreference:
            MemoryPreferenceScreen_CleanFocused(
                selection: $memoryPreference,
                onContinue: { moveToStep(.privacyConsent) }
            )
        case .privacyConsent:
            PrivacyConsentScreen_CleanFocused(
                hasAcceptedPrivacy: $hasAcceptedPrivacy,
                allowsNotifications: $allowsNotifications,
                onComplete: { completeOnboarding() }
            )
        }
    }
    
    // MARK: - Navigation Functions
    private func moveToStep(_ step: OnboardingStep) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = step
        }
    }
    
    private func completeOnboarding() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isOnboardingComplete = true
        }
    }
}

// MARK: - Onboarding Models
public enum OnboardingStep: CaseIterable {
    case welcome
    case authentication
    case emotionalAssessment
    case memoryPreference
    case privacyConsent
}

public enum MemoryPreference: String, CaseIterable {
    case sessionOnly = "session_only"
    case sevenDays = "7_days"
    case thirtyDays = "30_days"
    
    var displayName: String {
        switch self {
        case .sessionOnly: return "Session Only"
        case .sevenDays: return "7 Days"
        case .thirtyDays: return "30 Days"
        }
    }
    
    var description: String {
        switch self {
        case .sessionOnly: return "Data is cleared after each session"
        case .sevenDays: return "Data is kept for 7 days"
        case .thirtyDays: return "Data is kept for 30 days"
        }
    }
}

#Preview {
    OnboardingCoordinator()
}