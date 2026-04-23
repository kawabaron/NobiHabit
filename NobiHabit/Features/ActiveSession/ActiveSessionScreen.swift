import SwiftUI
import Foundation

struct ActiveSessionScreen: View {
    var routine: StretchRoutine

    @Environment(\.dismiss) private var dismiss
    @State private var currentPoseIndex = 0
    @State private var isPaused = false

    private var poses: [StretchPose] {
        routine.poses.isEmpty ? StretchPose.placeholderSet : routine.poses
    }

    private var currentPose: StretchPose {
        poses[min(currentPoseIndex, poses.count - 1)]
    }

    private var nextPose: StretchPose? {
        let nextIndex = currentPoseIndex + 1
        return poses.indices.contains(nextIndex) ? poses[nextIndex] : nil
    }

    private var progress: Double {
        Double(currentPoseIndex + 1) / Double(max(poses.count, 1))
    }

    var body: some View {
        BackgroundContainer {
            VStack(spacing: AppSpacing.lg) {
                header
                Spacer(minLength: AppSpacing.xs)
                mainIllustration
                timerSection
                breathingHint
                nextStretchSection
                Spacer(minLength: AppSpacing.xs)
                controls
            }
            .screenHorizontalPadding()
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.lg)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: AppIconSize.md, weight: .semibold))
                    .foregroundStyle(AppColor.textPrimary)
                    .frame(width: 44, height: 44)
                    .background(AppColor.surfacePrimary, in: Circle())
                    .overlay(Circle().stroke(AppColor.borderSoft, lineWidth: 1))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("セッションを閉じる")

            Spacer()

            VStack(spacing: AppSpacing.xxs) {
                Text(currentPose.title)
                    .font(AppFont.screenTitle)
                    .foregroundStyle(AppColor.textPrimary)

                Text("\(currentPoseIndex + 1) / \(poses.count)")
                    .font(AppFont.captionStrong)
                    .foregroundStyle(AppColor.textSecondary)
            }

            Spacer()

            Button {
            } label: {
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: AppIconSize.md, weight: .medium))
                    .foregroundStyle(AppColor.textSecondary)
                    .frame(width: 44, height: 44)
                    .background(AppColor.surfacePrimary, in: Circle())
                    .overlay(Circle().stroke(AppColor.borderSoft, lineWidth: 1))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("サウンド")
        }
    }

    private var mainIllustration: some View {
        IllustrationCard(assetName: currentPose.illustrationAssetName, height: 270)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundStyle(AppColor.success.opacity(0.65))
                    .padding(AppSpacing.lg)
            }
    }

    private var timerSection: some View {
        ProgressRing(progress: progress, lineWidth: 8) {
            TimerView(
                remainingText: isPaused ? "一時停止" : timeText(seconds: currentPose.durationSeconds),
                caption: "残り時間"
            )
        }
        .frame(width: 148, height: 148)
        .accessibilityLabel("残り時間 \(currentPose.durationSeconds) 秒")
    }

    private var breathingHint: some View {
        MascotInlineHint(
            variant: .breath,
            message: currentPose.breathingCue
        )
    }

    private var nextStretchSection: some View {
        SurfaceCard(style: .standard, padding: AppSpacing.sm) {
            HStack(spacing: AppSpacing.sm) {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("次のストレッチ")
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textTertiary)

                    Text(nextPose?.title ?? "最後のストレッチです")
                        .font(AppFont.bodyStrong)
                        .foregroundStyle(AppColor.textPrimary)
                }

                Spacer()

                if nextPose == nil {
                    MascotBadge(variant: .celebrate, size: 42)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColor.textTertiary)
                }
            }
        }
    }

    private var controls: some View {
        HStack(spacing: AppSpacing.sm) {
            SecondaryButton(title: isPaused ? "再開する" : "一時停止", systemImage: isPaused ? "play.fill" : "pause.fill") {
                isPaused.toggle()
            }

            SecondaryButton(title: nextPose == nil ? "完了へ" : "スキップ", systemImage: "forward.fill") {
                if nextPose == nil {
                    dismiss()
                } else {
                    currentPoseIndex += 1
                    isPaused = false
                }
            }
        }
    }

    private func timeText(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview("Active") {
    NavigationStack {
        ActiveSessionScreen(routine: MockRoutines.neckRefresh)
    }
}

#Preview("Premium Empty Poses") {
    NavigationStack {
        ActiveSessionScreen(routine: MockRoutines.sleepStretch)
    }
}
