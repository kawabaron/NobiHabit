import SwiftUI

struct AppTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(AppColor.borderSoft.opacity(0.72))
                .frame(height: 1)

            HStack(spacing: 0) {
                ForEach(AppTab.allCases) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        AppTabBarItem(tab: tab, isSelected: selectedTab == tab)
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel(Text(tab.title))
                    .accessibilityValue(Text(selectedTab == tab ? "選択中" : ""))
                }
            }
            .padding(.horizontal, AppSpacing.sm)
            .padding(.top, AppSpacing.xs)
            .padding(.bottom, AppSpacing.xs)
        }
        .background(AppColor.surfacePrimary.opacity(0.98))
    }
}

private struct AppTabBarItem: View {
    var tab: AppTab
    var isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tab.systemImage)
                .font(.system(size: 17, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? AppColor.success : AppColor.textSecondary)

            Text(tab.title)
                .font(AppFont.tabLabel)
                .foregroundStyle(isSelected ? AppColor.textPrimary : AppColor.textSecondary)

            Circle()
                .fill(AppColor.success)
                .frame(width: 4, height: 4)
                .opacity(isSelected ? 1 : 0)
        }
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

#Preview {
    AppTabBar(selectedTab: .constant(.home))
        .background(AppColor.backgroundBase)
}
