import SwiftUI

// MARK: - Button Styles following S-tier design principles
// iOS 16.0+ Compatible - Using Modern APIs

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.semibold)
            .foregroundStyle(Color.white)
            .frame(minHeight: 44) // Apple's minimum touch target
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(isEnabled ? DesignSystem.Colors.primary : DesignSystem.Colors.neutral400)
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: DesignSystem.Animation.fast), value: configuration.isPressed)
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.semibold)
            .foregroundStyle(isEnabled ? DesignSystem.Colors.primary : DesignSystem.Colors.neutral500)
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(Color.clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                            .stroke(
                                isEnabled ? DesignSystem.Colors.primary : DesignSystem.Colors.neutral400,
                                lineWidth: 1.5
                            )
                    }
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: DesignSystem.Animation.fast), value: configuration.isPressed)
    }
}

public struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.medium)
            .foregroundStyle(isEnabled ? DesignSystem.Colors.primary : DesignSystem.Colors.neutral500)
            .frame(minHeight: 44)
            .padding(.horizontal, DesignSystem.Spacing.md)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(configuration.isPressed ? DesignSystem.Colors.primary.opacity(0.1) : Color.clear)
            }
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: DesignSystem.Animation.fast), value: configuration.isPressed)
    }
}

public struct DestructiveButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.body)
            .fontWeight(.semibold)
            .foregroundStyle(Color.white)
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.sm)
                    .fill(isEnabled ? DesignSystem.Colors.error : DesignSystem.Colors.neutral400)
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: DesignSystem.Animation.fast), value: configuration.isPressed)
    }
}

// MARK: - Icon Button for compact actions
public struct IconButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(isEnabled ? DesignSystem.Colors.neutral600 : DesignSystem.Colors.neutral400)
            .frame(width: 44, height: 44) // Apple's minimum touch target
            .background {
                Circle()
                    .fill(configuration.isPressed ? DesignSystem.Colors.neutral300 : Color.clear)
            }
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: DesignSystem.Animation.fast), value: configuration.isPressed)
    }
}

// MARK: - Floating Action Button
public struct FloatingActionButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(Color.white)
            .frame(width: 56, height: 56)
            .background {
                Circle()
                    .fill(DesignSystem.Colors.primary)
                    .shadow(color: DesignSystem.Shadow.md, radius: 8, x: 0, y: 4)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: DesignSystem.Animation.fast), value: configuration.isPressed)
    }
}

// MARK: - Button Style Extensions
extension ButtonStyle where Self == PrimaryButtonStyle {
    public static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    public static var secondary: SecondaryButtonStyle { SecondaryButtonStyle() }
}

extension ButtonStyle where Self == TertiaryButtonStyle {
    public static var tertiary: TertiaryButtonStyle { TertiaryButtonStyle() }
}

extension ButtonStyle where Self == DestructiveButtonStyle {
    public static var destructive: DestructiveButtonStyle { DestructiveButtonStyle() }
}

extension ButtonStyle where Self == IconButtonStyle {
    public static var icon: IconButtonStyle { IconButtonStyle() }
}

extension ButtonStyle where Self == FloatingActionButtonStyle {
    public static var floatingAction: FloatingActionButtonStyle { FloatingActionButtonStyle() }
}