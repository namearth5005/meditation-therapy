import SwiftUI

public struct ContentView: View {
    @State private var selectedDesign = 0
    
    private let designOptions = [
        "Minimalist Zen",
        "Soft & Supportive", 
        "Clean & Focused",
        "Perfect Blend",
        "Onboarding Flow",
        "Meditation Library",
        "AI Chat"
    ]
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Design selector
                designSelector
                
                // Selected design view
                selectedDesignView
            }
            .navigationTitle("MindfulTherapy Designs")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var designSelector: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("Choose Your Design")
                .font(DesignSystem.Typography.h4)
                .fontWeight(.semibold)
                .foregroundStyle(DesignSystem.Colors.neutral700)
            
            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(0..<designOptions.count, id: \.self) { index in
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedDesign = index
                        }
                    } label: {
                        Text(designOptions[index])
                            .font(DesignSystem.Typography.bodySmall)
                            .fontWeight(.medium)
                            .foregroundStyle(
                                selectedDesign == index 
                                ? .white 
                                : DesignSystem.Colors.primary
                            )
                            .padding(.horizontal, DesignSystem.Spacing.md)
                            .padding(.vertical, DesignSystem.Spacing.sm)
                            .background {
                                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                                    .fill(
                                        selectedDesign == index 
                                        ? DesignSystem.Colors.primary 
                                        : DesignSystem.Colors.primary.opacity(0.1)
                                    )
                            }
                    }
                }
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.screenPadding)
        .padding(.vertical, DesignSystem.Spacing.lg)
        .background(DesignSystem.Colors.neutral100)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
    
    @ViewBuilder
    private var selectedDesignView: some View {
        switch selectedDesign {
        case 0:
            HomeView_MinimalistZen()
        case 1:
            HomeView_WarmNurturing()
        case 2:
            HomeView_CleanFocused()
        case 3:
            HomeView_PerfectBlend()
        case 4:
            OnboardingCoordinator()
        case 5:
            MeditationLibraryView()
        case 6:
            AIChatView()
        default:
            HomeView_MinimalistZen()
        }
    }
    
    public init() {}
}
