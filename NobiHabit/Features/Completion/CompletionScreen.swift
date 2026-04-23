import SwiftUI

struct CompletionScreen: View {
    var routine: StretchRoutine

    @Environment(\.returnHome) private var returnHome
    @State private var selectedMood: MoodOption?

    private let stats = MockData.userStats
    private let tomorrowRecommendation = MockRoutines.backReset

    var body: some View {
        AppScaffold(showsDecor: true) {
            completionHero
                .padding(.top, AppSpacing.xl)
            summaryStats
            moodSection
            tomorrowSection
            homeButton
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }

    private var completionHero: some View {
        SurfaceCard(style: .hero, padding: AppSpacing.cardHero) {
            VStack(spacing: AppSpacing.md) {
                MascotBadge(variant: .celebrate, size: 76)

                VStack(spacing: AppSpacing.xs) {
                    Text("おつかれさまでした！")
                        .font(AppFont.largeTitle)
                        .foregroundStyle(AppColor.textPrimary)
                        .multilineTextAlignment(.center)

                    Text("\(routine.title) を完了しました")
                        .font(AppFont.body)
                        .foregroundStyle(AppColor.textSecondary)
                        .multilineTextAlignment(.center)
                }

                HStack(spacing: AppSpacing.xs) {
                    CompletionMetric(title: "時間", value: routine.durationText)
                    CompletionMetric(title: "完了ポーズ", value: "\(displayPoseCount) / \(displayPoseCount)")
                    CompletionMetric(title: "消費カロリー", value: "12 kcal")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var summaryStats: some View {
        HStack(spacing: AppSpacing.xs) {
            StatCard(title: "連続日数", value: "\(stats.currentStreakDays)", unit: "日")
            StatCard(title: "週の回数", value: "\(stats.weeklySessions)", unit: "回")
            StatCard(title: "合計時間", value: "\(stats.totalMinutes / 60)h \(stats.totalMinutes % 60)m", unit: "")
        }
    }

    private var moodSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "気分を記録", subtitle: "いまの体の感じはどうですか？")

            HStack(spacing: AppSpacing.xs) {
                ForEach(MoodOption.allCases) { option in
                    MoodOptionChip(option: option, isSelected: selectedMood == option) {
                        selectedMood = option
                    }
                }
            }
        }
    }

    private var tomorrowSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "明日のおすすめ")

            RoutineCard(routine: tomorrowRecommendation, badge: "明日")
        }
    }

    private var homeButton: some View {
        VStack(spacing: AppSpacing.sm) {
            PrimaryButton(title: "ホームに戻る", systemImage: "house.fill") {
                returnHome()
            }

            Text("明日も、少しだけ整えましょう。")
                .font(AppFont.caption)
                .foregroundStyle(AppColor.textSecondary)
        }
    }

    private var displayPoseCount: Int {
        routine.poses.isEmpty ? StretchPose.placeholderSet.count : routine.poses.count
    }
}

private struct CompletionMetric: View {
    var title: String
    var value: String

    var body: some View {
        VStack(spacing: AppSpacing.xxs) {
            Text(title)
                .font(AppFont.caption)
                .foregroundStyle(AppColor.textSecondary)

            Text(value)
                .font(AppFont.captionStrong)
                .foregroundStyle(AppColor.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.sm)
        .background(AppColor.backgroundElevated, in: RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous)
                .stroke(AppColor.borderSoft, lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    NavigationStack {
        CompletionScreen(routine: MockRoutines.neckRefresh)
    }
}
