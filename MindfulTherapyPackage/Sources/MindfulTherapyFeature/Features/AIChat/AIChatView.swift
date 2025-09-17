import SwiftUI

// MARK: - Data Models

public struct ChatMessage: Identifiable, Sendable {
    public let id = UUID()
    public let content: String
    public let isFromUser: Bool
    public let timestamp: Date
    
    public init(content: String, isFromUser: Bool, timestamp: Date) {
        self.content = content
        self.isFromUser = isFromUser
        self.timestamp = timestamp
    }
}

public struct ChatData {
    public static let sampleMessages: [ChatMessage] = [
        ChatMessage(
            content: "Hello! I'm Dr. Mindful, your AI therapy companion. I'm here to provide a safe, supportive space for you to explore your thoughts and feelings. How are you doing today?",
            isFromUser: false,
            timestamp: Date().addingTimeInterval(-3600)
        ),
        ChatMessage(
            content: "Hi Dr. Mindful. I've been feeling really overwhelmed lately with work and personal life. Everything feels like it's piling up and I don't know how to handle it all.",
            isFromUser: true,
            timestamp: Date().addingTimeInterval(-3500)
        ),
        ChatMessage(
            content: "Thank you for sharing that with me. Feeling overwhelmed is such a common human experience, especially when we're juggling multiple responsibilities. It takes courage to acknowledge these feelings. Can you tell me more about what specifically is making you feel most overwhelmed right now?",
            isFromUser: false,
            timestamp: Date().addingTimeInterval(-3400)
        )
    ]
}

// MARK: - AI Chat View with Three Design Iterations
// Following S-tier design principles: Users First, Meticulous Craft, Focus & Efficiency

public struct AIChatView: View {
    @State private var selectedDesign = 0
    @State private var messages: [ChatMessage] = ChatData.sampleMessages
    @State private var inputText = ""
    @State private var isTyping = false
    
    private let designOptions = [
        "Perfect Blend",
        "Modern Minimalist", 
        "Focused Therapy",
        "Minimal Glass"
    ]
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // Design selector for testing
            designSelector
            
            // Selected chat design
            selectedChatView
        }
    }
    
    private var designSelector: some View {
        VStack(spacing: 12) {
            Text("AI Chat Design")
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
    private var selectedChatView: some View {
        switch selectedDesign {
        case 0:
            AIChatView_PerfectBlend(
                messages: $messages,
                inputText: $inputText,
                isTyping: $isTyping
            )
        case 1:
            AIChatView_ModernMinimalist(
                messages: $messages,
                inputText: $inputText,
                isTyping: $isTyping
            )
        case 2:
            AIChatView_FocusedTherapy(
                messages: $messages,
                inputText: $inputText,
                isTyping: $isTyping
            )
        case 3:
            AIChatView_MinimalGlass(
                messages: $messages,
                inputText: $inputText,
                isTyping: $isTyping
            )
        default:
            AIChatView_PerfectBlend(
                messages: $messages,
                inputText: $inputText,
                isTyping: $isTyping
            )
        }
    }
}

// MARK: - Perfect Blend AI Chat Design
private struct AIChatView_PerfectBlend: View {
    @Binding var messages: [ChatMessage]
    @Binding var inputText: String
    @Binding var isTyping: Bool
    
    private let colors = PerfectBlendColors()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Chat Header
                chatHeader
                
                // Messages Area
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(messages) { message in
                                MessageRow_PerfectBlend(message: message, colors: colors)
                                    .id(message.id)
                            }
                            
                            if isTyping {
                                TypingIndicator_PerfectBlend(colors: colors)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                // Input Area
                MessageInput_PerfectBlend(
                    inputText: $inputText,
                    isTyping: $isTyping,
                    colors: colors,
                    onSend: sendMessage
                )
            }
            .background(colors.background)
            .navigationBarHidden(true)
        }
    }
    
    private var chatHeader: some View {
        HStack(spacing: 16) {
            // AI Avatar
            ZStack {
                Circle()
                    .fill(colors.primary)
                    .frame(width: 40, height: 40)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 20))
                    .foregroundStyle(colors.background)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Dr. Mindful")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(colors.textPrimary)
                
                Text("AI Therapist • Always here for you")
                    .font(.system(size: 13))
                    .foregroundStyle(colors.textSecondary)
            }
            
            Spacer()
            
            // Menu button
            Button {
                // Show menu
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(colors.textSecondary)
                    .frame(width: 32, height: 32)
                    .background {
                        Circle()
                            .fill(colors.surfaceSecondary)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(colors.background)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(colors.border)
                .frame(height: 1)
        }
    }
    
    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(
            content: inputText,
            isFromUser: true,
            timestamp: Date()
        )
        
        withAnimation(.easeOut(duration: 0.3)) {
            messages.append(userMessage)
        }
        
        inputText = ""
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeOut(duration: 0.3)) {
                isTyping = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let aiResponse = ChatMessage(
                    content: "Thank you for sharing that with me. I understand this can be challenging. Let's explore this together - what would feel most helpful for you right now?",
                    isFromUser: false,
                    timestamp: Date()
                )
                
                withAnimation(.easeOut(duration: 0.3)) {
                    isTyping = false
                    messages.append(aiResponse)
                }
            }
        }
    }
}

// MARK: - Modern Minimalist AI Chat Design
private struct AIChatView_ModernMinimalist: View {
    @Binding var messages: [ChatMessage]
    @Binding var inputText: String
    @Binding var isTyping: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Minimal Header
                HStack {
                    Text("Chat")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Button {
                        // Settings
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 18))
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 16)
                
                // Clean Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(messages) { message in
                                MessageRow_ModernMinimalist(message: message)
                                    .id(message.id)
                            }
                            
                            if isTyping {
                                TypingIndicator_ModernMinimalist()
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                // Minimal Input
                MessageInput_ModernMinimalist(
                    inputText: $inputText,
                    isTyping: $isTyping,
                    onSend: sendMessage
                )
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        }
    }
    
    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(
            content: inputText,
            isFromUser: true,
            timestamp: Date()
        )
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            messages.append(userMessage)
        }
        
        inputText = ""
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let aiResponse = ChatMessage(
                    content: "I hear you. This is a safe space to explore whatever you're feeling. What's on your mind today?",
                    isFromUser: false,
                    timestamp: Date()
                )
                
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isTyping = false
                    messages.append(aiResponse)
                }
            }
        }
    }
}

// MARK: - Focused Therapy AI Chat Design
private struct AIChatView_FocusedTherapy: View {
    @Binding var messages: [ChatMessage]
    @Binding var inputText: String
    @Binding var isTyping: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Professional Header
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Therapy Session")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(.primary)
                            
                            Text("Confidential & Secure")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Session 1")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.primary)
                            
                            Text("Today, \(formattedTime)")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Divider()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(Color(.systemGroupedBackground))
                
                // Structured Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(messages) { message in
                                MessageRow_FocusedTherapy(message: message)
                                    .id(message.id)
                            }
                            
                            if isTyping {
                                TypingIndicator_FocusedTherapy()
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation(.easeInOut(duration: 0.4)) {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                // Professional Input
                MessageInput_FocusedTherapy(
                    inputText: $inputText,
                    isTyping: $isTyping,
                    onSend: sendMessage
                )
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        }
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(
            content: inputText,
            isFromUser: true,
            timestamp: Date()
        )
        
        withAnimation(.easeInOut(duration: 0.3)) {
            messages.append(userMessage)
        }
        
        inputText = ""
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isTyping = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let aiResponse = ChatMessage(
                    content: "I appreciate you opening up about this. In my clinical experience, many people face similar challenges. Let's work through this step by step. Can you tell me more about when you first noticed these feelings?",
                    isFromUser: false,
                    timestamp: Date()
                )
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    isTyping = false
                    messages.append(aiResponse)
                }
            }
        }
    }
}

// MARK: - Perfect Blend Message Components

private struct MessageRow_PerfectBlend: View {
    let message: ChatMessage
    let colors: PerfectBlendColors
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if message.isFromUser {
                Spacer(minLength: 60)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(colors.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 11))
                        .foregroundStyle(colors.textTertiary)
                }
            } else {
                // AI Avatar
                ZStack {
                    Circle()
                        .fill(colors.surfaceSecondary)
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textSecondary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.content)
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textPrimary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(colors.surfaceSecondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 11))
                        .foregroundStyle(colors.textTertiary)
                        .padding(.leading, 16)
                }
                
                Spacer(minLength: 60)
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

private struct TypingIndicator_PerfectBlend: View {
    let colors: PerfectBlendColors
    @State private var animationPhase = 0
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // AI Avatar
            ZStack {
                Circle()
                    .fill(colors.surfaceSecondary)
                    .frame(width: 32, height: 32)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 16))
                    .foregroundStyle(colors.textSecondary)
            }
            
            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(colors.textTertiary)
                        .frame(width: 6, height: 6)
                        .scaleEffect(animationPhase == index ? 1.2 : 0.8)
                        .animation(
                            .easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                            value: animationPhase
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(colors.surfaceSecondary)
            }
            
            Spacer(minLength: 60)
        }
        .onAppear {
            animationPhase = 1
        }
    }
}

private struct MessageInput_PerfectBlend: View {
    @Binding var inputText: String
    @Binding var isTyping: Bool
    let colors: PerfectBlendColors
    let onSend: () -> Void
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(colors.border)
            
            HStack(spacing: 12) {
                HStack(spacing: 8) {
                    TextField("Type your message...", text: $inputText, axis: .vertical)
                        .font(.system(size: 16))
                        .foregroundStyle(colors.textPrimary)
                        .focused($isInputFocused)
                        .lineLimit(1...6)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(colors.surfaceSecondary)
                }
                
                Button {
                    onSend()
                    isInputFocused = false
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background {
                            Circle()
                                .fill(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? colors.textTertiary : colors.primary)
                        }
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isTyping)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(colors.background)
        }
    }
}

// MARK: - Modern Minimalist Message Components

private struct MessageRow_ModernMinimalist: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if message.isFromUser {
                Spacer(minLength: 40)
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(message.content)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .background {
                            UnevenRoundedRectangle(
                                topLeadingRadius: 24,
                                bottomLeadingRadius: 24,
                                bottomTrailingRadius: 6,
                                topTrailingRadius: 24
                            )
                            .fill(Color.black)
                        }
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                }
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text(message.content)
                        .font(.system(size: 16))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .background {
                            UnevenRoundedRectangle(
                                topLeadingRadius: 6,
                                bottomLeadingRadius: 24,
                                bottomTrailingRadius: 24,
                                topTrailingRadius: 24
                            )
                            .fill(Color(.systemGray6))
                        }
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                        .padding(.leading, 18)
                }
                
                Spacer(minLength: 40)
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

private struct TypingIndicator_ModernMinimalist: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(.secondary)
                        .frame(width: 8, height: 8)
                        .offset(y: animationOffset)
                        .animation(
                            .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.1),
                            value: animationOffset
                        )
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background {
                UnevenRoundedRectangle(
                    topLeadingRadius: 6,
                    bottomLeadingRadius: 24,
                    bottomTrailingRadius: 24,
                    topTrailingRadius: 24
                )
                .fill(Color(.systemGray6))
            }
            
            Spacer(minLength: 40)
        }
        .onAppear {
            animationOffset = -4
        }
    }
}

private struct MessageInput_ModernMinimalist: View {
    @Binding var inputText: String
    @Binding var isTyping: Bool
    let onSend: () -> Void
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color(.systemGray5))
                .frame(height: 1)
            
            HStack(spacing: 16) {
                TextField("Message...", text: $inputText, axis: .vertical)
                    .font(.system(size: 17))
                    .focused($isInputFocused)
                    .lineLimit(1...6)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray6))
                    }
                
                Button {
                    onSend()
                    isInputFocused = false
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .secondary : Color.black)
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isTyping)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .background(Color(.systemBackground))
        }
    }
}

// MARK: - Focused Therapy Message Components

private struct MessageRow_FocusedTherapy: View {
    let message: ChatMessage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(message.isFromUser ? "You" : "Dr. Mindful")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(formatTime(message.timestamp))
                    .font(.system(size: 12))
                    .foregroundStyle(.tertiary)
            }
            
            Text(message.content)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(message.isFromUser ? Color(.systemBlue).opacity(0.1) : Color(.systemGroupedBackground))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(message.isFromUser ? Color(.systemBlue).opacity(0.2) : Color(.systemGray4), lineWidth: 1)
                        }
                }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

private struct TypingIndicator_FocusedTherapy: View {
    @State private var dotScale: [CGFloat] = [1, 1, 1]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Dr. Mindful")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("typing...")
                    .font(.system(size: 12))
                    .foregroundStyle(.tertiary)
            }
            
            HStack(spacing: 6) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(.secondary)
                        .frame(width: 8, height: 8)
                        .scaleEffect(dotScale[index])
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGroupedBackground))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
            }
        }
        .onAppear {
            startTypingAnimation()
        }
    }
    
    private func startTypingAnimation() {
        Task { @MainActor in
            for i in 0..<3 {
                Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                    Task { @MainActor in
                        withAnimation(.easeInOut(duration: 0.3).delay(Double(i) * 0.1)) {
                            dotScale[i] = dotScale[i] == 1 ? 1.5 : 1
                        }
                    }
                }
            }
        }
    }
}

private struct MessageInput_FocusedTherapy: View {
    @Binding var inputText: String
    @Binding var isTyping: Bool
    let onSend: () -> Void
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color(.systemGray4))
            
            VStack(spacing: 12) {
                HStack {
                    Text("Share your thoughts:")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
                
                HStack(alignment: .bottom, spacing: 12) {
                    TextField("Type your message here...", text: $inputText, axis: .vertical)
                        .font(.system(size: 16))
                        .focused($isInputFocused)
                        .lineLimit(1...6)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                    
                    Button {
                        onSend()
                        isInputFocused = false
                    } label: {
                        Text("Send")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color(.systemGray4) : Color(.systemBlue))
                            }
                    }
                    .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isTyping)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .background(Color(.systemGroupedBackground))
        }
    }
}

// MARK: - Minimal Glass AI Chat Design
// Following S-Tier Design Principles: Users First, Simplicity & Clarity, Focus & Efficiency
// Subtle glass effects enhance without compromising core principles

private struct AIChatView_MinimalGlass: View {
    @Binding var messages: [ChatMessage]
    @Binding var inputText: String
    @Binding var isTyping: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Clean, minimal header
                minimalHeader
                
                // Messages with subtle depth
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(messages) { message in
                                MessageRow_MinimalGlass(message: message)
                                    .id(message.id)
                            }
                            
                            if isTyping {
                                TypingIndicator_MinimalGlass()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                // Clean input with subtle glass effect
                MessageInput_MinimalGlass(
                    inputText: $inputText,
                    isTyping: $isTyping,
                    onSend: sendMessage
                )
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        }
    }
    
    private var minimalHeader: some View {
        HStack(spacing: 16) {
            // Simple, clean AI avatar
            ZStack {
                Circle()
                    .fill(.regularMaterial)
                    .frame(width: 40, height: 40)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.primary)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Dr. Mindful")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Text("AI Therapist")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Simple settings button
            Button {
                // Settings action
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(width: 32, height: 32)
                    .background(.regularMaterial, in: Circle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background {
            Rectangle()
                .fill(Color(.systemBackground))
                .overlay(alignment: .bottom) {
                    Divider()
                }
        }
    }
    
    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(
            content: inputText,
            isFromUser: true,
            timestamp: Date()
        )
        
        withAnimation(.easeOut(duration: 0.3)) {
            messages.append(userMessage)
        }
        
        inputText = ""
        
        // Simple AI response simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeOut(duration: 0.3)) {
                isTyping = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let aiResponse = ChatMessage(
                    content: "Thank you for sharing that with me. I'm here to listen and support you. What would be most helpful to explore together?",
                    isFromUser: false,
                    timestamp: Date()
                )
                
                withAnimation(.easeOut(duration: 0.3)) {
                    isTyping = false
                    messages.append(aiResponse)
                }
            }
        }
    }
}

// MARK: - Minimal Glass Message Components
// S-Tier Principles: Simplicity & Clarity, Users First, Meticulous Craft

private struct MessageRow_MinimalGlass: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if message.isFromUser {
                Spacer(minLength: 60)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background {
                            // Clean user bubble with subtle glass
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBlue))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.thinMaterial)
                                        .opacity(0.2)
                                }
                        }
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
            } else {
                // Simple AI avatar
                ZStack {
                    Circle()
                        .fill(.regularMaterial)
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 16))
                        .foregroundStyle(.primary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.content)
                        .font(.system(size: 16))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background {
                            // Clean AI bubble with subtle glass
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.regularMaterial)
                        }
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .padding(.leading, 16)
                }
                
                Spacer(minLength: 60)
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

private struct TypingIndicator_MinimalGlass: View {
    @State private var animationPhase = 0
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Simple AI avatar
            ZStack {
                Circle()
                    .fill(.regularMaterial)
                    .frame(width: 32, height: 32)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 16))
                    .foregroundStyle(.primary)
            }
            
            // Clean typing dots
            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(.secondary)
                        .frame(width: 6, height: 6)
                        .scaleEffect(animationPhase == index ? 1.2 : 0.8)
                        .animation(
                            .easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                            value: animationPhase
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.regularMaterial)
            }
            
            Spacer(minLength: 60)
        }
        .onAppear {
            animationPhase = 1
        }
    }
}

private struct MessageInput_MinimalGlass: View {
    @Binding var inputText: String
    @Binding var isTyping: Bool
    let onSend: () -> Void
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack(spacing: 12) {
                TextField("Type your message...", text: $inputText, axis: .vertical)
                    .font(.system(size: 16))
                    .focused($isInputFocused)
                    .lineLimit(1...6)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.regularMaterial)
                    }
                
                Button {
                    onSend()
                    isInputFocused = false
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background {
                            Circle()
                                .fill(
                                    inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty 
                                    ? Color.gray.opacity(0.3)
                                    : Color.blue
                                )
                                .overlay {
                                    Circle()
                                        .fill(.thinMaterial)
                                        .opacity(0.2)
                                }
                        }
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isTyping)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.primary.opacity(0.05))
        }
    }
}

#Preview {
    AIChatView()
}