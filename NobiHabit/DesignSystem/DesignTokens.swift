import SwiftUI

enum AppColor {
    static let backgroundBase = Color(red: 247.0 / 255.0, green: 242.0 / 255.0, blue: 235.0 / 255.0)
    static let backgroundElevated = Color(red: 251.0 / 255.0, green: 247.0 / 255.0, blue: 242.0 / 255.0)
    static let surfacePrimary = Color(red: 255.0 / 255.0, green: 253.0 / 255.0, blue: 249.0 / 255.0)
    static let surfaceSecondary = Color(red: 243.0 / 255.0, green: 237.0 / 255.0, blue: 229.0 / 255.0)
    static let surfaceSageSoft = Color(red: 230.0 / 255.0, green: 239.0 / 255.0, blue: 232.0 / 255.0)

    static let brandPrimarySage = Color(red: 169.0 / 255.0, green: 199.0 / 255.0, blue: 178.0 / 255.0)
    static let accentBlue = Color(red: 184.0 / 255.0, green: 210.0 / 255.0, blue: 230.0 / 255.0)
    static let accentCoral = Color(red: 242.0 / 255.0, green: 183.0 / 255.0, blue: 166.0 / 255.0)

    static let textPrimary = Color(red: 58.0 / 255.0, green: 58.0 / 255.0, blue: 56.0 / 255.0)
    static let textSecondary = Color(red: 111.0 / 255.0, green: 112.0 / 255.0, blue: 106.0 / 255.0)
    static let textTertiary = Color(red: 155.0 / 255.0, green: 155.0 / 255.0, blue: 147.0 / 255.0)

    static let borderSoft = Color(red: 230.0 / 255.0, green: 222.0 / 255.0, blue: 211.0 / 255.0)
    static let borderStrong = Color(red: 215.0 / 255.0, green: 204.0 / 255.0, blue: 191.0 / 255.0)
    static let shadowSoft = textPrimary.opacity(0.08)

    static let success = Color(red: 143.0 / 255.0, green: 175.0 / 255.0, blue: 152.0 / 255.0)
    static let warning = Color(red: 216.0 / 255.0, green: 163.0 / 255.0, blue: 142.0 / 255.0)
    static let info = Color(red: 175.0 / 255.0, green: 200.0 / 255.0, blue: 219.0 / 255.0)
    static let illustrationFocusWarm = Color(red: 246.0 / 255.0, green: 214.0 / 255.0, blue: 207.0 / 255.0)
}

enum AppFont {
    static let largeTitle = Font.system(size: 28, weight: .semibold)
    static let screenTitle = Font.system(size: 22, weight: .semibold)
    static let sectionTitle = Font.system(size: 18, weight: .semibold)
    static let cardTitle = Font.system(size: 17, weight: .medium)
    static let body = Font.system(size: 15, weight: .regular)
    static let bodyStrong = Font.system(size: 15, weight: .semibold)
    static let caption = Font.system(size: 13, weight: .regular)
    static let captionStrong = Font.system(size: 13, weight: .medium)
    static let button = Font.system(size: 16, weight: .semibold)
    static let statNumber = Font.system(size: 24, weight: .medium)
    static let timerNumber = Font.system(size: 40, weight: .medium)
    static let tabLabel = Font.system(size: 11, weight: .medium)
}

enum AppSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 40

    static let screenHorizontal: CGFloat = 16
    static let cardCompact: CGFloat = 12
    static let cardStandard: CGFloat = 16
    static let cardHero: CGFloat = 20
}

enum AppRadius {
    static let xs: CGFloat = 10
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let full: CGFloat = 999
}

enum AppIconSize {
    static let sm: CGFloat = 16
    static let md: CGFloat = 18
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
}
