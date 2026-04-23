import SwiftUI

struct RecordPlaceholderScreen: View {
    var body: some View {
        AppScaffold(title: "記録", subtitle: "続けた時間を、静かに振り返る場所です。") {
            SurfaceCard(style: .hero, padding: AppSpacing.cardHero) {
                VStack(spacing: AppSpacing.md) {
                    MascotBadge(variant: .celebrate, size: 72)

                    Text("記録画面は仮置きです")
                        .font(AppFont.cardTitle)
                        .foregroundStyle(AppColor.textPrimary)

                    Text("まずはホーム、メニュー、セッションの流れを整えてから、カレンダーや週次のふり返りを追加します。")
                        .font(AppFont.body)
                        .foregroundStyle(AppColor.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    RecordPlaceholderScreen()
}
