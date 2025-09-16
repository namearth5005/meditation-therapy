import SwiftUI

// MARK: - Privacy Consent Screen - Perfect Blend Design
public struct PrivacyConsentScreen_PerfectBlend: View {
    @Binding var hasAcceptedPrivacy: Bool
    @Binding var allowsNotifications: Bool
    let onComplete: () -> Void
    
    @State private var showPrivacyPolicy = false
    @State private var showTermsOfService = false
    
    private let colors = PerfectBlendColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 20) {
                Text("Privacy & Permissions")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("A few important things to ensure your experience is secure and personalized")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.top, 40)
            .padding(.bottom, 32)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Privacy commitment
                    privacyCommitmentCard
                    
                    // Notification permission
                    notificationPermissionCard
                    
                    // Legal agreements
                    legalAgreementsCard
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 32)
            }
            
            // Complete setup
            VStack(spacing: 16) {
                Divider()
                    .foregroundStyle(colors.border)
                
                Button(action: onComplete) {
                    Text("Complete Setup")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(colors.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colors.primary)
                        }
                }
                .disabled(!hasAcceptedPrivacy)
                .opacity(hasAcceptedPrivacy ? 1.0 : 0.5)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
            .background(colors.background)
        }
        .background(colors.background)
    }
    
    private var privacyCommitmentCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(colors.primary)
                
                Text("Our Privacy Commitment")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
            }
            
            VStack(spacing: 12) {
                privacyPoint(icon: "checkmark.seal", text: "End-to-end encryption for all conversations")
                privacyPoint(icon: "server.rack", text: "Data stored securely with industry standards")
                privacyPoint(icon: "trash", text: "Easy data deletion - remove everything anytime")
                privacyPoint(icon: "eye.slash", text: "Never sold or shared with third parties")
            }
        }
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(colors.surfaceSecondary)
        }
    }
    
    private var notificationPermissionCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "bell")
                    .font(.system(size: 20))
                    .foregroundStyle(colors.primary)
                
                Text("Gentle Reminders")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Spacer()
                
                Toggle("", isOn: $allowsNotifications)
                    .toggleStyle(SwitchToggleStyle(tint: colors.primary))
            }
            
            Text("Optional check-ins and meditation reminders. You can change this anytime in Settings.")
                .font(.system(size: 14))
                .foregroundStyle(colors.textSecondary)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(colors.border, lineWidth: 1)
                }
        }
    }
    
    private var legalAgreementsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "doc.text")
                    .font(.system(size: 20))
                    .foregroundStyle(colors.primary)
                
                Text("Terms & Privacy")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
            }
            
            HStack(alignment: .top, spacing: 12) {
                Button {
                    hasAcceptedPrivacy.toggle()
                } label: {
                    Image(systemName: hasAcceptedPrivacy ? "checkmark.square.fill" : "square")
                        .font(.system(size: 18))
                        .foregroundStyle(hasAcceptedPrivacy ? colors.primary : colors.border)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("I agree to the Terms of Service and Privacy Policy")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(colors.textPrimary)
                    
                    HStack(spacing: 16) {
                        Button("Privacy Policy") {
                            showPrivacyPolicy = true
                        }
                        .font(.system(size: 13))
                        .foregroundStyle(colors.primary)
                        
                        Button("Terms of Service") {
                            showTermsOfService = true
                        }
                        .font(.system(size: 13))
                        .foregroundStyle(colors.primary)
                    }
                }
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(colors.border, lineWidth: 1)
                }
        }
    }
    
    private func privacyPoint(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(colors.primary)
                .frame(width: 16)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundStyle(colors.textSecondary)
        }
    }
}

// MARK: - Privacy Consent Screen - Soft & Supportive Design
public struct PrivacyConsentScreen_SoftSupportive: View {
    @Binding var hasAcceptedPrivacy: Bool
    @Binding var allowsNotifications: Bool
    let onComplete: () -> Void
    
    @State private var showPrivacyPolicy = false
    @State private var showTermsOfService = false
    
    private let colors = SoftSupportiveColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Warm header
            VStack(spacing: 20) {
                Text("Keeping You Safe & Supported")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                    .multilineTextAlignment(.center)
                
                Text("Before we begin your wellness journey, let me share how I'll protect and care for you")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.top, 40)
            .padding(.bottom, 32)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Caring protection promise
                    caringProtectionCard
                    
                    // Gentle reminders
                    gentleRemindersCard
                    
                    // Understanding agreement
                    understandingAgreementCard
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 32)
            }
            
            // Ready to begin
            VStack(spacing: 16) {
                Rectangle()
                    .fill(colors.border)
                    .frame(height: 1)
                
                Button(action: onComplete) {
                    HStack {
                        Text("I'm ready to begin")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(colors.background)
                        
                        Image(systemName: "heart.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(colors.background)
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
                .disabled(!hasAcceptedPrivacy)
                .opacity(hasAcceptedPrivacy ? 1.0 : 0.6)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
            .background(colors.background)
        }
        .background(colors.background)
    }
    
    private var caringProtectionCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "heart.shield.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(colors.primary)
                
                Text("How I'll Protect You")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
            }
            
            VStack(spacing: 16) {
                caringPoint(icon: "lock.heart", text: "Your conversations are encrypted with love and care")
                caringPoint(icon: "shield.lefthalf.filled", text: "I'll never share your personal journey with anyone")
                caringPoint(icon: "hand.raised", text: "You're in control - delete everything whenever you need")
                caringPoint(icon: "eye.trianglebadge.exclamationmark", text: "Crisis detection helps me know when to get you additional support")
            }
        }
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(colors.surfaceSecondary)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(colors.primary.opacity(0.2), lineWidth: 1)
                }
        }
    }
    
    private var gentleRemindersCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "bell.badge")
                    .font(.system(size: 20))
                    .foregroundStyle(colors.primary)
                
                Text("Gentle Care Reminders")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Spacer()
                
                Toggle("", isOn: $allowsNotifications)
                    .toggleStyle(SwitchToggleStyle(tint: colors.primary))
            }
            
            Text("I can send you loving reminders to check in with yourself or take a mindful moment. Only if you'd like - your peace comes first.")
                .font(.system(size: 14))
                .foregroundStyle(colors.textSecondary)
                .italic()
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(colors.primary.opacity(0.03))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(colors.primary.opacity(0.1), lineWidth: 1)
                }
        }
    }
    
    private var understandingAgreementCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "doc.heart")
                    .font(.system(size: 20))
                    .foregroundStyle(colors.primary)
                
                Text("Our Understanding")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
            }
            
            HStack(alignment: .top, spacing: 16) {
                Button {
                    hasAcceptedPrivacy.toggle()
                } label: {
                    Image(systemName: hasAcceptedPrivacy ? "heart.circle.fill" : "heart.circle")
                        .font(.system(size: 22))
                        .foregroundStyle(hasAcceptedPrivacy ? colors.primary : colors.border)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("I understand how MindfulTherapy works and I'm comfortable with our privacy practices")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(colors.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 20) {
                        Button("Privacy Details") {
                            showPrivacyPolicy = true
                        }
                        .font(.system(size: 13))
                        .foregroundStyle(colors.primary)
                        
                        Button("Terms") {
                            showTermsOfService = true
                        }
                        .font(.system(size: 13))
                        .foregroundStyle(colors.primary)
                    }
                }
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(colors.primary.opacity(0.2), lineWidth: 1)
                }
        }
    }
    
    private func caringPoint(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(colors.primary)
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundStyle(colors.textSecondary)
                .multilineTextAlignment(.leading)
        }
    }
}

// MARK: - Privacy Consent Screen - Clean & Focused Design
public struct PrivacyConsentScreen_CleanFocused: View {
    @Binding var hasAcceptedPrivacy: Bool
    @Binding var allowsNotifications: Bool
    let onComplete: () -> Void
    
    @State private var showPrivacyPolicy = false
    @State private var showTermsOfService = false
    
    private let colors = CleanFocusedColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Simple header
            VStack(spacing: 16) {
                Text("Privacy & Terms")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("Final setup requirements")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 40)
            
            ScrollView {
                VStack(spacing: 32) {
                    // Privacy essentials
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Privacy")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        VStack(spacing: 8) {
                            simplePrivacyPoint("Data encrypted")
                            simplePrivacyPoint("No third-party sharing")
                            simplePrivacyPoint("Delete anytime")
                        }
                    }
                    
                    // Notifications toggle
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Notifications")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(colors.textPrimary)
                            
                            Text("Reminders and check-ins")
                                .font(.system(size: 14))
                                .foregroundStyle(colors.textSecondary)
                        }
                        
                        Spacer()
                        
                        Toggle("", isOn: $allowsNotifications)
                            .toggleStyle(SwitchToggleStyle(tint: colors.primary))
                    }
                    
                    // Agreement
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            Button {
                                hasAcceptedPrivacy.toggle()
                            } label: {
                                Image(systemName: hasAcceptedPrivacy ? "checkmark.square.fill" : "square")
                                    .font(.system(size: 18))
                                    .foregroundStyle(hasAcceptedPrivacy ? colors.primary : colors.border)
                            }
                            
                            Text("I agree to the terms")
                                .font(.system(size: 16))
                                .foregroundStyle(colors.textPrimary)
                        }
                        
                        HStack(spacing: 16) {
                            Button("Privacy Policy") {
                                showPrivacyPolicy = true
                            }
                            .font(.system(size: 14))
                            .foregroundStyle(colors.primary)
                            
                            Button("Terms of Service") {
                                showTermsOfService = true
                            }
                            .font(.system(size: 14))
                            .foregroundStyle(colors.primary)
                        }
                        .padding(.leading, 30)
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer(minLength: 80)
            }
            
            // Simple complete
            Button(action: onComplete) {
                Text("Complete Setup")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(colors.background)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(colors.primary)
                    }
            }
            .disabled(!hasAcceptedPrivacy)
            .opacity(hasAcceptedPrivacy ? 1.0 : 0.5)
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .background(colors.background)
    }
    
    private func simplePrivacyPoint(_ text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark")
                .font(.system(size: 12))
                .foregroundStyle(colors.primary)
                .frame(width: 16)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundStyle(colors.textSecondary)
        }
    }
}

#Preview("Perfect Blend Privacy") {
    PrivacyConsentScreen_PerfectBlend(
        hasAcceptedPrivacy: .constant(false),
        allowsNotifications: .constant(true),
        onComplete: {}
    )
}

#Preview("Soft Supportive Privacy") {
    PrivacyConsentScreen_SoftSupportive(
        hasAcceptedPrivacy: .constant(false),
        allowsNotifications: .constant(true),
        onComplete: {}
    )
}

#Preview("Clean Focused Privacy") {
    PrivacyConsentScreen_CleanFocused(
        hasAcceptedPrivacy: .constant(false),
        allowsNotifications: .constant(true),
        onComplete: {}
    )
}