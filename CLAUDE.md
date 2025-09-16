# Project Overview

This is a native **iOS application** built with **Swift 6.1+** and **SwiftUI** showcasing **Liquid Glass design from iOS 26**. The codebase targets **iOS 18.0 and later** with progressive enhancement for **iOS 26+ Liquid Glass features**. All concurrency is handled with **Swift Concurrency** (async/await, actors, @MainActor isolation) ensuring thread-safe code.

- **Frameworks & Tech:** SwiftUI for UI, Swift Concurrency with strict mode, Swift Package Manager for modular architecture
- **Architecture:** Model-View (MV) pattern using pure SwiftUI state management. We avoid MVVM and instead leverage SwiftUI's built-in state mechanisms (@State, @Observable, @Environment, @Binding)
- **Testing:** Swift Testing framework with modern @Test macros and #expect/#require assertions
- **Platform:** iOS (Simulator and Device)
- **Accessibility:** Full accessibility support using SwiftUI's accessibility modifiers

## Project Structure

The project follows a **workspace + SPM package** architecture:

```
YourApp/
├── Config/                         # XCConfig build settings
│   ├── Debug.xcconfig
│   ├── Release.xcconfig
│   ├── Shared.xcconfig
│   └── Tests.xcconfig
├── YourApp.xcworkspace/            # Workspace container
├── YourApp.xcodeproj/              # App shell (minimal wrapper)
├── YourApp/                        # App target - just the entry point
│   ├── Assets.xcassets/
│   ├── YourAppApp.swift           # @main entry point only
│   └── YourApp.xctestplan
├── YourAppPackage/                 # All features and business logic
│   ├── Package.swift
│   ├── Sources/
│   │   └── YourAppFeature/        # Feature modules
│   └── Tests/
│       └── YourAppFeatureTests/   # Swift Testing tests
└── YourAppUITests/                 # UI automation tests
```

**Important:** All development work should be done in the **YourAppPackage** Swift Package, not in the app project. The app project is merely a thin wrapper that imports and launches the package features.

# Code Quality & Style Guidelines

## Swift Style & Conventions

- **Naming:** Use `UpperCamelCase` for types, `lowerCamelCase` for properties/functions. Choose descriptive names (e.g., `calculateMonthlyRevenue()` not `calcRev`)
- **Value Types:** Prefer `struct` for models and data, use `class` only when reference semantics are required
- **Enums:** Leverage Swift's powerful enums with associated values for state representation
- **Early Returns:** Prefer early return pattern over nested conditionals to avoid pyramid of doom

## Optionals & Error Handling

- Use optionals with `if let`/`guard let` for nil handling
- Never force-unwrap (`!`) without absolute certainty - prefer `guard` with failure path
- Use `do/try/catch` for error handling with meaningful error types
- Handle or propagate all errors - no empty catch blocks

# Modern SwiftUI Architecture Guidelines (2025)

### No ViewModels - Use Native SwiftUI Data Flow
**New features MUST follow these patterns:**

1. **Views as Pure State Expressions**
   ```swift
   struct MyView: View {
       @Environment(MyService.self) private var service
       @State private var viewState: ViewState = .loading
       
       enum ViewState {
           case loading
           case loaded(data: [Item])
           case error(String)
       }
       
       var body: some View {
           // View is just a representation of its state
       }
   }
   ```

2. **Use Environment Appropriately**
   - **App-wide services**: Router, Theme, CurrentAccount, Client, etc. - use `@Environment`
   - **Feature-specific services**: Timeline services, single-view logic - use `let` properties with `@Observable`
   - Rule: Environment for cross-app/cross-feature dependencies, let properties for single-feature services
   - Access app-wide via `@Environment(ServiceType.self)`
   - Feature services: `private let myService = MyObservableService()`

3. **Local State Management**
   - Use `@State` for view-specific state
   - Use `enum` for view states (loading, loaded, error)
   - Use `.task(id:)` and `.onChange(of:)` for side effects
   - Pass state between views using `@Binding`

4. **No ViewModels Required**
   - Views should be lightweight and disposable
   - Business logic belongs in services/clients
   - Test services independently, not views
   - Use SwiftUI previews for visual testing

5. **When Views Get Complex**
   - Split into smaller subviews
   - Use compound views that compose smaller views
   - Pass state via bindings between views
   - Never reach for a ViewModel as the solution

# SwiftUI iOS 26 Comprehensive Documentation & Liquid Glass Design System

**Major Release**: SwiftUI iOS 26, released September 15, 2025, introduces the **Liquid Glass design revolution** - the biggest design overhaul since iOS 7. This represents a fundamental rethinking of interface design that automatically transforms apps when recompiled with Xcode 26.

## 🌟 Liquid Glass Design Revolution

Liquid Glass combines the optical properties of glass with fluid motion, creating interfaces that feel both transparent and alive:

### Core Liquid Glass Principles
- **Clarity**: Understandable at a glance with perfect visual hierarchy
- **Deference**: Content remains primary focus, UI enhances without distraction  
- **Depth**: Multi-layered visual depth through sophisticated "Lensing" effects
- **Translucency**: Glass-like materials with realistic light refraction
- **Dynamic Transformation**: Materials adapt contextually to bring focus to content

### Key Liquid Glass Features
- **Dynamic adaptation** to content underneath with real-time refraction and reflection
- **Morphing animations** during navigation transitions where toolbar items seamlessly transform
- **Automatic tinting support** for enhanced visual hierarchy
- **Contextual blur effects** that respond to scrolling behavior
- **Environmental lighting** that mimics real glass interaction with surroundings

## 🆕 Revolutionary SwiftUI iOS 26 Components

### 1. Native WebView Integration
Finally, SwiftUI gets native web capabilities without UIKit wrappers:

```swift
import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "https://example.com"))
    }
}

// Advanced WebView with WebPage class
struct WebBrowserView: View {
    @State private var page = WebPage()
    
    var body: some View {
        NavigationStack {
            WebView(page)
                .navigationTitle(page.title ?? "Loading...")
        }
    }
}
```

### 2. Chart3D - Revolutionary Data Visualization
Full 3D charting capabilities built into SwiftUI:

```swift
// 3D Point Charts
Chart3D(data) { item in
    PointMark(
        x: .value("X Axis", item.xValue),
        y: .value("Y Axis", item.yValue),
        z: .value("Z Axis", item.zValue)
    )
    .foregroundStyle(by: .value("Category", item.category))
}

// Mathematical Surface Plots
Chart3D {
    SurfacePlot(x: "X", y: "Y", z: "Z") { x, z in
        sin(hypot(x, z)) / hypot(x, z)  // Sinc function
    }
    .foregroundStyle(.normalBased)
}
```

### 3. GlassEffectContainer - Cohesive Glass Grouping
Groups multiple glass effects into unified visual systems:

```swift
GlassEffectContainer {
    Button("Home") { /* action */ }
        .glassEffect()
        .glassEffectID("menu", in: namespace)
    
    Button("Settings") { /* action */ }
        .glassEffect()
        .glassEffectID("menu", in: namespace)
}
```

### 4. Enhanced TextEditor with Rich Text
Native rich text editing with AttributedString:

```swift
struct RichEditorView: View {
    @State private var text = AttributedString()
    
    var body: some View {
        TextEditor(text: $text)
            .font(.body)
    }
}
```

## 🔮 Essential Liquid Glass Modifiers

### Glass Effect System
```swift
// Basic glass effect - automatically adapts to content
.glassEffect()

// Advanced customizable glass effect
.glassEffect(.regular.tint(.purple.opacity(0.8)).interactive())

// Shared glass identity for coordinated effects
.glassEffectID("navigation", in: namespace)
```

### Background Extension Effects
Create immersive backgrounds extending beyond view bounds:

```swift
Image("heroImage")
    .resizable()
    .scaledToFill()
    .backgroundExtensionEffect()
```

### Scroll Edge Effects
Customize scroll view edge transitions with glass-like behavior:

```swift
ScrollView {
    LazyVStack {
        // Content with glass-aware scrolling
    }
}
.scrollEdgeEffectStyle(.soft, for: .all)
```

**Available styles:**
- `.automatic` - Platform-specific glass-aware default
- `.hard` - Sharp cutoff with glass dividing line
- `.soft` - Gradual glass-faded transition

### ToolbarSpacer - Precise Glass Layout Control
```swift
.toolbar {
    ToolbarItem(placement: .bottomBar) {
        Button("Search") { /* action */ }
    }
    
    ToolbarSpacer(.flexible, placement: .bottomBar)
    
    ToolbarItem(placement: .bottomBar) {
        Button("New") { /* action */ }
    }
}
```

## 🎨 Animation Revolution: @Animatable Macro

The `@Animatable` macro dramatically simplifies custom shape animations:

```swift
@Animatable
struct LiquidArc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    @AnimatableIgnored var clockwise: Bool  // Won't animate
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        return path
    }
}
```

## 📱 Enhanced Component Capabilities

### Glass Button Styles
```swift
// Revolutionary glass button style
Button("Liquid Action") { /* action */ }
    .buttonStyle(.glass)

// Enhanced bordered prominent with liquid tinting
Button("Primary Action") { /* action */ }
    .buttonStyle(.borderedProminent)
    .tint(.purple)
```

### TabView with Liquid Glass Integration
```swift
TabView {
    Tab("Home", systemImage: "house") {
        HomeView()
    }
    Tab("Settings", systemImage: "gear") {
        SettingsView()
    }
}
.tabBarMinimizeBehavior(.onScrollDown)  // iPhone only
.bottomAccessory {
    // Custom glass accessory content
}
```

### Section Index Navigation with Glass Effects
```swift
List {
    Section {
        ForEach(items) { item in
            Text(item.name)
        }
    }
    .sectionIndexLabel(Text("A"))
    .listSectionMargins(.horizontal, 16)
}
.listSectionIndexVisibility(.visible)
```

### Navigation with Glass Subtitles
```swift
NavigationStack {
    ContentView()
        .navigationTitle("Mindful Therapy")
        .navigationSubtitle("Liquid Glass Interface")
}
```

## 🏗️ Platform-Specific Liquid Glass Features

### iOS-Specific Glass Enhancements
- **Search bars** moved to bottom for better ergonomics with glass effects
- **Tab bars** with new compact glass appearance
- **Toolbar morphing** animations that flow like liquid

### visionOS Spatial Integration  
- **Spatial SwiftUI** layouts with RealityKit glass integration
- **Chart3D** optimized for natural 3D glass interactions
- **Enhanced volumetric** APIs with glass depth effects

## 🔄 Migration Strategy for Liquid Glass

### Automatic Glass Transformations
- **Instant visual transformation** when recompiling with Xcode 26
- **Standard SwiftUI components** automatically adopt Liquid Glass
- **Performance improvements** applied automatically

### Manual Glass Integration Required
- **Custom UI components** need glass effect integration
- **Toolbar customizations** require new API updates  
- **Color schemes** may need adjustment for glass compatibility

### Backward Compatibility with Glass Effects
```swift
// Use availability checks for new glass features
if #available(iOS 26, *) {
    content
        .glassEffect()
        .backgroundExtensionEffect()
        .sectionIndexLabel(Text("A"))
} else {
    content
        .background(.regularMaterial)  // Fallback
}
```

## 🎯 Liquid Glass Best Practices

### Glass Design Guidelines
- **Apply glass effects** to container views for cohesive liquid appearance
- **Use GlassEffectContainer** for grouping related glass elements
- **Consider background content** when applying glass effects for optimal legibility
- **Test across different content types** to ensure glass readability

### Performance with Glass Effects
- **Leverage improved List performance** for large glass datasets
- **Use LazyHStack** for horizontal glass scrolling performance
- **Implement @Animatable macro** for smoother custom glass animations
- **Utilize Chart3D** for immersive glass data visualization

### Glass Accessibility Compliance
- **Glass effects maintain** standard accessibility features automatically
- **Section index labels** improve navigation for assistive technologies with glass
- **Rich text editor** supports all text accessibility APIs through glass

## 💡 iOS 26 Usage Guidelines
- **Target iOS 26+ only** when deployment supports these revolutionary APIs
- **Progressive enhancement** with availability checks for mixed iOS versions
- **Feature detection** testing on older simulators for graceful glass fallbacks  
- **Modern glass aesthetics** leverage Liquid Glass for cutting-edge UI design

```swift
// Example: Progressive Glass Enhancement
struct ModernGlassButton: View {
    var body: some View {
        Button("Liquid Experience") {
            // Enhanced action with glass feedback
        }
        .buttonStyle({
            if #available(iOS 26.0, *) {
                .glass  // Revolutionary glass button
            } else {
                .borderedProminent  // Elegant fallback
            }
        }())
        .modifier({
            if #available(iOS 26.0, *) {
                AnyViewModifier {
                    $0.glassEffect(.interactive)
                      .backgroundExtensionEffect()
                }
            } else {
                AnyViewModifier { $0 }
            }
        }())
    }
}
```

## 🚀 Revolutionary Impact Summary

SwiftUI iOS 26 with **Liquid Glass** represents a quantum leap in iOS interface design and development capabilities. The comprehensive glass design system, combined with powerful new components like native WebView, Chart3D, and enhanced animation tools, provides developers with unprecedented creative possibilities while maintaining SwiftUI's declarative simplicity.

The **automatic glass transformations** upon recompilation, new **interaction paradigms**, and **platform-unified design language** position iOS 26 as the most significant SwiftUI update since the framework's introduction. 

**Priority Implementation**: All new development should integrate Liquid Glass principles through `.glassEffect()`, `GlassEffectContainer`, and the comprehensive glass modifier system to create truly modern, immersive iOS applications that feel both transparent and alive.

## SwiftUI State Management (MV Pattern)

- **@State:** For all state management, including observable model objects
- **@Observable:** Modern macro for making model classes observable (replaces ObservableObject)
- **@Environment:** For dependency injection and shared app state
- **@Binding:** For two-way data flow between parent and child views
- **@Bindable:** For creating bindings to @Observable objects
- Avoid ViewModels - put view logic directly in SwiftUI views using these state mechanisms
- Keep views focused and extract reusable components

Example with @Observable:
```swift
@Observable
class UserSettings {
    var theme: Theme = .light
    var fontSize: Double = 16.0
}

@MainActor
struct SettingsView: View {
    @State private var settings = UserSettings()
    
    var body: some View {
        VStack {
            // Direct property access, no $ prefix needed
            Text("Font Size: \(settings.fontSize)")
            
            // For bindings, use @Bindable
            @Bindable var settings = settings
            Slider(value: $settings.fontSize, in: 10...30)
        }
    }
}

// Sharing state across views
@MainActor
struct ContentView: View {
    @State private var userSettings = UserSettings()
    
    var body: some View {
        NavigationStack {
            MainView()
                .environment(userSettings)
        }
    }
}

@MainActor
struct MainView: View {
    @Environment(UserSettings.self) private var settings
    
    var body: some View {
        Text("Current theme: \(settings.theme)")
    }
}
```

Example with .task modifier for async operations:
```swift
@Observable
class DataModel {
    var items: [Item] = []
    var isLoading = false
    
    func loadData() async throws {
        isLoading = true
        defer { isLoading = false }
        
        // Simulated network call
        try await Task.sleep(for: .seconds(1))
        items = try await fetchItems()
    }
}

@MainActor
struct ItemListView: View {
    @State private var model = DataModel()
    
    var body: some View {
        List(model.items) { item in
            Text(item.name)
        }
        .overlay {
            if model.isLoading {
                ProgressView()
            }
        }
        .task {
            // This task automatically cancels when view disappears
            do {
                try await model.loadData()
            } catch {
                // Handle error
            }
        }
        .refreshable {
            // Pull to refresh also uses async/await
            try? await model.loadData()
        }
    }
}
```

## Concurrency

- **@MainActor:** All UI updates must use @MainActor isolation
- **Actors:** Use actors for expensive operations like disk I/O, network calls, or heavy computation
- **async/await:** Always prefer async functions over completion handlers
- **Task:** Use structured concurrency with proper task cancellation
- **.task modifier:** Always use .task { } on views for async operations tied to view lifecycle - it automatically handles cancellation
- **Avoid Task { } in onAppear:** This doesn't cancel automatically and can cause memory leaks or crashes
- No GCD usage - Swift Concurrency only

### Sendable Conformance

Swift 6 enforces strict concurrency checking. All types that cross concurrency boundaries must be Sendable:

- **Value types (struct, enum):** Usually Sendable if all properties are Sendable
- **Classes:** Must be marked `final` and have immutable or Sendable properties, or use `@unchecked Sendable` with thread-safe implementation
- **@Observable classes:** Automatically Sendable when all properties are Sendable
- **Closures:** Mark as `@Sendable` when captured by concurrent contexts

```swift
// Sendable struct - automatic conformance
struct UserData: Sendable {
    let id: UUID
    let name: String
}

// Sendable class - must be final with immutable properties
final class Configuration: Sendable {
    let apiKey: String
    let endpoint: URL
    
    init(apiKey: String, endpoint: URL) {
        self.apiKey = apiKey
        self.endpoint = endpoint
    }
}

// @Observable with Sendable
@Observable
final class UserModel: Sendable {
    var name: String = ""
    var age: Int = 0
    // Automatically Sendable if all stored properties are Sendable
}

// Using @unchecked Sendable for thread-safe types
final class Cache: @unchecked Sendable {
    private let lock = NSLock()
    private var storage: [String: Any] = [:]
    
    func get(_ key: String) -> Any? {
        lock.withLock { storage[key] }
    }
}

// @Sendable closures
func processInBackground(completion: @Sendable @escaping (Result<Data, Error>) -> Void) {
    Task {
        // Processing...
        completion(.success(data))
    }
}
```

## Code Organization

- Keep functions focused on a single responsibility
- Break large functions (>50 lines) into smaller, testable units
- Use extensions to organize code by feature or protocol conformance
- Prefer `let` over `var` - use immutability by default
- Use `[weak self]` in closures to prevent retain cycles
- Always include `self.` when referring to instance properties in closures

# Testing Guidelines

We use **Swift Testing** framework (not XCTest) for all tests. Tests live in the package test target.

## Swift Testing Basics

```swift
import Testing

@Test func userCanLogin() async throws {
    let service = AuthService()
    let result = try await service.login(username: "test", password: "pass")
    #expect(result.isSuccess)
    #expect(result.user.name == "Test User")
}

@Test("User sees error with invalid credentials")
func invalidLogin() async throws {
    let service = AuthService()
    await #expect(throws: AuthError.self) {
        try await service.login(username: "", password: "")
    }
}
```

## Key Swift Testing Features

- **@Test:** Marks a test function (replaces XCTest's test prefix)
- **@Suite:** Groups related tests together
- **#expect:** Validates conditions (replaces XCTAssert)
- **#require:** Like #expect but stops test execution on failure
- **Parameterized Tests:** Use @Test with arguments for data-driven tests
- **async/await:** Full support for testing async code
- **Traits:** Add metadata like `.bug()`, `.feature()`, or custom tags

## Test Organization

- Write tests in the package's Tests/ directory
- One test file per source file when possible
- Name tests descriptively explaining what they verify
- Test both happy paths and edge cases
- Add tests for bug fixes to prevent regression

# Entitlements Management

This template includes a **declarative entitlements system** that AI agents can safely modify without touching Xcode project files.

## How It Works

- **Entitlements File**: `Config/MindfulTherapy.entitlements` contains all app capabilities
- **XCConfig Integration**: `CODE_SIGN_ENTITLEMENTS` setting in `Config/Shared.xcconfig` points to the entitlements file
- **AI-Friendly**: Agents can edit the XML file directly to add/remove capabilities

## Adding Entitlements

To add capabilities to your app, edit `Config/MindfulTherapy.entitlements`:

## Common Entitlements

| Capability | Entitlement Key | Value |
|------------|-----------------|-------|
| HealthKit | `com.apple.developer.healthkit` | `<true/>` |
| CloudKit | `com.apple.developer.icloud-services` | `<array><string>CloudKit</string></array>` |
| Push Notifications | `aps-environment` | `development` or `production` |
| App Groups | `com.apple.security.application-groups` | `<array><string>group.id</string></array>` |
| Keychain Sharing | `keychain-access-groups` | `<array><string>$(AppIdentifierPrefix)bundle.id</string></array>` |
| Background Modes | `com.apple.developer.background-modes` | `<array><string>mode-name</string></array>` |
| Contacts | `com.apple.developer.contacts.notes` | `<true/>` |
| Camera | `com.apple.developer.avfoundation.audio` | `<true/>` |

# XcodeBuildMCP Tool Usage

To work with this project, build, test, and development commands should use XcodeBuildMCP tools instead of raw command-line calls.

## Project Discovery & Setup

```javascript
// Discover Xcode projects in the workspace
discover_projs({
    workspaceRoot: "/path/to/YourApp"
})

// List available schemes
list_schems_ws({
    workspacePath: "/path/to/YourApp.xcworkspace"
})
```

## Building for Simulator

```javascript
// Build for iPhone simulator by name
build_sim_name_ws({
    workspacePath: "/path/to/YourApp.xcworkspace",
    scheme: "YourApp",
    simulatorName: "iPhone 16",
    configuration: "Debug"
})

// Build and run in one step
build_run_sim_name_ws({
    workspacePath: "/path/to/YourApp.xcworkspace",
    scheme: "YourApp", 
    simulatorName: "iPhone 16"
})
```

## Building for Device

```javascript
// List connected devices first
list_devices()

// Build for physical device
build_dev_ws({
    workspacePath: "/path/to/YourApp.xcworkspace",
    scheme: "YourApp",
    configuration: "Debug"
})
```

## Testing

```javascript
// Run tests on simulator
test_sim_name_ws({
    workspacePath: "/path/to/YourApp.xcworkspace",
    scheme: "YourApp",
    simulatorName: "iPhone 16"
})

// Run tests on device
test_device_ws({
    workspacePath: "/path/to/YourApp.xcworkspace",
    scheme: "YourApp",
    deviceId: "DEVICE_UUID_HERE"
})

// Test Swift Package
swift_package_test({
    packagePath: "/path/to/YourAppPackage"
})
```

## Simulator Management

```javascript
// List available simulators
list_sims({
    enabled: true
})

// Boot simulator
boot_sim({
    simulatorUuid: "SIMULATOR_UUID"
})

// Install app
install_app_sim({
    simulatorUuid: "SIMULATOR_UUID",
    appPath: "/path/to/YourApp.app"
})

// Launch app
launch_app_sim({
    simulatorUuid: "SIMULATOR_UUID",
    bundleId: "com.example.YourApp"
})
```

## Device Management

```javascript
// Install on device
install_app_device({
    deviceId: "DEVICE_UUID",
    appPath: "/path/to/YourApp.app"
})

// Launch on device
launch_app_device({
    deviceId: "DEVICE_UUID",
    bundleId: "com.example.YourApp"
})
```

## UI Automation

```javascript
// Get UI hierarchy
describe_ui({
    simulatorUuid: "SIMULATOR_UUID"
})

// Tap element
tap({
    simulatorUuid: "SIMULATOR_UUID",
    x: 100,
    y: 200
})

// Type text
type_text({
    simulatorUuid: "SIMULATOR_UUID",
    text: "Hello World"
})

// Take screenshot
screenshot({
    simulatorUuid: "SIMULATOR_UUID"
})
```

## Log Capture

```javascript
// Start capturing simulator logs
start_sim_log_cap({
    simulatorUuid: "SIMULATOR_UUID",
    bundleId: "com.example.YourApp"
})

// Stop and retrieve logs
stop_sim_log_cap({
    logSessionId: "SESSION_ID"
})

// Device logs
start_device_log_cap({
    deviceId: "DEVICE_UUID",
    bundleId: "com.example.YourApp"
})
```

## Utility Functions

```javascript
// Get bundle ID from app
get_app_bundle_id({
    appPath: "/path/to/YourApp.app"
})

// Clean build artifacts
clean_ws({
    workspacePath: "/path/to/YourApp.xcworkspace"
})

// Get app path for simulator
get_sim_app_path_name_ws({
    workspacePath: "/path/to/YourApp.xcworkspace",
    scheme: "YourApp",
    platform: "iOS Simulator",
    simulatorName: "iPhone 16"
})
```

# Development Workflow

1. **Make changes in the Package**: All feature development happens in YourAppPackage/Sources/
2. **Write tests**: Add Swift Testing tests in YourAppPackage/Tests/
3. **Build and test**: Use XcodeBuildMCP tools to build and run tests
4. **Run on simulator**: Deploy to simulator for manual testing
5. **UI automation**: Use describe_ui and automation tools for UI testing
6. **Device testing**: Deploy to physical device when needed

# Best Practices

## SwiftUI & State Management

- Keep views small and focused
- Extract reusable components into their own files
- Use @ViewBuilder for conditional view composition
- Leverage SwiftUI's built-in animations and transitions
- Avoid massive body computations - break them down
- **Always use .task modifier** for async work tied to view lifecycle - it automatically cancels when the view disappears
- Never use Task { } in onAppear - use .task instead for proper lifecycle management

## Performance

- Use .id() modifier sparingly as it forces view recreation
- Implement Equatable on models to optimize SwiftUI diffing
- Use LazyVStack/LazyHStack for large lists
- Profile with Instruments when needed
- @Observable tracks only accessed properties, improving performance over @Published

## Accessibility

- Always provide accessibilityLabel for interactive elements
- Use accessibilityIdentifier for UI testing
- Implement accessibilityHint where actions aren't obvious
- Test with VoiceOver enabled
- Support Dynamic Type

## Security & Privacy

- Never log sensitive information
- Use Keychain for credential storage
- All network calls must use HTTPS
- Request minimal permissions
- Follow App Store privacy guidelines

## Data Persistence

When data persistence is required, always prefer **SwiftData** over CoreData. However, carefully consider whether persistence is truly necessary - many apps can function well with in-memory state that loads on launch.

### When to Use SwiftData

- You have complex relational data that needs to persist across app launches
- You need advanced querying capabilities with predicates and sorting
- You're building a data-heavy app (note-taking, inventory, task management)
- You need CloudKit sync with minimal configuration

### When NOT to Use Data Persistence

- Simple user preferences (use UserDefaults)
- Temporary state that can be reloaded from network
- Small configuration data (consider JSON files or plist)
- Apps that primarily display remote data

### SwiftData Best Practices

```swift
import SwiftData

@Model
final class Task {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String) {
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
    }
}

// In your app
@main
struct MindfulTherapyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}

// In your views
struct TaskListView: View {
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List(tasks) { task in
            Text(task.title)
        }
        .toolbar {
            Button("Add") {
                let newTask = Task(title: "New Task")
                context.insert(newTask)
            }
        }
    }
}
```

**Important:** Never use CoreData for new projects. SwiftData provides a modern, type-safe API that's easier to work with and integrates seamlessly with SwiftUI.

---

# 🎯 S-Tier Design Principles Integration (PRIMARY)

**CRITICAL**: All development MUST follow the **S-Tier SaaS Dashboard Design Principles** from `/design-review/design-principles-example.md`:

## Core Philosophy (MANDATORY)
- **Users First**: Prioritize user needs, workflows, and ease of use in every design decision
- **Meticulous Craft**: Aim for precision, polish, and high quality in every UI element
- **Speed & Performance**: Design for fast load times and snappy, responsive interactions  
- **Simplicity & Clarity**: Clean, uncluttered interface with unambiguous information
- **Focus & Efficiency**: Help users achieve goals quickly with minimal friction
- **Consistency**: Uniform design language across entire application
- **Accessibility (WCAG AA+)**: Inclusive design with proper contrast and navigation
- **Opinionated Design**: Clear, efficient defaults reducing decision fatigue

## Design System Foundation Requirements
- **Color Palette**: Defined primary, neutrals (5-7 grays), semantic colors, dark mode
- **Typography**: Clean sans-serif, modular scale, limited weights, generous line height
- **Spacing**: 8px base unit with consistent multiples
- **Border Radii**: Small set of consistent values (4-6px inputs, 8-12px cards)
- **Components**: All with consistent states (default, hover, active, focus, disabled)

## Layout & Hierarchy Requirements
- **Responsive Grid**: 12-column system for consistent layout
- **Strategic White Space**: Ample negative space for clarity
- **Clear Visual Hierarchy**: Typography, spacing, positioning guide user's eye
- **Consistent Alignment**: Maintain alignment across all elements

# 🔮 Subtle Liquid Glass Integration (SECONDARY)

Liquid Glass effects should **enhance** the S-Tier principles, never override them:

## Minimalistic Glass Application
- **Subtle depth only**: Light `.regularMaterial` backgrounds
- **Strategic placement**: Only on container elements, not individual components
- **Content first**: Glass effects must not interfere with readability
- **Performance aware**: Minimal glass usage to maintain speed
- **Accessibility preserved**: All WCAG AA+ requirements maintained through glass

## Development Priorities
1. **S-Tier Principles First** - Users First, Simplicity, Clarity, Performance
2. **SwiftUI Best Practices** - Native state management, accessibility
3. **Subtle Glass Enhancement** - Only when supporting core principles

Remember: This project follows **S-Tier Design Principles FIRST** with subtle Liquid Glass enhancements that support (never override) the core design philosophy. Maintain clean, simple SwiftUI code using native state management. Keep the app shell minimal and implement all features in the Swift Package.

**Always Reference**: `/design-review/design-principles-example.md` for S-Tier design decisions