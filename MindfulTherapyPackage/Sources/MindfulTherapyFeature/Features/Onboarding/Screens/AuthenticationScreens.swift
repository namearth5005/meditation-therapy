import SwiftUI

// MARK: - Authentication Screen - Perfect Blend Design
public struct AuthenticationScreen_PerfectBlend: View {
    @Binding var email: String
    @Binding var password: String
    let onSignUp: () -> Void
    let onSignIn: () -> Void
    
    @State private var isSignUpMode = true
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var isLoading = false
    
    private let colors = PerfectBlendColors()
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    Text(isSignUpMode ? "Your Transformation Awaits" : "Welcome Back, Champion")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(colors.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(isSignUpMode ? "Join 100,000+ people who transformed their mental health in just 7 days" : "Continue your breakthrough journey to better mental health")
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Social Login Options
                VStack(spacing: 16) {
                    socialLoginButton(
                        icon: "apple.logo",
                        title: "Continue with Apple",
                        backgroundColor: colors.textPrimary,
                        textColor: colors.background
                    )
                    
                    socialLoginButton(
                        icon: "globe.asia.australia",
                        title: "Continue with Google",
                        backgroundColor: colors.surfaceSecondary,
                        textColor: colors.textPrimary
                    )
                }
                
                // Divider
                HStack {
                    Rectangle()
                        .fill(colors.border)
                        .frame(height: 1)
                    
                    Text("or")
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textTertiary)
                        .padding(.horizontal, 16)
                    
                    Rectangle()
                        .fill(colors.border)
                        .frame(height: 1)
                }
                
                // Email & Password Form
                VStack(spacing: 20) {
                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        TextField("Enter your email", text: $email)
                            .font(.system(size: 16))
                            .foregroundStyle(colors.textPrimary)
                            .padding(16)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(colors.surfaceSecondary)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(colors.border, lineWidth: 1)
                                    }
                            }
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(colors.textPrimary)
                        
                        HStack {
                            if showPassword {
                                TextField("Create a secure password", text: $password)
                            } else {
                                SecureField("Create a secure password", text: $password)
                            }
                            
                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .font(.system(size: 16))
                                    .foregroundStyle(colors.textTertiary)
                            }
                        }
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textPrimary)
                        .padding(16)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colors.surfaceSecondary)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(colors.border, lineWidth: 1)
                                }
                        }
                    }
                    
                    // Confirm password (sign up only)
                    if isSignUpMode {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirm Password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(colors.textPrimary)
                            
                            SecureField("Confirm your password", text: $confirmPassword)
                                .font(.system(size: 16))
                                .foregroundStyle(colors.textPrimary)
                                .padding(16)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(colors.surfaceSecondary)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(colors.border, lineWidth: 1)
                                        }
                                }
                        }
                    }
                }
                
                // Main action button
                Button(action: isSignUpMode ? onSignUp : onSignIn) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: colors.background))
                                .scaleEffect(0.8)
                        }
                        
                        Text(isSignUpMode ? "Create Account" : "Sign In")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(colors.background)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(colors.primary)
                    }
                }
                .disabled(email.isEmpty || password.isEmpty || (isSignUpMode && confirmPassword != password))
                .opacity(email.isEmpty || password.isEmpty || (isSignUpMode && confirmPassword != password) ? 0.5 : 1.0)
                
                // Toggle mode
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isSignUpMode.toggle()
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(isSignUpMode ? "Already have an account?" : "Don't have an account?")
                            .font(.system(size: 14))
                            .foregroundStyle(colors.textSecondary)
                        
                        Text(isSignUpMode ? "Sign In" : "Sign Up")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(colors.primary)
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 32)
        }
        .background(colors.background)
    }
    
    private func socialLoginButton(icon: String, title: String, backgroundColor: Color, textColor: Color) -> some View {
        Button {
            // Social login action
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(textColor)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(colors.border, lineWidth: backgroundColor == colors.surfaceSecondary ? 1 : 0)
                    }
            }
        }
    }
}

// MARK: - Authentication Screen - Soft & Supportive Design
public struct AuthenticationScreen_SoftSupportive: View {
    @Binding var email: String
    @Binding var password: String
    let onSignUp: () -> Void
    let onSignIn: () -> Void
    
    @State private var isSignUpMode = true
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var isLoading = false
    
    private let colors = SoftSupportiveColors()
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Warm header
                VStack(spacing: 16) {
                    Text(isSignUpMode ? "Welcome to Your Journey" : "Welcome Back, Friend")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(colors.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(isSignUpMode ? "Let's create a safe space just for you" : "Ready to continue your wellness path?")
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Gentle social options
                VStack(spacing: 16) {
                    gentleSocialButton(
                        icon: "apple.logo",
                        title: "Continue with Apple"
                    )
                    
                    gentleSocialButton(
                        icon: "globe",
                        title: "Continue with Google"
                    )
                }
                
                // Soft divider
                HStack {
                    Rectangle()
                        .fill(colors.border)
                        .frame(height: 1)
                    
                    Text("or create with email")
                        .font(.system(size: 14))
                        .foregroundStyle(colors.textSecondary)
                        .padding(.horizontal, 16)
                    
                    Rectangle()
                        .fill(colors.border)
                        .frame(height: 1)
                }
                
                // Gentle form
                VStack(spacing: 24) {
                    gentleFormField(
                        label: "Email Address",
                        placeholder: "your@email.com",
                        text: $email,
                        isSecure: false
                    )
                    
                    gentleFormField(
                        label: "Password",
                        placeholder: "Choose a secure password",
                        text: $password,
                        isSecure: !showPassword,
                        showPasswordToggle: true
                    )
                    
                    if isSignUpMode {
                        gentleFormField(
                            label: "Confirm Password",
                            placeholder: "Confirm your password",
                            text: $confirmPassword,
                            isSecure: true
                        )
                    }
                }
                
                // Gentle action button
                Button(action: isSignUpMode ? onSignUp : onSignIn) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: colors.background))
                                .scaleEffect(0.8)
                        }
                        
                        Text(isSignUpMode ? "Begin My Journey" : "Continue Journey")
                            .font(.system(size: 16, weight: .medium))
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
                .disabled(email.isEmpty || password.isEmpty || (isSignUpMode && confirmPassword != password))
                .opacity(email.isEmpty || password.isEmpty || (isSignUpMode && confirmPassword != password) ? 0.6 : 1.0)
                
                // Gentle mode toggle
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isSignUpMode.toggle()
                    }
                } label: {
                    VStack(spacing: 4) {
                        Text(isSignUpMode ? "Already part of our community?" : "New to MindfulTherapy?")
                            .font(.system(size: 14))
                            .foregroundStyle(colors.textSecondary)
                        
                        Text(isSignUpMode ? "Sign in here" : "Create your account")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(colors.primary)
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 32)
        }
        .background(colors.background)
    }
    
    private func gentleSocialButton(icon: String, title: String) -> some View {
        Button {
            // Social login action
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(colors.textPrimary)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(colors.surfaceSecondary)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(colors.primary.opacity(0.2), lineWidth: 1)
                    }
            }
        }
    }
    
    private func gentleFormField(label: String, placeholder: String, text: Binding<String>, isSecure: Bool, showPasswordToggle: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(colors.textPrimary)
            
            HStack {
                if isSecure {
                    SecureField(placeholder, text: text)
                } else {
                    TextField(placeholder, text: text)
                        .keyboardType(label.lowercased().contains("email") ? .emailAddress : .default)
                        .textInputAutocapitalization(.never)
                }
                
                if showPasswordToggle {
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .font(.system(size: 16))
                            .foregroundStyle(colors.textTertiary)
                    }
                }
            }
            .font(.system(size: 16))
            .foregroundStyle(colors.textPrimary)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(colors.surfaceSecondary)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(colors.primary.opacity(0.1), lineWidth: 1)
                    }
            }
        }
    }
}

// MARK: - Authentication Screen - Clean & Focused Design
public struct AuthenticationScreen_CleanFocused: View {
    @Binding var email: String
    @Binding var password: String
    let onSignUp: () -> Void
    let onSignIn: () -> Void
    
    @State private var isSignUpMode = true
    @State private var confirmPassword = ""
    @State private var isLoading = false
    
    private let colors = CleanFocusedColors()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Minimal header
            VStack(spacing: 20) {
                Text(isSignUpMode ? "Sign Up" : "Sign In")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(colors.textPrimary)
                
                Text(isSignUpMode ? "Create your account" : "Access your account")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
            }
            .padding(.top, 60)
            .padding(.bottom, 40)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Clean form
                    VStack(spacing: 20) {
                        cleanFormField("Email", text: $email, keyboardType: .emailAddress)
                        cleanFormField("Password", text: $password, isSecure: true)
                        
                        if isSignUpMode {
                            cleanFormField("Confirm Password", text: $confirmPassword, isSecure: true)
                        }
                    }
                    
                    // Simple action button
                    Button(action: isSignUpMode ? onSignUp : onSignIn) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: colors.background))
                                    .scaleEffect(0.8)
                            }
                            
                            Text(isSignUpMode ? "Create Account" : "Sign In")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(colors.background)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colors.primary)
                        }
                    }
                    .disabled(email.isEmpty || password.isEmpty || (isSignUpMode && confirmPassword != password))
                    .opacity(email.isEmpty || password.isEmpty || (isSignUpMode && confirmPassword != password) ? 0.5 : 1.0)
                    
                    // Social options
                    VStack(spacing: 16) {
                        Divider()
                            .foregroundStyle(colors.border)
                        
                        cleanSocialButton("Sign in with Apple", icon: "apple.logo")
                        cleanSocialButton("Sign in with Google", icon: "globe")
                    }
                    .padding(.top, 20)
                    
                    Spacer(minLength: 60)
                }
                .padding(.horizontal, 32)
            }
            
            // Bottom toggle
            VStack(spacing: 16) {
                Divider()
                    .foregroundStyle(colors.border)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isSignUpMode.toggle()
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(isSignUpMode ? "Have an account?" : "Need an account?")
                            .font(.system(size: 14))
                            .foregroundStyle(colors.textSecondary)
                        
                        Text(isSignUpMode ? "Sign In" : "Sign Up")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(colors.primary)
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .background(colors.background)
    }
    
    private func cleanFormField(_ label: String, text: Binding<String>, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(colors.textPrimary)
            
            Group {
                if isSecure {
                    SecureField(label.lowercased(), text: text)
                } else {
                    TextField(label.lowercased(), text: text)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(.never)
                }
            }
            .font(.system(size: 16))
            .foregroundStyle(colors.textPrimary)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(colors.border, lineWidth: 1)
            }
        }
    }
    
    private func cleanSocialButton(_ title: String, icon: String) -> some View {
        Button {
            // Social login action
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textPrimary)
                
                Text(title)
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(colors.border, lineWidth: 1)
            }
        }
    }
}

#Preview("Perfect Blend Auth") {
    AuthenticationScreen_PerfectBlend(
        email: .constant(""),
        password: .constant(""),
        onSignUp: {},
        onSignIn: {}
    )
}

#Preview("Soft Supportive Auth") {
    AuthenticationScreen_SoftSupportive(
        email: .constant(""),
        password: .constant(""),
        onSignUp: {},
        onSignIn: {}
    )
}

#Preview("Clean Focused Auth") {
    AuthenticationScreen_CleanFocused(
        email: .constant(""),
        password: .constant(""),
        onSignUp: {},
        onSignIn: {}
    )
}