import SwiftUI

struct BackgroundContainer<Content: View>: View {
    var showsDecor: Bool = true
    let content: Content

    init(showsDecor: Bool = true, @ViewBuilder content: () -> Content) {
        self.showsDecor = showsDecor
        self.content = content()
    }

    var body: some View {
        ZStack {
            AppColor.backgroundBase
                .ignoresSafeArea()

            if showsDecor {
                Circle()
                    .fill(AppColor.surfaceSageSoft.opacity(0.7))
                    .frame(width: 220, height: 220)
                    .blur(radius: 16)
                    .offset(x: -170, y: -310)

                Circle()
                    .fill(AppColor.accentBlue.opacity(0.16))
                    .frame(width: 180, height: 180)
                    .blur(radius: 20)
                    .offset(x: 170, y: 260)
            }

            content
        }
    }
}

struct AppScaffold<Content: View, Trailing: View>: View {
    var title: String?
    var subtitle: String?
    var showsDecor: Bool
    let trailing: Trailing
    let content: Content

    init(
        title: String? = nil,
        subtitle: String? = nil,
        showsDecor: Bool = true,
        @ViewBuilder trailing: () -> Trailing,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsDecor = showsDecor
        self.trailing = trailing()
        self.content = content()
    }

    var body: some View {
        BackgroundContainer(showsDecor: showsDecor) {
            VStack(spacing: 0) {
                if title != nil || subtitle != nil {
                    header
                        .screenHorizontalPadding()
                        .padding(.top, AppSpacing.md)
                        .padding(.bottom, AppSpacing.sm)
                }

                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppSpacing.lg) {
                        content
                    }
                    .screenHorizontalPadding()
                    .padding(.top, title == nil ? AppSpacing.lg : AppSpacing.xs)
                    .padding(.bottom, AppSpacing.scrollBottomClearance)
                }
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                if let title {
                    Text(title)
                        .font(AppFont.screenTitle)
                        .foregroundStyle(AppColor.textPrimary)
                }

                if let subtitle {
                    Text(subtitle)
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textSecondary)
                }
            }

            Spacer()
            trailing
        }
    }
}

extension AppScaffold where Trailing == EmptyView {
    init(
        title: String? = nil,
        subtitle: String? = nil,
        showsDecor: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            title: title,
            subtitle: subtitle,
            showsDecor: showsDecor,
            trailing: { EmptyView() },
            content: content
        )
    }
}
