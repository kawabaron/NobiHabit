import SwiftUI

struct SectionHeader: View {
    var title: String
    var subtitle: String?
    var trailingTitle: String?
    var action: (() -> Void)?

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppFont.sectionTitle)
                    .foregroundStyle(AppColor.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textSecondary)
                }
            }

            Spacer()

            if let trailingTitle, let action {
                Button(trailingTitle, action: action)
                    .font(AppFont.captionStrong)
                    .foregroundStyle(AppColor.textSecondary)
            }
        }
    }
}

enum SettingRowAccessory {
    case navigation
    case navigationValue(String)
    case toggle(Binding<Bool>)
    case value(String)
}

struct SettingRow: View {
    var icon: String
    var title: String
    var accessory: SettingRowAccessory

    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: AppIconSize.md, weight: .medium))
                .foregroundStyle(AppColor.textSecondary)
                .frame(width: 26)

            Text(title)
                .font(AppFont.body)
                .foregroundStyle(AppColor.textPrimary)

            Spacer()

            switch accessory {
            case .navigation:
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColor.textTertiary)
            case .navigationValue(let value):
                Text(value)
                    .font(AppFont.caption)
                    .foregroundStyle(AppColor.textTertiary)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColor.textTertiary)
            case .toggle(let binding):
                Toggle("", isOn: binding)
                    .labelsHidden()
                    .tint(AppColor.success)
            case .value(let value):
                Text(value)
                    .font(AppFont.captionStrong)
                    .foregroundStyle(AppColor.textSecondary)
            }
        }
        .padding(.vertical, AppSpacing.rowVertical)
        .accessibilityElement(children: .combine)
    }
}
