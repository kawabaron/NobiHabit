import SwiftUI

struct SessionPrepScreen: View {
    var routine: StretchRoutine
    @State private var selectedDuration = "1分30秒"

    private var durationOptions: [String] {
        ["1分", routine.durationText, "2分"]
    }

    var body: some View {
        BackgroundContainer {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.lg) {
                        heroSection
                        summarySection
                        includedStretches
                        timeSection
                    }
                    .screenHorizontalPadding()
                    .padding(.top, AppSpacing.lg)
                    .padding(.bottom, 116)
                }

                bottomCTA
            }
        }
        .navigationTitle(routine.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            selectedDuration = routine.durationText
        }
    }

    private var heroSection: some View {
        IllustrationCard(assetName: routine.heroIllustrationAssetName, height: 220)
            .overlay(alignment: .bottomLeading) {
                MascotInlineHint(
                    variant: .breath,
                    message: "肩の力を抜いて、ゆっくり始めましょう。"
                )
                .padding(AppSpacing.sm)
                .frame(maxWidth: 250)
            }
    }

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(routine.title)
                .font(AppFont.largeTitle)
                .foregroundStyle(AppColor.textPrimary)

            Text(routine.overview)
                .font(AppFont.body)
                .foregroundStyle(AppColor.textSecondary)

            HStack(spacing: AppSpacing.xs) {
                RoutineMetaPill(icon: "clock", text: routine.durationText)
                RoutineMetaPill(icon: "list.bullet", text: "\(displayPoses.count)ポーズ")
                RoutineMetaPill(icon: "leaf", text: routine.difficulty.title)
            }
        }
    }

    private var includedStretches: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "含まれるストレッチ")

            SurfaceCard {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    ForEach(displayPoses.indices, id: \.self) { index in
                        let pose = displayPoses[index]
                        HStack(alignment: .top, spacing: AppSpacing.sm) {
                            Text("\(index + 1)")
                                .font(AppFont.captionStrong)
                                .foregroundStyle(AppColor.textSecondary)
                                .frame(width: 24, height: 24)
                                .background(AppColor.surfaceSageSoft, in: Circle())

                            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                                Text(pose.title)
                                    .font(AppFont.bodyStrong)
                                    .foregroundStyle(AppColor.textPrimary)

                                Text(pose.instruction)
                                    .font(AppFont.caption)
                                    .foregroundStyle(AppColor.textSecondary)
                                    .lineLimit(2)
                            }

                            Spacer()
                        }
                    }
                }
            }
        }
    }

    private var timeSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "時間")
            TimeOptionSegment(options: durationOptions, selected: $selectedDuration)
        }
    }

    private var bottomCTA: some View {
        VStack(spacing: AppSpacing.sm) {
            NavigationLink(value: AppRoute.activeSession(routine)) {
                PrimaryButtonLabel(title: "開始する", systemImage: "play.fill")
            }
            .buttonStyle(.plain)

            Text("無理のない範囲で、気持ちよく伸ばしましょう。")
                .font(AppFont.caption)
                .foregroundStyle(AppColor.textSecondary)
        }
        .screenHorizontalPadding()
        .padding(.top, AppSpacing.sm)
        .padding(.bottom, AppSpacing.lg)
        .background(AppColor.backgroundBase.opacity(0.96))
        .overlay(alignment: .top) {
            Rectangle()
                .fill(AppColor.borderSoft)
                .frame(height: 1)
        }
    }

    private var displayPoses: [StretchPose] {
        routine.poses.isEmpty ? StretchPose.placeholderSet : routine.poses
    }
}

private struct RoutineMetaPill: View {
    var icon: String
    var text: String

    var body: some View {
        Label(text, systemImage: icon)
            .font(AppFont.captionStrong)
            .foregroundStyle(AppColor.textSecondary)
            .padding(.horizontal, AppSpacing.sm)
            .padding(.vertical, AppSpacing.xs)
            .background(AppColor.surfacePrimary, in: Capsule())
            .overlay(Capsule().stroke(AppColor.borderSoft, lineWidth: 1))
    }
}

#Preview {
    NavigationStack {
        SessionPrepScreen(routine: MockRoutines.neckRefresh)
    }
}
