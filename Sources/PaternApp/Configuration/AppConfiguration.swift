import Foundation
import PaternAnalysis

// MARK: - App Configuration

/// Centralized configuration management for the PatternWise app.
/// Uses environment-based settings for development vs production.
public final class AppConfiguration: ObservableObject, @unchecked Sendable {
    
    public static let shared = AppConfiguration()
    
    // MARK: - Environment
    
    public enum Environment: String {
        case development
        case staging
        case production
        
        public static var current: Environment {
            #if DEBUG
            return .development
            #else
            if Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
                return .staging
            }
            return .production
            #endif
        }
    }
    
    public let environment = Environment.current
    
    // MARK: - Backend Configuration
    
    /// Supabase project reference (from environment or Info.plist)
    public var supabaseProjectRef: String {
        ProcessInfo.processInfo.environment["SUPABASE_PROJECT_REF"] 
            ?? Bundle.main.object(forInfoDictionaryKey: "SUPABASE_PROJECT_REF") as? String
            ?? "nycqnqcpwjecjzubxzsk"
    }
    
    /// Supabase anon key (safe to embed - has RLS restrictions)
    public var supabaseAnonKey: String {
        ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"]
            ?? Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String
            ?? "sb_publishable_XtapI3vn_RhZ5ClK0iTRIQ_tvT_4rIX"
    }
    
    /// Backend proxy configuration
    public var backendProxyConfig: BackendProxyConfig {
        switch environment {
        case .development:
            // Use local Supabase in development
            return BackendProxyConfig.local()
        case .staging, .production:
            return BackendProxyConfig.production(
                projectRef: supabaseProjectRef,
                anonKey: supabaseAnonKey
            )
        }
    }
    
    // MARK: - Feature Flags
    
    /// Use backend proxy (OpenRouter via Supabase)
    /// Always enabled - we use OpenRouter (DeepSeek V3) via backend proxy for security
    public var useBackendProxy: Bool {
        // Always use backend proxy for security and rate limiting
        return true
    }
    
    /// Enable offline mode for testing without network
    public var offlineModeEnabled: Bool {
        ProcessInfo.processInfo.environment["OFFLINE_MODE"] == "true"
    }
    
    /// Enable mock LLM responses for development
    /// Default: true in development
    public var useMockLLM: Bool {
        if let override = ProcessInfo.processInfo.environment["USE_MOCK_LLM"] {
            return override == "true"
        }
        // Default to mock in development, real in production
        return environment == .development
    }
    
    /// Enable enhanced logging
    public var verboseLogging: Bool {
        environment == .development
    }
    
    // MARK: - Privacy Settings
    
    /// Minimum data for analysis (days of data required)
    public var minimumDataDaysForAnalysis: Int { 3 }
    
    /// Maximum events to include in a single analysis request
    public var maxEventsPerAnalysis: Int { 20 }
    
    /// Days of data to include in analysis
    public var analysisWindowDays: Int { 14 }
    
    // MARK: - Subscription
    
    /// App Store product identifiers
    public var subscriptionProductIds: [String] {
        [
            "com.patternwise.basic.monthly",
            "com.patternwise.basic.yearly",
            "com.patternwise.pro.monthly",
            "com.patternwise.pro.yearly"
        ]
    }
    
    // MARK: - Support
    
    public var supportEmail: String { "support@patternwise.app" }
    public var privacyPolicyURL: URL { URL(string: "https://rdvnrsln.github.io/Patern/privacy.html")! }
    public var termsOfServiceURL: URL { URL(string: "https://rdvnrsln.github.io/Patern/terms.html")! }
    
    // MARK: - Analytics (future)
    
    public var analyticsEnabled: Bool {
        environment == .production
    }
    
    // MARK: - Initialization
    
    private init() {
        if verboseLogging {
            print("[AppConfiguration] Environment: \(environment.rawValue)")
            print("[AppConfiguration] Backend proxy: \(useBackendProxy)")
        }
    }
}

// MARK: - LLM Client Factory

extension AppConfiguration {
    
    /// Creates the appropriate LLM client based on configuration
    /// Always uses BackendProxyClient which calls OpenRouter (DeepSeek V3)
    @MainActor
    public func createLLMClient() -> any LLMClient {
        if useMockLLM {
            return MockLLMClient()
        }
        
        // Always use backend proxy (OpenRouter via Supabase)
        return BackendProxyClient(config: backendProxyConfig)
    }
}

