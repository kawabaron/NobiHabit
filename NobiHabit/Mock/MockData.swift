import Foundation

enum MockRoutines {
    static let neckRefresh = StretchRoutine(
        slug: "neck-refresh",
        title: "首・肩リフレッシュ",
        subtitle: "デスクワークの合間にすっきりほぐす",
        overview: "首まわりと肩をゆっくりゆるめる、短いリフレッシュです。",
        durationSeconds: 90,
        bodyParts: [.neckShoulders],
        sceneTags: [.deskBreak, .relax],
        difficulty: .gentle,
        isPremium: false,
        thumbnailAssetName: nil,
        heroIllustrationAssetName: nil,
        poses: [
            StretchPose(
                slug: "neck-side",
                title: "首の横倒し",
                instruction: "肩の力を抜いて、首を横にゆっくり倒します。",
                breathingCue: "呼吸をゆっくり、気持ちよく伸ばそう。",
                durationSeconds: 30,
                illustrationAssetName: nil,
                focusOverlayAssetName: nil,
                bodyFocus: [.neckLeft, .neckRight]
            ),
            StretchPose(
                slug: "shoulder-lift",
                title: "肩の上げ下げ",
                instruction: "息を吸いながら肩を上げ、吐きながら下ろします。",
                breathingCue: "吐く息で肩をふわっと落とします。",
                durationSeconds: 30,
                illustrationAssetName: nil,
                focusOverlayAssetName: nil,
                bodyFocus: [.shoulders]
            ),
            StretchPose(
                slug: "neck-back",
                title: "首の後ろ伸ばし",
                instruction: "両手を添えて、首の後ろをやさしく伸ばします。",
                breathingCue: "背中まで長くなる感覚で。",
                durationSeconds: 30,
                illustrationAssetName: nil,
                focusOverlayAssetName: nil,
                bodyFocus: [.upperBack]
            )
        ]
    )

    static let backReset = StretchRoutine(
        slug: "back-reset",
        title: "背中すっきりストレッチ",
        subtitle: "丸まりやすい背中を静かに整える",
        overview: "座ったままでもできる、背中中心のやさしいセットです。",
        durationSeconds: 120,
        bodyParts: [.back],
        sceneTags: [.deskBreak],
        difficulty: .gentle,
        isPremium: false,
        thumbnailAssetName: nil,
        heroIllustrationAssetName: nil,
        poses: []
    )

    static let sleepStretch = StretchRoutine(
        slug: "sleep-stretch",
        title: "眠る前のゆるめ時間",
        subtitle: "一日の緊張をほどいて休む準備へ",
        overview: "眠る前に呼吸を整える、静かなストレッチです。",
        durationSeconds: 150,
        bodyParts: [.fullBody],
        sceneTags: [.beforeSleep, .relax],
        difficulty: .gentle,
        isPremium: true,
        thumbnailAssetName: nil,
        heroIllustrationAssetName: nil,
        poses: []
    )

    static let fullBody = StretchRoutine(
        slug: "full-body",
        title: "全身リセット",
        subtitle: "短い時間で全身をひと巡り",
        overview: "朝や休憩に使いやすい全身セットです。",
        durationSeconds: 180,
        bodyParts: [.fullBody, .hips, .back],
        sceneTags: [.morningWake],
        difficulty: .standard,
        isPremium: true,
        thumbnailAssetName: nil,
        heroIllustrationAssetName: nil,
        poses: []
    )

    static let all: [StretchRoutine] = [
        neckRefresh,
        backReset,
        sleepStretch,
        fullBody
    ]
}

enum MockData {
    static let userStats = UserStats(
        currentStreakDays: 12,
        weeklySessions: 4,
        totalMinutes: 88,
        lastCompletedAt: Date().addingTimeInterval(-60 * 60 * 24)
    )

    static let recommendation = DailyRecommendation(
        date: Date(),
        routine: MockRoutines.neckRefresh,
        reasonText: "今日も整えていきましょう。",
        mascotVariant: .greeting
    )

    static let continueSession = ContinueSessionSummary(
        routine: MockRoutines.sleepStretch,
        remainingPoseCount: 2,
        lastPlayedAt: Date().addingTimeInterval(-60 * 60 * 2)
    )

    static let reminderSettings = ReminderSettings(
        reminderTimeText: "12:00",
        isReminderEnabled: true,
        isSoundEnabled: true,
        isHapticsEnabled: true,
        notificationPermissionState: .granted
    )

    static let premium = PremiumPlanState(
        status: .notSubscribed,
        isTrialEligible: true,
        lockedRoutineCount: 8,
        featureHighlights: [
            "プレミアム限定メニュー",
            "カスタム保存数の拡張",
            "詳細な記録・メモ"
        ]
    )
}
