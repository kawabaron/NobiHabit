import SwiftUI

private enum LibraryFilter: String, CaseIterable, Identifiable, Hashable {
    case recommended
    case preset
    case custom
    case premium

    var id: String { rawValue }

    var title: String {
        switch self {
        case .recommended:
            "おすすめ"
        case .preset:
            "プリセット"
        case .custom:
            "カスタム"
        case .premium:
            "プレミアム"
        }
    }
}

struct MenuLibraryScreen: View {
    @State private var selectedFilter: LibraryFilter = .recommended
    @State private var selectedScene: SceneTag?

    private var routines: [StretchRoutine] {
        switch selectedFilter {
        case .recommended:
            MockRoutines.all
        case .preset:
            MockRoutines.all.filter { !$0.isPremium }
        case .custom:
            []
        case .premium:
            MockRoutines.all.filter(\.isPremium)
        }
    }

    var body: some View {
        AppScaffold(
            title: "メニュー",
            trailing: {
                Button {
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: AppIconSize.lg, weight: .medium))
                        .foregroundStyle(AppColor.textSecondary)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("検索")
            },
            content: {
                filterTabs
                routineSection
                sceneSection
            }
        )
    }

    private var filterTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                ForEach(LibraryFilter.allCases) { filter in
                    FilterTab(title: filter.title, isSelected: selectedFilter == filter) {
                        selectedFilter = filter
                    }
                }
            }
            .padding(.vertical, 1)
        }
    }

    @ViewBuilder
    private var routineSection: some View {
        if routines.isEmpty {
            SurfaceCard(style: .muted) {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("カスタムはまだありません")
                        .font(AppFont.cardTitle)
                        .foregroundStyle(AppColor.textPrimary)

                    Text("あとで自分用の短いルーチンを保存できるようにします。")
                        .font(AppFont.body)
                        .foregroundStyle(AppColor.textSecondary)

                    MascotInlineHint(variant: .breath, message: "まずはおすすめから、気持ちよく続けましょう。")
                }
            }
        } else {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                SectionHeader(title: selectedFilter.title)

                VStack(spacing: AppSpacing.sm) {
                    ForEach(routines) { routine in
                        RoutineCard(
                            routine: routine,
                            badge: routine.isPremium ? "Premium" : nil,
                            isLocked: routine.isPremium && selectedFilter != .premium
                        ) {
                        }
                    }
                }
            }
        }
    }

    private var sceneSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            SectionHeader(title: "シーンで選ぶ")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    ForEach(SceneTag.allCases) { scene in
                        SceneChip(scene: scene, isSelected: selectedScene == scene, isLocked: scene == .relax) {
                            selectedScene = scene
                        }
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

#Preview("Recommended") {
    MenuLibraryScreen()
}
