import SwiftUI

struct MascotBadge: View {
    var variant: MascotVariant
    var size: CGFloat = 44

    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: size * 0.32, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColor.surfaceSageSoft,
                            AppColor.backgroundElevated
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.78, height: size * 0.82)
                .overlay(face.offset(y: size * 0.28))
                .offset(y: size * 0.12)
                .softCardShadow()

            Image(systemName: variant.leafSystemImage)
                .font(.system(size: size * 0.17, weight: .medium))
                .foregroundStyle(AppColor.success)
                .offset(x: size * 0.1, y: -size * 0.02)

            if variant == .celebrate {
                Image(systemName: "sparkles")
                    .font(.system(size: size * 0.2, weight: .medium))
                    .foregroundStyle(AppColor.accentCoral)
                    .offset(x: size * 0.36, y: size * 0.05)
            }
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }

    private var face: some View {
        VStack(spacing: size * 0.08) {
            HStack(spacing: size * 0.16) {
                Circle()
                    .fill(AppColor.textPrimary.opacity(0.7))
                    .frame(width: size * 0.045, height: size * 0.045)
                Circle()
                    .fill(AppColor.textPrimary.opacity(0.7))
                    .frame(width: size * 0.045, height: size * 0.045)
            }

            Capsule()
                .fill(AppColor.textPrimary.opacity(variant == .sleep ? 0.22 : 0.6))
                .frame(width: size * 0.14, height: size * 0.025)
        }
    }
}

struct MascotInlineHint: View {
    var variant: MascotVariant
    var message: String

    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            MascotBadge(variant: variant, size: 38)

            Text(message)
                .font(AppFont.caption)
                .foregroundStyle(AppColor.textSecondary)
                .lineLimit(2)

            Spacer(minLength: 0)
        }
        .padding(AppSpacing.sm)
        .background(AppColor.backgroundElevated, in: RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous)
                .stroke(AppColor.borderSoft, lineWidth: 1)
        )
    }
}

struct ProgressRing<Content: View>: View {
    var progress: Double
    var lineWidth: CGFloat = 8
    let content: Content

    init(progress: Double, lineWidth: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.progress = progress
        self.lineWidth = lineWidth
        self.content = content()
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(AppColor.surfaceSecondary.opacity(0.6), lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: min(max(progress, 0), 1))
                .stroke(AppColor.success.opacity(0.84), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.22), value: progress)

            content
        }
    }
}

struct TimerView: View {
    var remainingText: String
    var caption: String

    var body: some View {
        VStack(spacing: AppSpacing.xxs) {
            Text(caption)
                .font(AppFont.caption)
                .foregroundStyle(AppColor.textSecondary)

            Text(remainingText)
                .font(AppFont.timerNumber)
                .monospacedDigit()
                .foregroundStyle(AppColor.textPrimary)
        }
    }
}
