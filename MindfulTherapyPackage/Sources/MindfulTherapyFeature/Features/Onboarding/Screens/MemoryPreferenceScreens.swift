import SwiftUI

// MARK: - Memory Preference Screen - Perfect Blend Design
public struct MemoryPreferenceScreen_PerfectBlend: View {
    @Binding var selection: MemoryPreference
    let onContinue: () -> Void
    
    private let colors = PerfectBlendColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 20) {
                Text("Data Preference")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("Choose how long we should remember your conversations and progress")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.top, 40)
            .padding(.bottom, 40)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(MemoryPreference.allCases, id: \.self) { preference in
                        memoryOptionCard(preference: preference)
                    }
                }
                .padding(.horizontal, 32)
                
                // Privacy explanation
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "lock.shield")
                            .font(.system(size: 18))
                            .foregroundStyle(colors.primary)
                        
                        Text("Privacy First")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        Spacer()
                    }
                    
                    Text("Your data is encrypted and stored securely. You can change this setting or delete all data at any time in Settings.")
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textSecondary)
                        .multilineTextAlignment(.leading)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colors.surfaceSecondary)
                }
                .padding(.horizontal, 32)
                .padding(.top, 32)
                
                Spacer(minLength: 100)
            }
            
            // Continue button
            VStack(spacing: 16) {
                Divider()
                    .foregroundStyle(colors.border)
                
                Button(action: onContinue) {
                    Text("Continue")
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
        .background(colors.background)
    }
    
    private func memoryOptionCard(preference: MemoryPreference) -> some View {
        Button {
            selection = preference
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(preference.displayName)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        Text(preference.description)
                            .font(.system(size: 14))
                            .foregroundStyle(colors.textSecondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: selection == preference ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 20))
                        .foregroundStyle(selection == preference ? colors.primary : colors.border)
                }
                
                // Additional details
                VStack(alignment: .leading, spacing: 8) {
                    detailRow(icon: "shield.checkered", text: additionalDetail(for: preference))
                    detailRow(icon: "arrow.clockwise", text: "Can be changed anytime")
                }
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(selection == preference ? colors.primary.opacity(0.05) : Color.clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selection == preference ? colors.primary : colors.border, lineWidth: 1)
                    }
            }
        }
    }
    
    private func detailRow(icon: String, text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundStyle(colors.textTertiary)
                .frame(width: 16)
            
            Text(text)
                .font(.system(size: 12))
                .foregroundStyle(colors.textTertiary)
        }
    }
    
    private func additionalDetail(for preference: MemoryPreference) -> String {
        switch preference {
        case .sessionOnly: return "Maximum privacy, fresh start each time"
        case .sevenDays: return "Short-term continuity, automatic cleanup"
        case .thirtyDays: return "Longer context, better personalization"
        }
    }
}

// MARK: - Memory Preference Screen - Soft & Supportive Design
public struct MemoryPreferenceScreen_SoftSupportive: View {
    @Binding var selection: MemoryPreference
    let onContinue: () -> Void
    
    private let colors = SoftSupportiveColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Gentle header
            VStack(spacing: 20) {
                Text("Your Comfort Zone")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("How would you like me to remember our conversations? Choose what feels most comfortable for you.")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.top, 40)
            .padding(.bottom, 40)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(MemoryPreference.allCases, id: \.self) { preference in
                        gentleMemoryOption(preference: preference)
                    }
                }
                .padding(.horizontal, 32)
                
                // Caring privacy note
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "heart.shield")
                            .font(.system(size: 20))
                            .foregroundStyle(colors.primary)
                        
                        Text("Your Safe Space")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        Spacer()
                    }
                    
                    Text("I'm here to support you in whatever way feels right. Your privacy and comfort are my top priority, and you can always change this setting or clear everything if you need to.")
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textSecondary)
                        .multilineTextAlignment(.leading)
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
                .padding(.horizontal, 32)
                .padding(.top, 32)
                
                Spacer(minLength: 100)
            }
            
            // Supportive continue button
            VStack(spacing: 16) {
                Rectangle()
                    .fill(colors.border)
                    .frame(height: 1)
                
                Button(action: onContinue) {
                    HStack {
                        Text("This feels right for me")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(colors.background)
                        
                        Image(systemName: "arrow.right")
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
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
            .background(colors.background)
        }
        .background(colors.background)
    }
    
    private func gentleMemoryOption(preference: MemoryPreference) -> some View {
        Button {
            selection = preference
        } label: {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(preference.displayName)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        Text(gentleDescription(for: preference))
                            .font(.system(size: 14))
                            .foregroundStyle(colors.textSecondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: selection == preference ? "heart.circle.fill" : "heart.circle")
                        .font(.system(size: 22))
                        .foregroundStyle(selection == preference ? colors.primary : colors.border)
                }
                
                // Gentle benefits
                Text("• " + gentleBenefit(for: preference))
                    .font(.system(size: 13))
                    .foregroundStyle(colors.textTertiary)
                    .multilineTextAlignment(.leading)
            }
            .padding(24)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(selection == preference ? colors.primary.opacity(0.08) : colors.surfaceSecondary)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(selection == preference ? colors.primary.opacity(0.3) : Color.clear, lineWidth: 2)
                    }
            }
        }
        .scaleEffect(selection == preference ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selection)
    }
    
    private func gentleDescription(for preference: MemoryPreference) -> String {
        switch preference {
        case .sessionOnly: return "Each conversation is private and separate"
        case .sevenDays: return "I'll remember you for a week, then give you a fresh start"
        case .thirtyDays: return "I'll get to know you better over a month"
        }
    }
    
    private func gentleBenefit(for preference: MemoryPreference) -> String {
        switch preference {
        case .sessionOnly: return "Complete privacy, perfect for sensitive topics"
        case .sevenDays: return "Some continuity while keeping things fresh"
        case .thirtyDays: return "I can better understand your patterns and progress"
        }
    }
}

// MARK: - Memory Preference Screen - Clean & Focused Design
public struct MemoryPreferenceScreen_CleanFocused: View {
    @Binding var selection: MemoryPreference
    let onContinue: () -> Void
    
    private let colors = CleanFocusedColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Simple header
            VStack(spacing: 16) {
                Text("Memory Setting")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text("How long should data be retained?")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 40)
            
            Spacer()
            
            // Simple options
            VStack(spacing: 16) {
                ForEach(MemoryPreference.allCases, id: \.self) { preference in
                    cleanMemoryOption(preference: preference)
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            // Privacy note
            Text("Encrypted • Secure • Deletable")
                .font(.system(size: 14))
                .foregroundStyle(colors.textTertiary)
                .padding(.horizontal, 32)
            
            Spacer()
            
            // Simple continue
            Button(action: onContinue) {
                Text("Continue")
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
        .background(colors.background)
    }
    
    private func cleanMemoryOption(preference: MemoryPreference) -> some View {
        Button {
            selection = preference
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(preference.displayName)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(colors.textPrimary)
                    
                    Text(preference.description)
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: selection == preference ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 18))
                    .foregroundStyle(selection == preference ? colors.primary : colors.border)
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(selection == preference ? colors.primary : colors.border, lineWidth: 1)
            }
        }
    }
}

#Preview("Perfect Blend Memory") {
    MemoryPreferenceScreen_PerfectBlend(
        selection: .constant(.thirtyDays),
        onContinue: {}
    )
}

#Preview("Soft Supportive Memory") {
    MemoryPreferenceScreen_SoftSupportive(
        selection: .constant(.thirtyDays),
        onContinue: {}
    )
}

#Preview("Clean Focused Memory") {
    MemoryPreferenceScreen_CleanFocused(
        selection: .constant(.thirtyDays),
        onContinue: {}
    )
}