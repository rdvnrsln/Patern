import SwiftUI
import StoreKit
import PaternAnalysis

struct PaywallView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @StateObject private var subscriptionManager = SubscriptionManager.shared
    
    @State private var selectedPlan: PaywallPlan = .pro
    @State private var billingPeriod: BillingPeriod = .yearly
    @State private var isPurchasing = false
    
    private var theme: AppTheme.Colors {
        colorScheme == .dark ? .dark : .light
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: AppTheme.Spacing.xl) {
                        headerSection
                        planSelector
                        billingToggle
                        featuresComparison
                        purchaseButton
                        legalLinks
                    }
                    .padding()
                }
            }
            .navigationTitle("Upgrade")
            .navigationBarTitleDisplayModeCompat(NavigationTitleDisplayMode.inlineCompat)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundColor(theme.accent)
                }
            }
        }
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: "sparkles")
                .font(.system(size: 48))
                .foregroundColor(theme.accent)
            
            Text("Unlock Full Potential")
                .font(AppTheme.Typography.title2)
                .foregroundColor(theme.text)
            
            Text("Get deeper insights and more analyses to support your child's development")
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(theme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top)
    }
    
    // MARK: - Plan Selector
    
    private var planSelector: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            PlanCard(
                plan: .basic,
                isSelected: selectedPlan == .basic,
                theme: theme
            ) {
                selectedPlan = .basic
            }
            
            PlanCard(
                plan: .pro,
                isSelected: selectedPlan == .pro,
                theme: theme,
                badge: "Popular"
            ) {
                selectedPlan = .pro
            }
        }
    }
    
    // MARK: - Billing Toggle
    
    private var billingToggle: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            HStack {
                Text("Monthly")
                    .font(AppTheme.Typography.subheadline)
                    .foregroundColor(billingPeriod == .monthly ? theme.text : theme.textTertiary)
                
                Toggle("", isOn: Binding(
                    get: { billingPeriod == .yearly },
                    set: { billingPeriod = $0 ? .yearly : .monthly }
                ))
                .toggleStyle(SwitchToggleStyle(tint: theme.accent))
                .labelsHidden()
                
                Text("Yearly")
                    .font(AppTheme.Typography.subheadline)
                    .foregroundColor(billingPeriod == .yearly ? theme.text : theme.textTertiary)
                
                if billingPeriod == .yearly {
                    Text("Save 17%")
                        .font(AppTheme.Typography.caption1.weight(.bold))
                        .foregroundColor(theme.success)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(theme.success.opacity(0.15))
                        .cornerRadius(8)
                }
            }
            
            Text(priceText)
                .font(AppTheme.Typography.title2)
                .foregroundColor(theme.text)
        }
        .padding()
        .background(theme.cardBackground)
        .cornerRadius(AppTheme.Radius.lg)
    }
    
    private var priceText: String {
        switch (selectedPlan, billingPeriod) {
        case (.basic, .monthly):
            return "$4.99/month"
        case (.basic, .yearly):
            return "$49.99/year"
        case (.pro, .monthly):
            return "$9.99/month"
        case (.pro, .yearly):
            return "$99.99/year"
        }
    }
    
    // MARK: - Features Comparison
    
    private var featuresComparison: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("What's Included")
                .font(AppTheme.Typography.headline)
                .foregroundColor(theme.text)
            
            FeatureRow(
                feature: "Weekly Analyses",
                free: "1",
                basic: "3",
                pro: "7",
                selectedPlan: selectedPlan,
                theme: theme
            )
            
            FeatureRow(
                feature: "Analysis Types",
                free: "2",
                basic: "3",
                pro: "All 8",
                selectedPlan: selectedPlan,
                theme: theme
            )
            
            FeatureRow(
                feature: "Evidence Depth",
                free: "Basic",
                basic: "Standard",
                pro: "Deep",
                selectedPlan: selectedPlan,
                theme: theme
            )
            
            FeatureRow(
                feature: "History",
                free: "7 days",
                basic: "30 days",
                pro: "90 days",
                selectedPlan: selectedPlan,
                theme: theme
            )
            
            FeatureRow(
                feature: "Export Data",
                free: "—",
                basic: "—",
                pro: "✓",
                selectedPlan: selectedPlan,
                theme: theme
            )
        }
        .padding()
        .background(theme.cardBackground)
        .cornerRadius(AppTheme.Radius.lg)
    }
    
    // MARK: - Purchase Button
    
    private var purchaseButton: some View {
        Button(action: purchase) {
            HStack {
                if isPurchasing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                Text(isPurchasing ? "Processing..." : "Subscribe Now")
            }
            .font(AppTheme.Typography.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(theme.accent)
            .cornerRadius(AppTheme.Radius.md)
        }
        .disabled(isPurchasing)
    }
    
    // MARK: - Legal Links
    
    private var legalLinks: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Button("Restore Purchases") {
                Task {
                    await subscriptionManager.restorePurchases()
                }
            }
            .font(AppTheme.Typography.subheadline)
            .foregroundColor(theme.accent)
            
            HStack(spacing: AppTheme.Spacing.md) {
                Link("Terms of Use", destination: URL(string: "https://rdvnrsln.github.io/Patern/terms.html")!)
                Text("•")
                Link("Privacy Policy", destination: URL(string: "https://rdvnrsln.github.io/Patern/privacy.html")!)
            }
            .font(AppTheme.Typography.caption1)
            .foregroundColor(theme.textTertiary)
            
            Text("Subscriptions auto-renew unless cancelled at least 24 hours before the end of the current period.")
                .font(AppTheme.Typography.caption2)
                .foregroundColor(theme.textTertiary)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Actions
    
    private func purchase() {
        isPurchasing = true
        
        let product: Product?
        switch (selectedPlan, billingPeriod) {
        case (.basic, .monthly):
            product = subscriptionManager.basicMonthlyProduct
        case (.basic, .yearly):
            product = subscriptionManager.basicYearlyProduct
        case (.pro, .monthly):
            product = subscriptionManager.proMonthlyProduct
        case (.pro, .yearly):
            product = subscriptionManager.proYearlyProduct
        }
        
        guard let product = product else {
            isPurchasing = false
            return
        }
        
        Task {
            do {
                _ = try await subscriptionManager.purchase(product)
                dismiss()
            } catch {
                print("Purchase error: \(error)")
            }
            isPurchasing = false
        }
    }
}

// MARK: - Plan Card

struct PlanCard: View {
    let plan: PaywallPlan
    let isSelected: Bool
    let theme: AppTheme.Colors
    var badge: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: AppTheme.Spacing.sm) {
                if let badge = badge {
                    Text(badge)
                        .font(AppTheme.Typography.caption2.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(theme.accent)
                        .cornerRadius(8)
                }
                
                Text(plan.displayName)
                    .font(AppTheme.Typography.headline)
                    .foregroundColor(isSelected ? theme.accent : theme.text)
                
                Text(plan.tagline)
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(theme.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(theme.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Radius.lg)
                    .stroke(isSelected ? theme.accent : Color.clear, lineWidth: 2)
            )
            .cornerRadius(AppTheme.Radius.lg)
        }
    }
}

// MARK: - Feature Row

struct FeatureRow: View {
    let feature: String
    let free: String
    let basic: String
    let pro: String
    let selectedPlan: PaywallPlan
    let theme: AppTheme.Colors
    
    var body: some View {
        HStack {
            Text(feature)
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(theme.text)
            
            Spacer()
            
            Text(selectedValue)
                .font(AppTheme.Typography.subheadline.weight(.semibold))
                .foregroundColor(theme.accent)
        }
        .padding(.vertical, 4)
    }
    
    private var selectedValue: String {
        switch selectedPlan {
        case .basic: return basic
        case .pro: return pro
        }
    }
}

// MARK: - Types

enum PaywallPlan {
    case basic
    case pro
    
    var displayName: String {
        switch self {
        case .basic: return "Basic"
        case .pro: return "Pro"
        }
    }
    
    var tagline: String {
        switch self {
        case .basic: return "Essential insights"
        case .pro: return "Full analysis power"
        }
    }
}

enum BillingPeriod {
    case monthly
    case yearly
}

#Preview {
    PaywallView()
}

