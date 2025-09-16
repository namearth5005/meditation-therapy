import SwiftUI

// MARK: - Welcome Screen - Perfect Blend Design
public struct WelcomeScreen_PerfectBlend: View {
    let onContinue: () -> Void
    @State private var showContent = false
    
    private let colors = PerfectBlendColors()
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                // App Icon & Branding
                VStack(spacing: 32) {
                    // App icon placeholder
                    Circle()
                        .fill(colors.primary)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 36))
                                .foregroundStyle(colors.background)
                        }
                        .scaleEffect(showContent ? 1.0 : 0.8)
                        .opacity(showContent ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 0.6), value: showContent)
                    
                    VStack(spacing: 16) {
                        Text("MindfulTherapy")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                            .opacity(showContent ? 1.0 : 0.0)
                            .offset(y: showContent ? 0 : 20)
                            .animation(.easeOut(duration: 0.8).delay(0.2), value: showContent)
                        
                        VStack(spacing: 8) {
                            Text("Transform Your Mental Health")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(colors.textPrimary)
                            
                            Text("Join 100,000+ people who've found breakthrough results in just 7 days")
                                .font(.system(size: 16))
                                .foregroundStyle(colors.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: showContent ? 0 : 20)
                        .animation(.easeOut(duration: 0.8).delay(0.4), value: showContent)
                    }
                }
                
                Spacer()
                
                // Features highlights
                VStack(spacing: 24) {
                    featureHighlight(
                        icon: "brain.head.profile",
                        title: "AI Therapist - Never Waits",
                        subtitle: "Get breakthrough insights 24/7 - No appointments, no judgment, just results"
                    )
                    
                    featureHighlight(
                        icon: "moon.stars.fill",
                        title: "Sleep Better Tonight", 
                        subtitle: "87% of users report deeper sleep within 3 days using our guided sessions"
                    )
                    
                    featureHighlight(
                        icon: "chart.line.uptrend.xyaxis.circle.fill",
                        title: "Measurable Transformation",
                        subtitle: "Track your anxiety reduction and mood improvements with clinical precision"
                    )
                }
                .opacity(showContent ? 1.0 : 0.0)
                .offset(y: showContent ? 0 : 30)
                .animation(.easeOut(duration: 1.0).delay(0.6), value: showContent)
                
                Spacer()
                
                // Continue button
                VStack(spacing: 12) {
                    Button(action: onContinue) {
                        HStack {
                            Text("Start My Transformation")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(colors.background)
                            
                            Image(systemName: "sparkles")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(colors.background)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colors.primary)
                                .shadow(color: colors.primary.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                    }
                    
                    Text("✨ FREE 7-day trial • Cancel anytime")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(colors.textSecondary)
                }
                .opacity(showContent ? 1.0 : 0.0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.8).delay(0.8), value: showContent)
                
                // Social proof and urgency
                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.orange)
                        }
                        Text("4.9/5 from 10,000+ reviews")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(colors.textSecondary)
                    }
                    
                    Text("🔒 Military-grade encryption • No data sharing • Completely private")
                        .font(.system(size: 12))
                        .foregroundStyle(colors.textTertiary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 16)
                .opacity(showContent ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.8).delay(1.0), value: showContent)
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colors.background)
            .onAppear {
                showContent = true
            }
        }
    }
    
    private func featureHighlight(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(colors.primary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textSecondary)
            }
            
            Spacer()
        }
    }
}

// MARK: - Welcome Screen - Soft & Supportive Design
public struct WelcomeScreen_SoftSupportive: View {
    let onContinue: () -> Void
    @State private var showContent = false
    
    private let colors = SoftSupportiveColors()
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                // App Icon & Branding
                VStack(spacing: 32) {
                    Circle()
                        .fill(LinearGradient(
                            colors: [colors.primary, colors.accent],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 80, height: 80)
                        .overlay {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 36))
                                .foregroundStyle(colors.background)
                        }
                        .scaleEffect(showContent ? 1.0 : 0.8)
                        .opacity(showContent ? 1.0 : 0.0)
                        .animation(.spring(response: 0.8, dampingFraction: 0.6), value: showContent)
                    
                    VStack(spacing: 16) {
                        Text("MindfulTherapy")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                            .opacity(showContent ? 1.0 : 0.0)
                            .offset(y: showContent ? 0 : 20)
                            .animation(.easeOut(duration: 0.8).delay(0.2), value: showContent)
                        
                        Text("A gentle companion for your wellness journey")
                            .font(.system(size: 18))
                            .foregroundStyle(colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .opacity(showContent ? 1.0 : 0.0)
                            .offset(y: showContent ? 0 : 20)
                            .animation(.easeOut(duration: 0.8).delay(0.4), value: showContent)
                    }
                }
                
                Spacer()
                
                // Gentle features
                VStack(spacing: 24) {
                    gentleFeature(
                        icon: "heart.text.square",
                        title: "Compassionate Support",
                        subtitle: "Caring guidance when you need it most"
                    )
                    
                    gentleFeature(
                        icon: "moon.stars",
                        title: "Peaceful Moments",
                        subtitle: "Gentle meditations for inner calm"
                    )
                    
                    gentleFeature(
                        icon: "chart.bar",
                        title: "Your Journey",
                        subtitle: "Celebrate your progress, big and small"
                    )
                }
                .opacity(showContent ? 1.0 : 0.0)
                .offset(y: showContent ? 0 : 30)
                .animation(.easeOut(duration: 1.0).delay(0.6), value: showContent)
                
                Spacer()
                
                // Continue button
                Button(action: onContinue) {
                    HStack {
                        Text("Begin Your Journey")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(colors.background)
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(colors.background)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(colors.primary)
                    }
                }
                .opacity(showContent ? 1.0 : 0.0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.8).delay(0.8), value: showContent)
                
                // Warm privacy note
                Text("Safe • Private • Always here for you")
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textTertiary)
                    .padding(.top, 16)
                    .opacity(showContent ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 0.8).delay(1.0), value: showContent)
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colors.background)
            .onAppear {
                showContent = true
            }
        }
    }
    
    private func gentleFeature(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(colors.primary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textSecondary)
            }
            
            Spacer()
        }
    }
}

// MARK: - Welcome Screen - Clean & Focused Design
public struct WelcomeScreen_CleanFocused: View {
    let onContinue: () -> Void
    @State private var showContent = false
    
    private let colors = CleanFocusedColors()
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                // Minimal branding
                VStack(spacing: 40) {
                    Circle()
                        .strokeBorder(colors.primary, lineWidth: 2)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Image(systemName: "circle.dotted")
                                .font(.system(size: 32))
                                .foregroundStyle(colors.primary)
                        }
                        .scaleEffect(showContent ? 1.0 : 0.9)
                        .opacity(showContent ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 0.6), value: showContent)
                    
                    VStack(spacing: 20) {
                        Text("MindfulTherapy")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                            .opacity(showContent ? 1.0 : 0.0)
                            .animation(.easeOut(duration: 0.8).delay(0.2), value: showContent)
                        
                        Text("Mental wellness, simplified")
                            .font(.system(size: 18))
                            .foregroundStyle(colors.textSecondary)
                            .opacity(showContent ? 1.0 : 0.0)
                            .animation(.easeOut(duration: 0.8).delay(0.4), value: showContent)
                    }
                }
                
                Spacer()
                
                // Essential features
                VStack(spacing: 32) {
                    essentialFeature("AI Support")
                    essentialFeature("Meditation")  
                    essentialFeature("Progress")
                }
                .opacity(showContent ? 1.0 : 0.0)
                .animation(.easeOut(duration: 1.0).delay(0.6), value: showContent)
                
                Spacer()
                
                // Minimal continue button
                Button(action: onContinue) {
                    Text("Start")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(colors.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colors.primary)
                        }
                }
                .opacity(showContent ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.8).delay(0.8), value: showContent)
                
                // Simple privacy note
                Text("Private & Secure")
                    .font(.system(size: 14))
                    .foregroundStyle(colors.textTertiary)
                    .padding(.top, 16)
                    .opacity(showContent ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 0.8).delay(1.0), value: showContent)
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colors.background)
            .onAppear {
                showContent = true
            }
        }
    }
    
    private func essentialFeature(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(colors.textPrimary)
            
            Spacer()
            
            Image(systemName: "arrow.right")
                .font(.system(size: 12))
                .foregroundStyle(colors.textTertiary)
        }
        .padding(.vertical, 8)
    }
}


#Preview("Perfect Blend") {
    WelcomeScreen_PerfectBlend {
        print("Continue tapped")
    }
}

#Preview("Soft Supportive") {
    WelcomeScreen_SoftSupportive {
        print("Continue tapped")
    }
}

#Preview("Clean Focused") {
    WelcomeScreen_CleanFocused {
        print("Continue tapped")
    }
}