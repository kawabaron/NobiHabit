import SwiftUI

enum SurfaceCardStyle {
    case standard
    case hero
    case muted
    case selected

    var fill: Color {
        switch self {
        case .standard, .hero:
            AppColor.surfacePrimary
        case .muted:
            AppColor.backgroundElevated
        case .selected:
            AppColor.surfaceSageSoft
        }
    }

    var border: Color {
        switch self {
        case .selected:
            AppColor.brandPrimarySage.opacity(0.65)
        default:
            AppColor.borderSoft
        }
    }
}

struct SurfaceCard<Content: View>: View {
    var style: SurfaceCardStyle = .standard
    var padding: CGFloat = AppSpacing.cardStandard
    let content: Content

    init(
        style: SurfaceCardStyle = .standard,
        padding: CGFloat = AppSpacing.cardStandard,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.padding = padding
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: style == .hero ? AppRadius.xl : AppRadius.lg, style: .continuous)
                    .fill(style.fill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: style == .hero ? AppRadius.xl : AppRadius.lg, style: .continuous)
                    .stroke(style.border, lineWidth: 1)
            )
            .softCardShadow(isHero: style == .hero)
    }
}

struct StatCard: View {
    var title: String
    var value: String
    var unit: String

    var body: some View {
        SurfaceCard(style: .standard, padding: AppSpacing.sm) {
            VStack(spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppFont.caption)
                    .foregroundStyle(AppColor.textSecondary)

                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text(value)
                        .font(AppFont.statNumber)
                        .foregroundStyle(AppColor.textPrimary)

                    Text(unit)
                        .font(AppFont.captionStrong)
                        .foregroundStyle(AppColor.textSecondary)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .accessibilityLabel("\(title) \(value)\(unit)")
    }
}

struct IllustrationCard: View {
    var assetName: String?
    var height: CGFloat = 180
    var showsFrame: Bool = true

    var body: some View {
        Group {
            if showsFrame {
                SurfaceCard(style: .muted, padding: AppSpacing.sm) {
                    illustration
                }
            } else {
                illustration
            }
        }
        .frame(height: height)
        .accessibilityHidden(true)
    }

    @ViewBuilder
    private var illustration: some View {
        if let assetName {
            Image(assetName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            StretchPlaceholderView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct StretchPlaceholderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColor.surfaceSageSoft.opacity(0.85),
                            AppColor.backgroundElevated
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .fill(AppColor.accentCoral.opacity(0.18))
                .frame(width: 92, height: 92)
                .offset(x: 42, y: 22)

            VStack(spacing: 0) {
                Circle()
                    .fill(AppColor.textPrimary.opacity(0.18))
                    .frame(width: 34, height: 34)

                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(AppColor.brandPrimarySage.opacity(0.72))
                    .frame(width: 72, height: 86)
                    .overlay(
                        Capsule()
                            .fill(AppColor.surfacePrimary.opacity(0.75))
                            .frame(width: 80, height: 20)
                            .offset(y: -18),
                        alignment: .top
                    )
            }
            .offset(y: 10)
        }
    }
}

struct RoutineCard: View {
    var routine: StretchRoutine
    var badge: String?
    var isLocked: Bool = false
    var isInProgress: Bool = false
    var showsMascot: Bool = false
    var action: (() -> Void)?

    var body: some View {
        Group {
            if let action {
                Button(action: action) {
                    content
                }
                .buttonStyle(.plain)
            } else {
                content
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityText)
    }

    private var content: some View {
        SurfaceCard(style: isInProgress ? .selected : .standard, padding: AppSpacing.sm) {
            HStack(spacing: AppSpacing.sm) {
                IllustrationCard(assetName: routine.thumbnailAssetName, height: 72)
                    .frame(width: 78)

                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    HStack(spacing: AppSpacing.xs) {
                        Text(routine.title)
                            .font(AppFont.cardTitle)
                            .foregroundStyle(AppColor.textPrimary)
                            .lineLimit(1)

                        if let badge {
                            Text(badge)
                                .font(AppFont.captionStrong)
                                .foregroundStyle(AppColor.textSecondary)
                                .padding(.horizontal, AppSpacing.xs)
                                .padding(.vertical, 3)
                                .background(AppColor.surfaceSageSoft, in: Capsule())
                        }
                    }

                    Text(routine.durationText)
                        .font(AppFont.captionStrong)
                        .foregroundStyle(AppColor.textSecondary)

                    Text(routine.subtitle)
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textSecondary)
                        .lineLimit(1)
                }

                Spacer(minLength: AppSpacing.xs)

                if showsMascot {
                    MascotBadge(variant: .greeting, size: 36)
                } else if isLocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: AppIconSize.sm, weight: .semibold))
                        .foregroundStyle(AppColor.textTertiary)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColor.textTertiary)
                }
            }
        }
    }

    private var accessibilityText: String {
        var parts = [routine.title, routine.durationText, routine.subtitle]
        if isLocked {
            parts.append("プレミアム限定")
        }
        return parts.joined(separator: "、")
    }
}

struct PremiumUpsellCard: View {
    var headline: String
    var bodyText: String
    var bullets: [String]
    var ctaTitle: String
    var action: () -> Void

    var body: some View {
        SurfaceCard(style: .hero, padding: AppSpacing.cardHero) {
            HStack(alignment: .bottom, spacing: AppSpacing.md) {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text(headline)
                        .font(AppFont.cardTitle)
                        .foregroundStyle(AppColor.textPrimary)

                    Text(bodyText)
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textSecondary)

                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        ForEach(bullets, id: \.self) { bullet in
                            Label(bullet, systemImage: "checkmark")
                                .font(AppFont.captionStrong)
                                .foregroundStyle(AppColor.textSecondary)
                        }
                    }

                    Button(ctaTitle, action: action)
                        .font(AppFont.captionStrong)
                        .foregroundStyle(AppColor.surfacePrimary)
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.vertical, AppSpacing.xs)
                        .background(AppColor.warning, in: Capsule())
                }

                Spacer(minLength: AppSpacing.xs)
                MascotBadge(variant: .sleep, size: 72)
            }
        }
    }
}
