import SwiftUI

// MARK: - Design System Foundation
// Following S-tier design principles: Stripe, Linear, Airbnb inspired

public struct DesignSystem {
    
    // MARK: - Color Palette
    public struct Colors {
        // Primary Brand Colors
        public static let primary = Color(hex: "6B73FF") // Calming blue-purple
        public static let primaryLight = Color(hex: "9BA3FF")
        public static let primaryDark = Color(hex: "4A52CC")
        
        // Neutrals - 7-step scale for flexibility
        public static let neutral100 = Color(hex: "FFFFFF") // Pure white
        public static let neutral200 = Color(hex: "F8F9FA") // Background light
        public static let neutral300 = Color(hex: "E9ECEF") // Border light
        public static let neutral400 = Color(hex: "CED4DA") // Border medium
        public static let neutral500 = Color(hex: "868E96") // Text secondary
        public static let neutral600 = Color(hex: "495057") // Text primary
        public static let neutral700 = Color(hex: "212529") // Text strong
        
        // Semantic Colors
        public static let success = Color(hex: "10B981") // Green
        public static let error = Color(hex: "EF4444") // Red  
        public static let warning = Color(hex: "F59E0B") // Amber
        public static let info = Color(hex: "3B82F6") // Blue
        
        // Mental Health Specific Colors
        public static let calm = Color(hex: "A7F3D0") // Mint green
        public static let peace = Color(hex: "C7D2FE") // Light lavender
        public static let focus = Color(hex: "FED7AA") // Warm peach
        public static let energy = Color(hex: "FBBF24") // Energizing yellow
        
        // Dark Mode Support
        public struct Dark {
            public static let neutral100 = Color(hex: "000000") // Pure black
            public static let neutral200 = Color(hex: "111827") // Background dark
            public static let neutral300 = Color(hex: "1F2937") // Surface
            public static let neutral400 = Color(hex: "374151") // Border dark
            public static let neutral500 = Color(hex: "6B7280") // Text secondary
            public static let neutral600 = Color(hex: "9CA3AF") // Text primary
            public static let neutral700 = Color(hex: "F9FAFB") // Text strong
        }
    }
    
    // MARK: - Typography Scale
    public struct Typography {
        // Font Family - Using system fonts for iOS
        public static let fontFamily = Font.system(.body, design: .default)
        
        // Type Scale - Modular approach
        public static let h1 = Font.system(size: 32, weight: .bold, design: .default)
        public static let h2 = Font.system(size: 28, weight: .bold, design: .default)
        public static let h3 = Font.system(size: 24, weight: .semibold, design: .default)
        public static let h4 = Font.system(size: 20, weight: .semibold, design: .default)
        public static let bodyLarge = Font.system(size: 18, weight: .regular, design: .default)
        public static let body = Font.system(size: 16, weight: .regular, design: .default) // Default
        public static let bodySmall = Font.system(size: 14, weight: .regular, design: .default)
        public static let caption = Font.system(size: 12, weight: .medium, design: .default)
    }
    
    // MARK: - Spacing Scale
    public struct Spacing {
        // Base unit: 4px - iOS optimized
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 24
        public static let xxl: CGFloat = 32
        public static let xxxl: CGFloat = 48
        
        // Semantic spacing
        public static let cardPadding: CGFloat = lg
        public static let screenPadding: CGFloat = lg
        public static let sectionSpacing: CGFloat = xl
    }
    
    // MARK: - Border Radii
    public struct Radius {
        public static let sm: CGFloat = 8  // Buttons, inputs
        public static let md: CGFloat = 12 // Cards, modals
        public static let lg: CGFloat = 16 // Large cards
        public static let xl: CGFloat = 24 // Hero elements
        public static let round: CGFloat = 999 // Fully rounded
    }
    
    // MARK: - Shadows
    public struct Shadow {
        public static let sm = Color.black.opacity(0.05)
        public static let md = Color.black.opacity(0.1)
        public static let lg = Color.black.opacity(0.15)
    }
    
    // MARK: - Animation Durations
    public struct Animation {
        public static let fast: Double = 0.2
        public static let normal: Double = 0.3
        public static let slow: Double = 0.5
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}