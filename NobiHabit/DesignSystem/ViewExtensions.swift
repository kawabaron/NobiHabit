import SwiftUI

extension View {
    func screenHorizontalPadding() -> some View {
        padding(.horizontal, AppSpacing.screenHorizontal)
    }

    func softCardShadow(isHero: Bool = false) -> some View {
        shadow(
            color: AppColor.shadowSoft,
            radius: isHero ? 28 : 20,
            x: 0,
            y: isHero ? 10 : 6
        )
    }
}
