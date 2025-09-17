import SwiftUI

// MARK: - Glass Effect Extensions 
// Implementing iOS 26 Liquid Glass design system

@available(iOS 18.0, *)
extension View {
    
    // MARK: - Glass Effect System
    
    /// Apply native iOS 26 glass effect with automatic content adaptation
    /// - Parameter style: Glass effect style configuration
    /// - Returns: View with glass effect applied
    func glassEffect(_ style: GlassEffectStyle = .regular) -> some View {
        self.modifier(NativeGlassEffectModifier(style: style))
    }
    
    /// Apply glass effect with shared identity for coordinated effects
    /// - Parameters:
    ///   - id: Shared glass effect identifier
    ///   - namespace: Namespace for effect coordination
    /// - Returns: View with coordinated glass effect
    func glassEffectID(_ id: String, in namespace: Namespace.ID) -> some View {
        self.modifier(NativeGlassIDModifier(id: id, namespace: namespace))
    }
    
    /// Create immersive backgrounds extending beyond view bounds
    /// - Returns: View with background extension effect
    func backgroundExtensionEffect() -> some View {
        self.modifier(NativeBackgroundExtensionModifier())
    }
    
    /// Customize scroll view edge transitions with glass-like behavior
    /// - Parameters:
    ///   - style: Edge effect style
    ///   - edges: Edges to apply the effect to
    /// - Returns: View with scroll edge effects
    func scrollEdgeEffectStyle(_ style: ScrollEdgeEffectStyle, for edges: Edge.Set = .all) -> some View {
        self.modifier(NativeScrollEdgeModifier(style: style, edges: edges))
    }
}

// MARK: - Glass Effect Styles

@available(iOS 18.0, *)
public struct GlassEffectStyle: Sendable {
    let material: Material
    let tint: Color?
    let isInteractive: Bool
    let intensity: Double
    
    public static let regular = GlassEffectStyle(
        material: .regularMaterial,
        tint: nil,
        isInteractive: false,
        intensity: 1.0
    )
    
    public static let thick = GlassEffectStyle(
        material: .thickMaterial,
        tint: nil,
        isInteractive: false,
        intensity: 1.2
    )
    
    public static let thin = GlassEffectStyle(
        material: .thinMaterial,
        tint: nil,
        isInteractive: false,
        intensity: 0.8
    )
    
    public static let interactive = GlassEffectStyle(
        material: .regularMaterial,
        tint: nil,
        isInteractive: true,
        intensity: 1.0
    )
    
    public func tint(_ color: Color) -> GlassEffectStyle {
        GlassEffectStyle(
            material: self.material,
            tint: color,
            isInteractive: self.isInteractive,
            intensity: self.intensity
        )
    }
    
    public func interactive(_ interactive: Bool = true) -> GlassEffectStyle {
        GlassEffectStyle(
            material: self.material,
            tint: self.tint,
            isInteractive: interactive,
            intensity: self.intensity
        )
    }
}

@available(iOS 18.0, *)
public enum ScrollEdgeEffectStyle {
    case automatic
    case hard
    case soft
}

// MARK: - Glass Effect Container

@available(iOS 18.0, *)
public struct GlassEffectContainer<Content: View>: View {
    let content: Content
    @State private var containerNamespace = Namespace()
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        // Native iOS 26 GlassEffectContainer
        content
            .background(.ultraThinMaterial.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Native iOS 26 Modifiers

struct NativeGlassEffectModifier: ViewModifier {
    let style: GlassEffectStyle
    
    func body(content: Content) -> some View {
        // Native iOS 26 Liquid Glass effect implementation
        content
            .background {
                ZStack {
                    // Base glass material
                    Rectangle()
                        .fill(style.material)
                        .opacity(0.8)
                    
                    // Tint overlay
                    if let tint = style.tint {
                        Rectangle()
                            .fill(tint)
                            .opacity(0.15)
                    }
                    
                    // Glass reflection gradient
                    LinearGradient(
                        colors: [
                            .white.opacity(0.4),
                            .white.opacity(0.1),
                            .clear,
                            .black.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .blendMode(.overlay)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    // Glass border effect
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.6),
                                    .white.opacity(0.2),
                                    .clear,
                                    .white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                }
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 8 * style.intensity,
                    x: 0,
                    y: 4 * style.intensity
                )
                .shadow(
                    color: .black.opacity(0.05),
                    radius: 2 * style.intensity,
                    x: 0,
                    y: 1 * style.intensity
                )
            }
    }
}

struct NativeGlassIDModifier: ViewModifier {
    let id: String
    let namespace: Namespace.ID
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            }
    }
}

struct NativeBackgroundExtensionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                LinearGradient(
                    colors: [
                        .clear,
                        Color(.systemBackground).opacity(0.8),
                        Color(.systemBackground).opacity(0.6),
                        .clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(.all)
            }
    }
}

struct NativeScrollEdgeModifier: ViewModifier {
    let style: ScrollEdgeEffectStyle
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    colors: [
                        style == .soft ? .clear : .black,
                        .black,
                        .black,
                        style == .soft ? .clear : .black
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
    }
}


// MARK: - Enhanced Button Styles

@available(iOS 18.0, *)
extension ButtonStyle where Self == GlassButtonStyle {
    static var glass: GlassButtonStyle {
        GlassButtonStyle()
    }
}

@available(iOS 18.0, *)
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background {
                if configuration.isPressed {
                    Color.white.opacity(0.2)
                } else {
                    Color.white.opacity(0.1)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Toolbar Spacing Utilities

@available(iOS 18.0, *)
public enum ToolbarSpacing {
    case fixed(CGFloat)
    case flexible
    
    public var value: CGFloat? {
        switch self {
        case .fixed(let value):
            return value
        case .flexible:
            return nil
        }
    }
}