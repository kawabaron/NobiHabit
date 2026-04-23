import SwiftUI

struct SettingsScreen: View {
    @State private var isReminderEnabled = MockData.reminderSettings.isReminderEnabled
    @State private var isSoundEnabled = MockData.reminderSettings.isSoundEnabled
    @State private var isHapticsEnabled = MockData.reminderSettings.isHapticsEnabled

    private let settings = MockData.reminderSettings
    private let premium = MockData.premium

    var body: some View {
        AppScaffold(title: "設定") {
            notificationSection
            soundSection
            otherSection
            premiumSection
        }
    }

    private var notificationSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "通知")

            SurfaceCard(padding: AppSpacing.cardCompact) {
                VStack(spacing: 0) {
                    SettingRow(icon: "clock", title: "リマインダー時刻", accessory: .navigationValue(settings.reminderTimeText))
                    Divider().background(AppColor.borderSoft)
                    SettingRow(icon: "bell", title: "通知を許可", accessory: .toggle($isReminderEnabled))
                }
            }
        }
    }

    private var soundSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "サウンド・触覚")

            SurfaceCard(padding: AppSpacing.cardCompact) {
                VStack(spacing: 0) {
                    SettingRow(icon: "speaker.wave.2", title: "サウンド", accessory: .toggle($isSoundEnabled))
                    Divider().background(AppColor.borderSoft)
                    SettingRow(icon: "hand.tap", title: "バイブ", accessory: .toggle($isHapticsEnabled))
                }
            }
        }
    }

    private var otherSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "その他")

            SurfaceCard(padding: AppSpacing.cardCompact) {
                VStack(spacing: 0) {
                    SettingRow(icon: "heart.text.square", title: "ヘルスケア連携", accessory: .navigation)
                    Divider().background(AppColor.borderSoft)
                    SettingRow(icon: "square.and.arrow.up", title: "データのエクスポート", accessory: .navigation)
                    Divider().background(AppColor.borderSoft)
                    SettingRow(icon: "info.circle", title: "アプリについて", accessory: .navigation)
                }
            }
        }
    }

    private var premiumSection: some View {
        PremiumUpsellCard(
            headline: "プレミアム",
            bodyText: "もっと自分を大切にする時間を、静かに広げます。",
            bullets: premium.featureHighlights,
            ctaTitle: "詳しく見る"
        ) {
        }
    }
}

#Preview {
    SettingsScreen()
}
