import SwiftUI
import Foundation

struct ActiveSessionScreen: View {
    var routine: StretchRoutine

    @Environment(\.dismiss) private var dismiss
    @State private var currentPoseIndex = 0
    @State private var remainingSeconds: Int
    @State private var isPaused = false
    @State private var showsCompletion = false

    init(routine: StretchRoutine) {
        self.routine = routine
        let initialPoses = routine.poses.isEmpty ? StretchPose.placeholderSet : routine.poses
        _remainingSeconds = State(initialValue: initialPoses.first?.durationSeconds ?? 0)
    }

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
        let elapsed = currentPose.durationSeconds - remainingSeconds
        return Double(elapsed) / Double(currentPose.durationSeconds)
    }

    private var timerTaskID: String {
        "\(currentPose.id)-\(isPaused)-\(showsCompletion)"
    }

    var body: some View {
        BackgroundContainer {
            VStack(spacing: AppSpacing.md) {
                header
                Spacer(minLength: 0)
                mainIllustration
                timerSection
                breathingHint
                nextStretchSection
                Spacer(minLength: 0)
                controls
            }
            .screenHorizontalPadding()
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.lg)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $showsCompletion) {
            CompletionScreen(routine: routine)
        }
        .task(id: timerTaskID) {
            await runCountdown()
        }
        .onChange(of: currentPoseIndex) { _, _ in
            resetTimerForCurrentPose()
        }
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
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)

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
        ProgressRing(progress: poseProgress, lineWidth: 8) {
            TimerView(
                remainingText: isPaused ? "一時停止" : timeText(seconds: remainingSeconds),
                caption: "残り時間"
            )
        }
        .frame(width: 148, height: 148)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isPaused ? "一時停止中" : "残り時間 \(remainingSeconds) 秒")
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
        .accessibilityElement(children: .combine)
    }

    private var controls: some View {
        HStack(spacing: AppSpacing.sm) {
            SecondaryButton(title: isPaused ? "再開する" : "一時停止", systemImage: isPaused ? "play.fill" : "pause.fill") {
                isPaused.toggle()
            }

            if nextPose == nil {
                SecondaryButton(title: "完了へ", systemImage: "checkmark") {
                    completeSession()
                }
            } else {
                SecondaryButton(title: "スキップ", systemImage: "forward.fill") {
                    advanceToNextPose()
                }
            }
        }
    }

    private func timeText(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    @MainActor
    private func runCountdown() async {
        guard !isPaused, !showsCompletion, remainingSeconds > 0 else { return }

        while !Task.isCancelled, !isPaused, !showsCompletion, remainingSeconds > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            guard !Task.isCancelled, !isPaused, !showsCompletion else { return }
            remainingSeconds -= 1
        }

        guard !Task.isCancelled, !isPaused, !showsCompletion, remainingSeconds == 0 else { return }

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

    private func completeSession() {
        isPaused = true
        showsCompletion = true
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
