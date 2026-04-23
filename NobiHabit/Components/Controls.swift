import SwiftUI

struct PrimaryButton: View {
    var title: String
    var systemImage: String?
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                if isLoading {
                    ProgressView()
                        .tint(AppColor.surfacePrimary)
                } else if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: AppIconSize.md, weight: .semibold))
                }

                Text(title)
                    .font(AppFont.button)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 48)
            .foregroundStyle(AppColor.surfacePrimary)
            .background(isDisabled ? AppColor.textTertiary.opacity(0.45) : AppColor.brandPrimarySage, in: Capsule())
        }
        .disabled(isDisabled || isLoading)
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

struct SecondaryButton: View {
    var title: String
    var systemImage: String?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(AppFont.button)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 46)
            .foregroundStyle(AppColor.textPrimary)
            .background(AppColor.surfacePrimary, in: Capsule())
            .overlay(
                Capsule()
                    .stroke(AppColor.borderSoft, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct BodyPartChip: View {
    var bodyPart: BodyPart
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xxs) {
                Image(systemName: bodyPart.systemImage)
                    .font(.system(size: AppIconSize.lg, weight: .medium))

                Text(bodyPart.title)
                    .font(AppFont.captionStrong)
            }
            .frame(width: 72, height: 68)
            .foregroundStyle(isSelected ? AppColor.textPrimary : AppColor.textSecondary)
            .background(isSelected ? AppColor.surfaceSageSoft : AppColor.surfacePrimary, in: RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous)
                    .stroke(isSelected ? AppColor.brandPrimarySage.opacity(0.7) : AppColor.borderSoft, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(bodyPart.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct SceneChip: View {
    var scene: SceneTag
    var isSelected: Bool = false
    var isLocked: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xs) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: scene.systemImage)
                        .font(.system(size: AppIconSize.xl, weight: .medium))
                        .frame(width: 52, height: 52)
                        .background(scene.tone.opacity(0.24), in: Circle())

                    if isLocked {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(AppColor.textTertiary)
                            .padding(4)
                            .background(AppColor.surfacePrimary, in: Circle())
                    }
                }

                Text(scene.title)
                    .font(AppFont.caption)
                    .lineLimit(1)
            }
            .foregroundStyle(isSelected ? AppColor.textPrimary : AppColor.textSecondary)
            .frame(width: 74)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isLocked ? "\(scene.title)、プレミアム限定" : scene.title)
    }
}

struct FilterTab: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.captionStrong)
                .foregroundStyle(isSelected ? AppColor.surfacePrimary : AppColor.textSecondary)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.xs)
                .background(isSelected ? AppColor.brandPrimarySage : AppColor.surfacePrimary, in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? AppColor.brandPrimarySage : AppColor.borderSoft, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct MoodOptionChip: View {
    var option: MoodOption
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xs) {
                Image(systemName: option.systemImage)
                Text(option.title)
                    .font(AppFont.captionStrong)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .foregroundStyle(isSelected ? AppColor.surfacePrimary : AppColor.textSecondary)
            .background(isSelected ? AppColor.brandPrimarySage : AppColor.surfacePrimary, in: RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous)
                    .stroke(isSelected ? AppColor.brandPrimarySage : AppColor.borderSoft, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct TimeOptionSegment: View {
    var options: [String]
    @Binding var selected: String

    var body: some View {
        HStack(spacing: AppSpacing.xs) {
            ForEach(options, id: \.self) { option in
                Button {
                    selected = option
                } label: {
                    Text(option)
                        .font(AppFont.captionStrong)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, AppSpacing.xs)
                        .foregroundStyle(selected == option ? AppColor.surfacePrimary : AppColor.textSecondary)
                        .background(selected == option ? AppColor.brandPrimarySage : Color.clear, in: Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(AppColor.surfaceSecondary, in: Capsule())
    }
}
