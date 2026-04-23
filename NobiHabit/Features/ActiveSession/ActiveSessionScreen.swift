import SwiftUI
import Foundation

struct ActiveSessionScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.navigate) private var navigate

    private let routine: StretchRoutine

    @State private var currentPoseIndex = 0
    @State private var remainingSeconds: Int
    @State private var isPaused = false
    @State private var hasCompleted = false

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

    private var poseProgress: Double {
        guard currentPose.durationSeconds > 0 else { return 1 }
        return Double(remainingSeconds) / Double(currentPose.durationSeconds)
    }

    var body: some View {
        BackgroundContainer {
            VStack(spacing: AppSpacing.md) {
                ActiveSessionHeader(
                    title: currentPose.title,
                    stepText: "\(currentPoseIndex + 1) / \(poses.count)",
                    onClose: { dismiss() }
                )
                Spacer(minLength: 0)
                ActiveSessionIllustration(assetName: currentPose.illustrationAssetName)
                ActiveSessionTimer(
                    remainingSeconds: remainingSeconds,
                    isPaused: isPaused,
                    progress: poseProgress
                )
                MascotInlineHint(variant: .breath, message: currentPose.breathingCue)
                ActiveSessionNextCard(nextPoseTitle: nextPose?.title)
                Spacer(minLength: 0)
                ActiveSessionControls(
                    isPaused: isPaused,
                    isFinalPose: nextPose == nil,
                    onTogglePause: togglePause,
                    onSkip: advanceToNextPose,
                    onComplete: completeSession
                )
            }
            .screenHorizontalPadding()
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.lg)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .task(id: timerTaskID) {
            await runCountdown()
        }
        .onChange(of: currentPoseIndex) { _, _ in
            resetTimerForCurrentPose()
        }
    }

    private var timerTaskID: String {
        "\(currentPose.id)-\(isPaused)-\(hasCompleted)"
    }

    init(routine: StretchRoutine) {
        self.routine = routine
        let initialPoses = routine.poses.isEmpty ? StretchPose.placeholderSet : routine.poses
        _remainingSeconds = State(initialValue: initialPoses.first?.durationSeconds ?? 0)
    }

    @MainActor
    private func runCountdown() async {
        guard !isPaused, !hasCompleted, remainingSeconds > 0 else { return }

        while !Task.isCancelled, !isPaused, !hasCompleted, remainingSeconds > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            guard !Task.isCancelled, !isPaused, !hasCompleted else { return }
            remainingSeconds -= 1
        }

        guard !Task.isCancelled, !isPaused, !hasCompleted, remainingSeconds == 0 else { return }

        if nextPose == nil {
            completeSession()
        } else {
            advanceToNextPose()
        }
    }

    private func resetTimerForCurrentPose() {
        remainingSeconds = currentPose.durationSeconds
    }

    private func advanceToNextPose() {
        guard nextPose != nil else {
            completeSession()
            return
        }

        currentPoseIndex += 1
        isPaused = false
    }

    private func togglePause() {
        isPaused.toggle()
    }

    private func completeSession() {
        isPaused = true
        hasCompleted = true
        navigate(.completion(routine))
    }
}

private struct ActiveSessionHeader: View {
    var title: String
    var stepText: String
    var onClose: () -> Void

    var body: some View {
        HStack {
            Button(action: onClose) {
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
                Text(title)
                    .font(AppFont.screenTitle)
                    .foregroundStyle(AppColor.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)

                Text(stepText)
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
}

private struct ActiveSessionIllustration: View {
    var assetName: String?

    var body: some View {
        IllustrationCard(assetName: assetName, height: 270)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundStyle(AppColor.success.opacity(0.65))
                    .padding(AppSpacing.lg)
            }
    }
}

private struct ActiveSessionTimer: View {
    var remainingSeconds: Int
    var isPaused: Bool
    var progress: Double

    var body: some View {
        ProgressRing(progress: progress, lineWidth: 7) {
            TimerView(
                remainingText: isPaused ? "一時停止" : timeText(seconds: remainingSeconds),
                caption: "残り時間"
            )
        }
        .frame(width: 148, height: 148)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isPaused ? "一時停止中" : "残り時間 \(remainingSeconds) 秒")
    }

    private func timeText(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

private struct ActiveSessionNextCard: View {
    var nextPoseTitle: String?

    var body: some View {
        SurfaceCard(style: .standard, padding: AppSpacing.sm) {
            HStack(spacing: AppSpacing.sm) {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("次のストレッチ")
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textTertiary)

                    Text(nextPoseTitle ?? "最後のストレッチです")
                        .font(AppFont.bodyStrong)
                        .foregroundStyle(AppColor.textPrimary)
                }

                Spacer()

                if nextPoseTitle == nil {
                    MascotBadge(variant: .celebrate, size: 42)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColor.textTertiary)
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
}

private struct ActiveSessionControls: View {
    var isPaused: Bool
    var isFinalPose: Bool
    var onTogglePause: () -> Void
    var onSkip: () -> Void
    var onComplete: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            SecondaryButton(
                title: isPaused ? "再開する" : "一時停止",
                systemImage: isPaused ? "play.fill" : "pause.fill",
                action: onTogglePause
            )

            if isFinalPose {
                SecondaryButton(title: "完了へ", systemImage: "checkmark", action: onComplete)
            } else {
                SecondaryButton(title: "スキップ", systemImage: "forward.fill", action: onSkip)
            }
        }
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
