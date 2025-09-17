import SwiftUI
import Foundation

// MARK: - Enhanced Rich Text Journaling with Glass Effects
// Using iOS 26's enhanced TextEditor with AttributedString support

@available(iOS 18.0, *)
public struct EnhancedJournalingView: View {
    @State private var journalEntries: [JournalEntry] = []
    @State private var currentEntry = AttributedString()
    @State private var selectedMood: MoodLevel = .neutral
    @State private var isWriting = false
    @State private var showingMoodPicker = false
    @State private var entryDate = Date()
    
    private let colors = PerfectBlendColors()
    @Namespace private var glassNamespace
    
    public init() {
        // Load existing entries
        _journalEntries = State(initialValue: JournalingData.sampleEntries)
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if isWriting {
                    writingView
                        .backgroundExtensionEffect()
                } else {
                    journalListView
                        .scrollEdgeEffectStyle(.soft, for: .all)
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle(isWriting ? "New Entry" : "Journal")
            .navigationBarTitleDisplayMode(isWriting ? .inline : .large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if isWriting {
                        Button("Cancel") {
                            withAnimation(.spring()) {
                                cancelWriting()
                            }
                        }
                        .foregroundStyle(.red)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Spacer()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if isWriting {
                        Button("Save") {
                            saveEntry()
                        }
                        .buttonStyle(.glass)
                        .disabled(currentEntry.characters.isEmpty)
                    } else {
                        Button("New Entry") {
                            startNewEntry()
                        }
                        .buttonStyle(.glass)
                    }
                }
            }
        }
    }
    
    // MARK: - Journal List View
    private var journalListView: some View {
        ScrollView {
            LazyVStack(spacing: DesignSystem.Spacing.md) {
                // Mood Summary Card
                moodSummaryCard
                    .glassEffect(.regular.tint(.blue.opacity(0.1)))
                
                // Journal Entries
                ForEach(journalEntries) { entry in
                    JournalEntryCard(entry: entry)
                        .glassEffect(.regular.tint(entry.mood.color.opacity(0.1)))
                }
                
                if journalEntries.isEmpty {
                    emptyStateView
                }
            }
            .padding()
        }
    }
    
    // MARK: - Writing View
    private var writingView: some View {
        VStack(spacing: 0) {
            // Writing Header with Mood Selection
            writingHeader
                .glassEffect()
            
            // Rich Text Editor
            richTextEditor
                .padding()
            
            // Writing Tools
            writingToolsBar
                .glassEffect(.interactive)
        }
    }
    
    private var writingHeader: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            // Date and Mood Row
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today's Reflection")
                        .font(.headline)
                        .foregroundStyle(colors.textPrimary)
                    
                    Text(entryDate.formatted(date: .complete, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(colors.textSecondary)
                }
                
                Spacer()
                
                Button {
                    showingMoodPicker = true
                } label: {
                    HStack(spacing: DesignSystem.Spacing.sm) {
                        Text(selectedMood.emoji)
                            .font(.title2)
                        
                        Text(selectedMood.name)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(selectedMood.color)
                    }
                    .padding(.horizontal, DesignSystem.Spacing.md)
                    .padding(.vertical, DesignSystem.Spacing.sm)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(selectedMood.color.opacity(0.1))
                            .glassEffect(.regular.tint(selectedMood.color.opacity(0.2)))
                    }
                }
                .buttonStyle(.plain)
            }
            
            // Writing Prompts
            if currentEntry.characters.isEmpty {
                writingPrompts
            }
        }
        .padding()
    }
    
    private var writingPrompts: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Reflection prompts:")
                .font(.caption)
                .foregroundStyle(colors.textSecondary)
            
            HStack {
                ForEach(JournalingData.reflectionPrompts.prefix(3), id: \.self) { prompt in
                    Button(prompt) {
                        insertPrompt(prompt)
                    }
                    .font(.caption)
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blue.opacity(0.1))
                    }
                }
            }
        }
    }
    
    private var richTextEditor: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("How are you feeling?")
                .font(.headline)
                .foregroundStyle(colors.textPrimary)
            
            // iOS 26 Enhanced TextEditor with Rich Text Support
            TextEditor(text: $currentEntry)
                .font(.body)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                        .fill(.regularMaterial)
                        .glassEffect()
                }
                .frame(minHeight: 200)
            
            // Character count
            HStack {
                Spacer()
                Text("\(currentEntry.characters.count) characters")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var writingToolsBar: some View {
        HStack(spacing: DesignSystem.Spacing.lg) {
            Button {
                // Add gratitude entry
                insertTemplate("What I'm grateful for today:\n• \n• \n• ")
            } label: {
                Label("Gratitude", systemImage: "heart.fill")
                    .font(.caption)
                    .foregroundStyle(.pink)
            }
            .buttonStyle(.glass)
            
            Button {
                // Add goals entry
                insertTemplate("Today's intentions:\n1. \n2. \n3. ")
            } label: {
                Label("Goals", systemImage: "target")
                    .font(.caption)
                    .foregroundStyle(.blue)
            }
            .buttonStyle(.glass)
            
            Button {
                // Add reflection entry
                insertTemplate("Reflection on today:\n\nWhat went well: \n\nWhat I learned: \n\nTomorrow I will: ")
            } label: {
                Label("Reflect", systemImage: "lightbulb.fill")
                    .font(.caption)
                    .foregroundStyle(.yellow)
            }
            .buttonStyle(.glass)
            
            Spacer()
            
            Button {
                // Voice input (conceptual)
                startVoiceInput()
            } label: {
                Image(systemName: "mic.fill")
                    .foregroundStyle(.purple)
            }
            .buttonStyle(.glass)
        }
        .padding()
    }
    
    // MARK: - Mood Summary Card
    private var moodSummaryCard: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            HStack {
                Text("Mood Insights")
                    .font(.headline)
                    .foregroundStyle(colors.textPrimary)
                
                Spacer()
                
                Text("This Week")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: DesignSystem.Spacing.md) {
                // Average mood
                VStack(alignment: .leading, spacing: 4) {
                    Text("Average Mood")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 4) {
                        Text("😊")
                            .font(.title3)
                        Text("7.2")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                    }
                }
                
                Spacer()
                
                // Entries this week
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Entries")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text("12")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(colors.primary)
                }
            }
            
            // Mood trend visualization (simplified)
            moodTrendView
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.regularMaterial)
        }
    }
    
    private var moodTrendView: some View {
        HStack(alignment: .bottom, spacing: 2) {
            ForEach(0..<7) { day in
                RoundedRectangle(cornerRadius: 2)
                    .fill(colors.primary.opacity(0.6))
                    .frame(width: 8, height: CGFloat.random(in: 20...40))
            }
        }
        .frame(height: 40)
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            Image(systemName: "book.pages")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            VStack(spacing: DesignSystem.Spacing.sm) {
                Text("Start Your Journey")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(colors.textPrimary)
                
                Text("Begin documenting your mindfulness journey with your first journal entry")
                    .font(.body)
                    .foregroundStyle(colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Button("Create First Entry") {
                startNewEntry()
            }
            .buttonStyle(.glass)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.lg)
                .fill(.regularMaterial)
                .glassEffect()
        }
    }
    
    // MARK: - Actions
    private func startNewEntry() {
        currentEntry = AttributedString()
        selectedMood = .neutral
        entryDate = Date()
        
        withAnimation(.spring()) {
            isWriting = true
        }
    }
    
    private func cancelWriting() {
        currentEntry = AttributedString()
        isWriting = false
    }
    
    private func saveEntry() {
        let newEntry = JournalEntry(
            content: String(currentEntry.characters),
            mood: selectedMood,
            date: entryDate,
            tags: extractTags(from: String(currentEntry.characters))
        )
        
        journalEntries.insert(newEntry, at: 0)
        
        withAnimation(.spring()) {
            isWriting = false
            currentEntry = AttributedString()
        }
    }
    
    private func insertPrompt(_ prompt: String) {
        currentEntry = AttributedString(prompt + "\n\n")
    }
    
    private func insertTemplate(_ template: String) {
        let existingText = String(currentEntry.characters)
        let newText = existingText.isEmpty ? template : existingText + "\n\n" + template
        currentEntry = AttributedString(newText)
    }
    
    private func startVoiceInput() {
        // Voice input implementation would go here
        // This is conceptual for now
    }
    
    private func extractTags(from text: String) -> [String] {
        // Simple tag extraction based on keywords
        let keywords = ["grateful", "meditation", "stress", "anxiety", "peace", "mindful", "breath"]
        return keywords.filter { text.localizedCaseInsensitiveContains($0) }
    }
}

// MARK: - Journal Entry Card
@available(iOS 18.0, *)
struct JournalEntryCard: View {
    let entry: JournalEntry
    @State private var isExpanded = false
    private let colors = PerfectBlendColors()
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            // Header
            HStack {
                HStack(spacing: DesignSystem.Spacing.sm) {
                    Text(entry.mood.emoji)
                        .font(.title3)
                    
                    Text(entry.mood.name)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(entry.mood.color)
                }
                
                Spacer()
                
                Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // Content
            Text(isExpanded ? entry.content : String(entry.content.prefix(150)) + (entry.content.count > 150 ? "..." : ""))
                .font(.body)
                .foregroundStyle(colors.textPrimary)
                .lineLimit(isExpanded ? nil : 3)
                .animation(.easeInOut, value: isExpanded)
            
            // Tags
            if !entry.tags.isEmpty {
                HStack {
                    ForEach(entry.tags.prefix(3), id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption2)
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue.opacity(0.1))
                            }
                    }
                    
                    if entry.tags.count > 3 {
                        Text("+\(entry.tags.count - 3)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    if entry.content.count > 150 {
                        Button(isExpanded ? "Show Less" : "Show More") {
                            withAnimation(.spring()) {
                                isExpanded.toggle()
                            }
                        }
                        .font(.caption)
                        .foregroundStyle(.blue)
                    }
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.md)
                .fill(.regularMaterial)
        }
        .onTapGesture {
            if entry.content.count > 150 {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }
        }
    }
}

// MARK: - Supporting Types
@available(iOS 18.0, *)
struct JournalEntry: Identifiable {
    let id = UUID()
    let content: String
    let mood: MoodLevel
    let date: Date
    let tags: [String]
}

@available(iOS 18.0, *)
enum MoodLevel: String, CaseIterable {
    case veryHappy = "very_happy"
    case happy = "happy"
    case neutral = "neutral"
    case sad = "sad"
    case verySad = "very_sad"
    
    var name: String {
        switch self {
        case .veryHappy: return "Joyful"
        case .happy: return "Happy"
        case .neutral: return "Neutral"
        case .sad: return "Sad"
        case .verySad: return "Very Sad"
        }
    }
    
    var emoji: String {
        switch self {
        case .veryHappy: return "😄"
        case .happy: return "😊"
        case .neutral: return "😐"
        case .sad: return "😔"
        case .verySad: return "😢"
        }
    }
    
    var color: Color {
        switch self {
        case .veryHappy: return .green
        case .happy: return .mint
        case .neutral: return .gray
        case .sad: return .orange
        case .verySad: return .red
        }
    }
    
    var value: Double {
        switch self {
        case .veryHappy: return 9.0
        case .happy: return 7.0
        case .neutral: return 5.0
        case .sad: return 3.0
        case .verySad: return 1.0
        }
    }
}

// MARK: - Sample Data
@available(iOS 18.0, *)
struct JournalingData {
    static let reflectionPrompts = [
        "How am I feeling right now?",
        "What am I grateful for today?",
        "What did I learn about myself?",
        "How did meditation help me today?",
        "What challenged me today?",
        "What brought me joy today?",
        "How can I be kinder to myself?",
        "What do I need to let go of?"
    ]
    
    static let sampleEntries: [JournalEntry] = [
        JournalEntry(
            content: "Had a wonderful 20-minute meditation session this morning. I noticed my mind was particularly calm today, and I was able to stay focused on my breath for longer periods. The anxiety I've been feeling about work seemed to melt away. I'm grateful for this practice and how it's changing my relationship with stress.",
            mood: .happy,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            tags: ["meditation", "grateful", "anxiety"]
        ),
        JournalEntry(
            content: "Feeling a bit overwhelmed with all the changes happening in my life. The meditation helped me find some peace, but I still feel unsettled. I'm trying to remember that this too shall pass. Taking things one breath at a time.",
            mood: .neutral,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            tags: ["stress", "mindful"]
        ),
        JournalEntry(
            content: "What an amazing day! My meditation practice is really starting to show results. I felt so present during my walk in nature today, noticing the colors of the leaves and the sound of birds. I'm learning to find joy in simple moments.",
            mood: .veryHappy,
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
            tags: ["meditation", "peace", "grateful"]
        )
    ]
}

#Preview {
    EnhancedJournalingView()
}