import SwiftUI

struct HomeScreen: View {
    @State private var selectedBodyPart: BodyPart = .neckShoulders

    private let stats = MockData.userStats
    private let recommendation = MockData.recommendation
    private let continueSession = MockData.continueSession

    var body: some View {
        AppScaffold {
            greetingHeader
            statsRow
            todayRecommendation
            bodyPartSection
            continueSection
        }
    }

    private var greetingHeader: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text("おはようございます、")
                    .font(AppFont.bodyStrong)
                    .foregroundStyle(AppColor.textPrimary)

                Text(recommendation.reasonText)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.textSecondary)
            }

            Spacer()

            Button {
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: AppIconSize.lg, weight: .medium))
                    .foregroundStyle(AppColor.textSecondary)
                    .frame(width: 44, height: 44)
                    .background(AppColor.surfacePrimary, in: Circle())
                    .overlay(Circle().stroke(AppColor.borderSoft, lineWidth: 1))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("通知")
        }
    }

    private var statsRow: some View {
        HStack(spacing: AppSpacing.xs) {
            StatCard(title: "連続日数", value: "\(stats.currentStreakDays)", unit: "日")
            StatCard(title: "週の回数", value: "\(stats.weeklySessions)", unit: "回")
            StatCard(title: "合計時間", value: "\(stats.totalMinutes / 60)h \(stats.totalMinutes % 60)m", unit: "")
        }
    }

    private var todayRecommendation: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "今日のおすすめ")

            SurfaceCard(style: .hero, padding: AppSpacing.cardHero) {
                VStack(spacing: AppSpacing.md) {
                    HStack(alignment: .center, spacing: AppSpacing.md) {
                        IllustrationCard(assetName: recommendation.routine.thumbnailAssetName, height: 112)
                            .frame(width: 118)

                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            HStack(alignment: .top) {
                                Text(recommendation.routine.title)
                                    .font(AppFont.cardTitle)
                                    .foregroundStyle(AppColor.textPrimary)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.86)

                                Spacer()
                                MascotBadge(variant: recommendation.mascotVariant, size: 38)
                            }

                            Text(recommendation.routine.durationText)
                                .font(AppFont.captionStrong)
                                .foregroundStyle(AppColor.textSecondary)

                            Text(recommendation.routine.subtitle)
                                .font(AppFont.caption)
                                .foregroundStyle(AppColor.textSecondary)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    NavigationLink(value: AppRoute.sessionPrep(recommendation.routine)) {
                        PrimaryButtonLabel(title: "開始する", systemImage: nil)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var bodyPartSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "部位から選ぶ")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.xs) {
                    ForEach(BodyPart.allCases) { bodyPart in
                        BodyPartChip(bodyPart: bodyPart, isSelected: selectedBodyPart == bodyPart) {
                            selectedBodyPart = bodyPart
                        }
                    }
                }
                .padding(.vertical, 1)
            }
        }
    }

    private var continueSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "続きから")

            NavigationLink(value: AppRoute.sessionPrep(continueSession.routine)) {
                RoutineCard(
                    routine: continueSession.routine,
                    badge: "途中まで",
                    isInProgress: true,
                    showsMascot: true
                )
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    HomeScreen()
}
