import Foundation
import SwiftUI

enum BodyPart: String, CaseIterable, Identifiable, Hashable {
    case neckShoulders
    case back
    case hips
    case fullBody

    var id: String { rawValue }

    var title: String {
        switch self {
        case .neckShoulders:
            "首・肩"
        case .back:
            "背中"
        case .hips:
            "腰"
        case .fullBody:
            "全身"
        }
    }

    var systemImage: String {
        switch self {
        case .neckShoulders:
            "figure.mind.and.body"
        case .back:
            "figure.flexibility"
        case .hips:
            "figure.cooldown"
        case .fullBody:
            "figure.walk"
        }
    }
}

enum SceneTag: String, CaseIterable, Identifiable, Hashable {
    case morningWake
    case deskBreak
    case beforeSleep
    case relax

    var id: String { rawValue }

    var title: String {
        switch self {
        case .morningWake:
            "朝の目覚め"
        case .deskBreak:
            "仕事の合間"
        case .beforeSleep:
            "寝る前に"
        case .relax:
            "リラックス"
        }
    }

    var systemImage: String {
        switch self {
        case .morningWake:
            "sun.max"
        case .deskBreak:
            "desktopcomputer"
        case .beforeSleep:
            "moon"
        case .relax:
            "leaf"
        }
    }

    var tone: Color {
        switch self {
        case .morningWake:
            AppColor.accentBlue
        case .deskBreak:
            AppColor.surfaceSageSoft
        case .beforeSleep:
            AppColor.accentBlue
        case .relax:
            AppColor.accentCoral
        }
    }
}

enum RoutineDifficulty: String, Hashable {
    case gentle
    case standard
    case deep

    var title: String {
        switch self {
        case .gentle:
            "やさしい"
        case .standard:
            "ふつう"
        case .deep:
            "しっかり"
        }
    }
}

enum BodyFocus: String, Hashable {
    case neckLeft
    case neckRight
    case shoulders
    case upperBack
    case hips
}

enum MoodOption: String, CaseIterable, Identifiable, Hashable {
    case refreshed
    case justRight
    case stillHeavy

    var id: String { rawValue }

    var title: String {
        switch self {
        case .refreshed:
            "すっきり"
        case .justRight:
            "ちょうどいい"
        case .stillHeavy:
            "まだ少し重い"
        }
    }

    var systemImage: String {
        switch self {
        case .refreshed:
            "face.smiling"
        case .justRight:
            "circle"
        case .stillHeavy:
            "cloud"
        }
    }
}

enum MascotVariant: String, Hashable {
    case greeting
    case breath
    case celebrate
    case sleep

    var leafSystemImage: String {
        switch self {
        case .greeting, .breath, .celebrate:
            "leaf.fill"
        case .sleep:
            "leaf"
        }
    }
}

enum PremiumStatus: String, Hashable {
    case notSubscribed
    case trial
    case subscribed
}

enum NotificationPermissionState: String, Hashable {
    case unknown
    case granted
    case denied
}

struct StretchRoutine: Identifiable, Hashable {
    var id: UUID = UUID()
    var slug: String
    var title: String
    var subtitle: String
    var overview: String
    var durationSeconds: Int
    var bodyParts: [BodyPart]
    var sceneTags: [SceneTag]
    var difficulty: RoutineDifficulty
    var isPremium: Bool
    var thumbnailAssetName: String?
    var heroIllustrationAssetName: String?
    var poses: [StretchPose]

    var durationText: String {
        let minutes = durationSeconds / 60
        let seconds = durationSeconds % 60
        if seconds == 0 {
            return "\(minutes)分"
        }
        return "\(minutes)分\(seconds)秒"
    }
}

struct StretchPose: Identifiable, Hashable {
    var id: UUID = UUID()
    var slug: String
    var title: String
    var instruction: String
    var breathingCue: String
    var durationSeconds: Int
    var illustrationAssetName: String?
    var focusOverlayAssetName: String?
    var bodyFocus: [BodyFocus]
}

extension StretchPose {
    static let placeholderSet: [StretchPose] = [
        StretchPose(
            slug: "soft-breath",
            title: "ゆっくり呼吸",
            instruction: "背すじを長くして、呼吸を静かに整えます。",
            breathingCue: "吸って、吐いて。からだの重さを少し手放します。",
            durationSeconds: 30,
            illustrationAssetName: nil,
            focusOverlayAssetName: nil,
            bodyFocus: [.shoulders]
        ),
        StretchPose(
            slug: "gentle-stretch",
            title: "やさしく伸ばす",
            instruction: "痛みのない範囲で、心地よく伸ばします。",
            breathingCue: "無理をせず、気持ちいいところで止めましょう。",
            durationSeconds: 30,
            illustrationAssetName: nil,
            focusOverlayAssetName: nil,
            bodyFocus: [.upperBack]
        )
    ]
}

struct UserStats: Hashable {
    var currentStreakDays: Int
    var weeklySessions: Int
    var totalMinutes: Int
    var lastCompletedAt: Date?
}

struct DailyRecommendation: Identifiable, Hashable {
    var id: UUID = UUID()
    var date: Date
    var routine: StretchRoutine
    var reasonText: String
    var mascotVariant: MascotVariant
}

struct ContinueSessionSummary: Identifiable, Hashable {
    var id: UUID = UUID()
    var routine: StretchRoutine
    var remainingPoseCount: Int
    var lastPlayedAt: Date
}

struct SessionState: Hashable {
    var routine: StretchRoutine
    var currentPoseIndex: Int
    var remainingSecondsInPose: Int
    var elapsedSeconds: Int
    var isPaused: Bool
    var completedPoseIDs: [StretchPose.ID]
    var startedAt: Date
}

struct ReminderSettings: Hashable {
    var reminderTimeText: String
    var isReminderEnabled: Bool
    var isSoundEnabled: Bool
    var isHapticsEnabled: Bool
    var notificationPermissionState: NotificationPermissionState
}

struct PremiumPlanState: Hashable {
    var status: PremiumStatus
    var isTrialEligible: Bool
    var lockedRoutineCount: Int
    var featureHighlights: [String]
}
