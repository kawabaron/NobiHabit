# NobiHabit UI Foundation Spec

作成日: 2026-04-23  
対象: iPhone / Swift + SwiftUI / 日本語 UI  
前提: 添付の「UI リデザイン案」と「ストレッチ人物イラストの新リファレンスシート」を唯一のビジュアル基準とする

---

## 全体前提

- デザイン方向性は `Calm premium wellness / Japanese minimalism / emotional warmth`
- generic な pastel wellness app には寄せない
- `purple-heavy / neon / harsh contrast / fitness-app 的な強さ / 医療ダッシュボード感` は避ける
- mascot は主役ではなく、静かに寄り添う案内役とする
- stretch illustration と mascot は同じ visual family に揃える
- 実装優先度は `見た目の上質さ > 実装の単純さ > 過剰な機能追加` ではなく、`実装しやすさを守りつつ上質感を落とさない` 順
- 今回は dark mode 必須ではないが、命名と構成は将来対応できるようにする
- MVP では iOS 17+ を推奨前提にし、Observation と `#Preview` を使いやすい構成にする

---

## Task 1: 添付資料の読み取りとデザイン要約

### 目的

- リデザイン案と人物イラストリファレンスを読み取り、UI 実装上の重要ルールを定義する

### やること

- プレゼンボードから画面構成、色、余白、カード表現、タイポ、アイコン、トーンを整理
- イラストリファレンスから人物表現、顔の記号性、配色、マット色、ハイライト表現ルールを整理
- mascot の使い方を整理
- 「絶対に守るべきこと」「実装上簡略化してよいこと」に分けてまとめる

### 成果物

- デザイン解釈サマリー
- 守るべき原則 10 個以内
- 実装上の割り切りポイント 10 個以内

### デザイン解釈サマリー

この UI の主役は、情報量や機能感ではなく「静けさ」と「続けやすい整い」です。  
暖かいアイボリーの背景に、落ち着いたセージグリーンを主軸として、淡いブルーとコーラルを補助的に使い、画面全体をやわらかく包んでいます。強いコントラストやビビッドな CTA ではなく、余白、丸み、薄いボーダー、淡い影によって気持ちの負荷を下げています。

画面構成は明快で、1 画面 1 役割です。ホームは「今日の導線」、メニューは「選択」、開始前は「理解と準備」、実施中は「安心して今に集中」、完了は「静かな達成」、設定は「生活へのなじませ方」に寄っています。視覚的に強い要素は常に 1 つだけで、画面内の競合が少ない設計です。

人物イラストは、運動アプリのような筋力感ではなく、呼吸と脱力を伝える semi-flat painterly な表現です。服はマットなセージ系、肌はあたたかい明度、影は薄く広く、輪郭線は硬くありません。部位ハイライトも医療的ではなく、やわらかな赤みのぼかしで示します。

mascot は情報の案内役ではなく感情の補助役です。サイズは小さく、画面の一角で「付き添う」ことが正解です。人物イラストと同じ色温度、同じ陰影の軽さ、同じやさしさで描かれている必要があります。

### 守るべき原則

1. 第一印象は「静けさ」と「整い」であり、賑やかさではない
2. 背景は暖かいアイボリー系、主アクセントはセージグリーンで統一する
3. 主要 CTA 以外は強く主張させず、カードと余白で情報階層を作る
4. カードは薄い境界線と浅い影で扱い、ガラス感や重い立体感は避ける
5. 人物イラストは「やさしい伸び」「呼吸」「脱力」を伝える表現に統一する
6. mascot は主役にせず、小さな案内役として配置する
7. mascot と stretch illustration は同じ visual family に属するように揃える
8. 日本語 UI コピーは短く、静かで、押しつけがましくない言い回しにする
9. premium 訴求は押し売りではなく「体験の拡張」として見せる
10. 低コントラストの世界観を守りつつ、本文と操作要素の可読性は十分に確保する

### 実装上の割り切りポイント

1. 装飾的な葉モチーフは、必要な箇所だけの淡い背景装飾に簡略化してよい
2. 資料の serif 見出しはブランド演出用とし、アプリ本体は読みやすい system sans に寄せてよい
3. カード影は共通の soft shadow token 1 種にまとめてよい
4. 部位・シーンの小アイコンは初期実装では SF Symbols で代替してよい
5. セッション画面の前後ナビゲーションは、初期は単純な chevron 操作で十分
6. 完了画面の祝福演出は、最初は静止装飾でよく、派手なアニメーションは不要
7. 人物の painterly な質感はコードで再現せず、画像 asset 前提で扱ってよい
8. 部位ハイライトは将来差し替え可能な asset slot を作り、初期は固定画像でもよい
9. mascot バリエーションは最初は 4 種程度に絞ってよい
10. 背景の空気感は複雑なグラデーションではなく、淡色の blob や円で近似してよい

---

## Task 2: デザイントークン定義

### 目的

- 実装に使える形でブランドトークンを定義する

### やること

- Color tokens を定義する
- Typography tokens を定義する
- Radius / spacing / shadow / icon size / card padding を定義する
- dark mode は将来対応しやすい命名にする

### 成果物

- SwiftUI 実装に落とせるデザイントークン一覧
- 命名規則
- 将来 dark mode 対応しやすい注意点

### Color Tokens

| Token | 役割 | 推奨値 |
| --- | --- | --- |
| `color.background.base` | 画面全体の基調背景 | `#F7F2EB` |
| `color.background.elevated` | セクション背景、柔らかい面 | `#FBF7F2` |
| `color.surface.primary` | 通常カード面 | `#FFFDF9` |
| `color.surface.secondary` | サブカード、押し込みの弱い面 | `#F3EDE5` |
| `color.surface.sageSoft` | 選択中の穏やかな背景 | `#E6EFE8` |
| `color.brand.primarySage` | メイン CTA、強調リング | `#A9C7B2` |
| `color.brand.accentBlue` | 補助アクセント、シーン表現 | `#B8D2E6` |
| `color.brand.accentCoral` | 気分、温かみ、部位ハイライト系 | `#F2B7A6` |
| `color.text.primary` | 見出し、主要本文 | `#3A3A38` |
| `color.text.secondary` | 補助本文 | `#6F706A` |
| `color.text.tertiary` | キャプション、非活性補助 | `#9B9B93` |
| `color.border.soft` | 標準ボーダー | `#E6DED3` |
| `color.border.strong` | 選択中、区切り強調 | `#D7CCBF` |
| `color.shadow.soft` | 共通シャドウ色 | `rgba(58,58,56,0.08)` |
| `color.status.success` | 達成、完了補助 | `#8FAF98` |
| `color.status.warning` | 注意、やや負荷あり | `#D8A38E` |
| `color.status.info` | 中立情報補助 | `#AFC8DB` |
| `color.illustration.focusWarm` | 部位ハイライトの赤み | `#F6D6CF` |
| `color.overlay.scrimSoft` | シート、モーダル下地 | `rgba(58,58,56,0.10)` |

補足:

- 添付の palette にある `#A9C7B2 / #B8D2E6 / #F2B7A6 / #F5EEE6 / #3A3A38` を中核とし、実装に必要な階調だけを増やす
- 色名を直接 UI に書かず、役割ベースの semantic token で呼ぶ

### Typography Tokens

| Token | 用途 | 推奨仕様 |
| --- | --- | --- |
| `typography.brandDisplay` | 資料的なブランド見出し | 34 / Regular / serif 系近似 |
| `typography.largeTitle` | 主要画面見出し | 28 / Semibold |
| `typography.screenTitle` | 画面タイトル | 22 / Semibold |
| `typography.sectionTitle` | セクション見出し | 18 / Semibold |
| `typography.cardTitle` | カードタイトル | 17 / Medium |
| `typography.body` | 標準本文 | 15 / Regular |
| `typography.bodyStrong` | 本文強調 | 15 / Semibold |
| `typography.caption` | 補助文、説明 | 13 / Regular |
| `typography.captionStrong` | 小ラベル強調 | 13 / Medium |
| `typography.button` | ボタンラベル | 16 / Semibold |
| `typography.statNumber` | 統計数値 | 28 / Medium |
| `typography.timerNumber` | セッション残り時間 | 40 / Medium |
| `typography.tabLabel` | Tab bar ラベル | 11 / Medium |

補足:

- 実装は system sans を基本にし、資料の静かな高級感は weight と spacing で再現する
- `.rounded` の多用は避ける。可愛さが先に出るため、基本は default design を推奨する

### Radius / Spacing / Shadow / Icon / Padding

#### Radius

| Token | 値 | 用途 |
| --- | --- | --- |
| `radius.xs` | 10 | 小タグ、インライン badge |
| `radius.sm` | 12 | chip、トグル外枠 |
| `radius.md` | 16 | 標準カード |
| `radius.lg` | 20 | おすすめカード、大きめ面 |
| `radius.xl` | 24 | hero card、premium card |
| `radius.full` | 999 | pill ボタン、セグメント |

#### Spacing

| Token | 値 |
| --- | --- |
| `space.2` | 4 |
| `space.3` | 8 |
| `space.4` | 12 |
| `space.5` | 16 |
| `space.6` | 20 |
| `space.7` | 24 |
| `space.8` | 32 |
| `space.10` | 40 |

#### Shadow

| Token | 値 | 用途 |
| --- | --- | --- |
| `shadow.cardSoft` | y: 6, blur: 20, opacity: 0.06 | 標準カード |
| `shadow.heroSoft` | y: 10, blur: 28, opacity: 0.08 | 大きめ面 |
| `shadow.none` | 0 | chip、静かな面 |

#### Icon Size

| Token | 値 | 用途 |
| --- | --- | --- |
| `icon.sm` | 16 | 補助アイコン |
| `icon.md` | 18 | 行内アイコン |
| `icon.lg` | 20 | ナビアイコン |
| `icon.xl` | 24 | 主要操作 |

#### Card Padding

| Token | 値 | 用途 |
| --- | --- | --- |
| `padding.card.compact` | 12 | 小さめカード |
| `padding.card.standard` | 16 | 標準カード |
| `padding.card.hero` | 20 | hero、premium |
| `padding.screen.horizontal` | 16 | 画面左右余白 |
| `padding.screen.top` | 20 | ヘッダ下の最初の余白 |
| `padding.safeCTA` | 16 | 下部固定 CTA まわり |

### 命名規則

- 値ベースでなく役割ベースで命名する
- SwiftUI 側では `ColorToken.backgroundBase` のように型付き参照にする
- Asset Catalog の Color Set 名も役割ベースで揃える
- View では `Color("sage")` のような生文字列参照を禁止する
- 例:
  - `background.base`
  - `surface.primary`
  - `brand.primarySage`
  - `text.secondary`
  - `radius.lg`
  - `space.5`

### 将来 dark mode 対応しやすい注意点

1. `cream` や `greenLight` のような見た目名ではなく、`background.base` のような意味名で持つ
2. `Color` の直接初期化を View に書かず、必ず token を経由する
3. 色は可能な限り Asset Catalog に集約し、将来 Appearance 切替で差し替えられるようにする
4. シャドウやボーダーも token 化し、light 固定値を View に埋めない
5. セージ系の主 CTA だけは dark mode 時にもブランドとして残せるよう、明度差で再設計できる余地を残す

---

## Task 3: 共通コンポーネント設計

### 目的

- 6 画面を一貫した UI として組めるように、再利用コンポーネントを定義する

### やること

- 画面横断で必要なコンポーネントを洗い出す
- 各コンポーネントの Props を定義する
- 状態差分を定義する

### 成果物

- 共通コンポーネント一覧
- 各コンポーネントの責務
- 必要な引数
- 状態パターン

### 共通コンポーネント一覧

| Component | 責務 | 主な引数 | 状態パターン |
| --- | --- | --- | --- |
| `AppScaffold` | 画面背景、safe area、ヘッダ、Tab bar 整形 | `title`, `showsBackButton`, `trailingItems`, `showsTabBar`, `content` | standard / scroll / fixedCTA |
| `BackgroundContainer` | 背景色と淡い装飾 blob の提供 | `style`, `showsDecor` | plain / decorated |
| `SectionHeader` | セクション見出しと補助導線 | `title`, `subtitle`, `trailingTitle`, `action` | default / compact |
| `SurfaceCard` | 共通カード面の外観を統一 | `style`, `padding`, `content` | standard / hero / muted / selected |
| `StatCard` | 統計の表示 | `title`, `value`, `unit`, `accentStyle` | default / emphasized |
| `RoutineCard` | ルーチン情報の要約表示 | `thumbnail`, `title`, `durationText`, `subtitle`, `badge`, `trailingStyle` | normal / selected / locked / inProgress |
| `BodyPartChip` | 部位フィルタ | `label`, `icon`, `isSelected` | default / selected / disabled |
| `SceneChip` | シーン別導線 | `label`, `icon`, `tone`, `isSelected` | default / selected / locked |
| `FilterTab` | おすすめ / プリセット等の上部切替 | `title`, `isSelected` | default / selected |
| `PrimaryButton` | 主要 CTA | `title`, `icon`, `isLoading`, `isDisabled`, `action` | enabled / disabled / loading |
| `SecondaryButton` | 補助 CTA | `title`, `icon`, `style`, `action` | enabled / disabled |
| `ProgressRing` | セッション進捗の視覚化 | `progress`, `lineWidth`, `accentColor`, `content` | active / paused / completed |
| `TimerView` | 残り時間の表示 | `remainingText`, `caption`, `progress` | active / paused / finished |
| `MoodOptionChip` | 完了後の気分記録 | `title`, `icon`, `isSelected` | default / selected |
| `SettingRow` | 設定一覧の標準行 | `icon`, `title`, `valueText`, `rowKind` | navigation / toggle / destructive |
| `PremiumUpsellCard` | Premium 訴求のまとまり | `headline`, `bullets`, `ctaTitle`, `illustration` | default / highlighted |
| `MascotBadge` | 小サイズ mascot のアイコン表示 | `variant`, `size` | greeting / breath / celebrate / sleep |
| `MascotInlineHint` | mascot と短い案内文 | `variant`, `message` | default / subtle |
| `IllustrationCard` | 人物イラストの表示枠 | `assetName`, `contentMode`, `backgroundStyle`, `focusOverlay` | plain / framed / highlighted |
| `TimeOptionSegment` | 時間調整セグメント | `options`, `selected`, `onSelect` | default / selected / disabled |

### コンポーネント責務ルール

- 見た目を統一する責務は `DesignSystem` と `Components` に集約する
- 画面固有の文脈を持つものは Feature 側に置く
- `RoutineCard` のような再利用率が高いものは、文言生成を外から受け取る
- `PremiumUpsellCard` は見た目だけ共通にし、訴求文は Feature 側で差し替え可能にする
- `MascotInlineHint` は視覚的主張を抑え、常に 1〜2 行の短文に限定する

### 状態差分の基本方針

- `selected`
- `disabled`
- `loading`
- `locked`
- `inProgress`
- `completed`
- `paused`

状態は色の切り替えだけでなく、ラベル、枠線、 trailing accessory の差分も含めて設計する。  
ただし視覚的な差は穏やかにし、`locked` でも過度に暗くしたり、全面 blur にしない。

---

## Task 4: 画面情報設計

### 目的

- 6 画面の UI 構造と情報優先度を整理する

### やること

- 各画面の目的、主情報、副情報、CTA、必要な状態、空状態、premium 表示有無を整理する
- 多すぎる情報を削り、実装可能な構造にする
- Tab bar 構成も整理する

### 成果物

- 6 画面の情報設計表
- 画面ごとの UI 優先順位
- 必須要素 / optional 要素

### Tab Bar 構成

添付ボード準拠では `ホーム / メニュー / 記録 / 設定` の 4 タブが自然。  
ただし今回の詳細仕様対象は 6 画面で、独立した「記録」画面は含まれていないため、実装方針は以下を推奨する。

1. `ホーム`
2. `メニュー`
3. `記録`
4. `設定`

仮置き方針:

- 今回は `記録` を placeholder か軽量な履歴画面に留める
- 本仕様書では `完了・記録` を完了直後の画面として扱い、履歴タブは将来拡張枠とする

### 画面情報設計表

| 画面 | 画面目的 | 主情報 | 副情報 | 主 CTA | 必要な状態 | 空状態 | Premium 表示 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ホーム | 今日の最短導線を示す | 今日のおすすめ、現在の統計 | 続きから、部位導線、挨拶 | `開始する` | 通常 / 統計なし / おすすめなし / 続きあり | おすすめがなければメニュー導線へ | なし |
| メニュー | ルーチン選択をしやすくする | カテゴリ切替、ルーチン一覧 | シーン別導線 | カードタップ | 通常 / lock あり / custom 0 件 | カスタム未作成メッセージ | あり |
| 開始前 | 内容を理解し、安心して始める | タイトル、説明、含まれるストレッチ | 所要時間、難易度、呼吸メモ | `開始する` | 通常 / 保存済み / asset 欠け | イラスト欠け時 placeholder | optional |
| 実施中 | 今の動きに集中させる | 現在のイラスト、残り時間、進捗 | 次のストレッチ、呼吸ヒント | `一時停止` / `スキップ` | 実施中 / 一時停止 / 最終ポーズ | 次ポーズなしは完了へ遷移 | なし |
| 完了・記録 | 静かな達成感を作り、次へつなぐ | 完了メッセージ、気分記録、統計 | 明日のおすすめ | `ホームに戻る` | 通常 / 気分未選択 | おすすめなしでも戻れる | なし |
| 設定・プレミアム | 毎日の習慣に馴染ませる | 通知、サウンド、バイブ | その他設定、premium | `詳しく見る` | 通常 / premium 保有 / premium 未加入 | なし | 主にここで表示 |

### 画面ごとの UI 優先順位

#### ホーム

- 優先 1: 今日のおすすめ
- 優先 2: 継続実感が出る統計
- 優先 3: すぐ再開できる続きから
- Optional: 部位フィルタの詳細展開

#### メニュー

- 優先 1: ルーチン一覧とカテゴリ切替
- 優先 2: シーン別導線
- 優先 3: premium lock の上品な表示
- Optional: 検索やソート

#### 開始前

- 優先 1: 何をやるか分かること
- 優先 2: どれくらいで終わるか分かること
- 優先 3: 開始 CTA
- Optional: ブックマーク

#### 実施中

- 優先 1: 今のイラスト
- 優先 2: 残り時間
- 優先 3: 次に何が来るか
- Optional: 前後移動

#### 完了・記録

- 優先 1: 達成感
- 優先 2: 気分記録
- 優先 3: 継続指標
- Optional: 小さな演出

#### 設定・プレミアム

- 優先 1: 通知設定
- 優先 2: 音と振動
- 優先 3: premium 案内
- Optional: 詳細なエクスポート設定

---

## Task 5: 画面別 UI 仕様書

### 目的

- 各画面を SwiftUI 実装可能な粒度の仕様へ落とす

### やること

- レイアウト構造、主要コンポーネント、余白、スクロール、ボタン、テキスト階層、イラスト、mascot、エラー、Accessibility を定義する

### 成果物

- 6 画面分の詳細 UI 仕様書

### 1. ホーム

#### レイアウト構造

- 縦スクロール
- 上から `GreetingHeader` → `StatsRow` → `DailyRecommendationCard` → `BodyPartChipSection` → `ContinueCard`
- `AppScaffold` を使用し、背景は `background.base`

#### 主要コンポーネント

- `SectionHeader`
- `StatCard` x 3
- `RoutineCard` の hero 版
- `BodyPartChip`
- `RoutineCard` の compact 版

#### 余白ルール

- 左右余白は `16`
- セクション間は `20`
- カード内余白は `16`

#### スクロール有無

- あり
- chip 行だけ横スクロール可

#### ボタン配置

- おすすめカード内の下部に `PrimaryButton`
- 続きからカードはカード全体タップ + trailing arrow
- 右上に通知ベルを 1 つだけ配置

#### テキスト階層

- greeting: `bodyStrong`
- サブ挨拶: `body`
- セクション見出し: `sectionTitle`
- おすすめカードタイトル: `cardTitle`
- 説明文: `caption`

#### イラスト配置

- 今日のおすすめカード左に人物イラスト
- 比率は正方形寄り、角丸内に収める
- 高さ 84〜96pt 程度

#### mascot 配置ルール

- 今日のおすすめ近くに 32〜40pt 程度で小さく置く
- greeting と競合させない
- 右上寄せまたはカード右上に重ならない形で配置

#### エラーや未設定時の扱い

- 統計が空なら `-` ではなく「まだこれから」の静かな placeholder を表示
- 今日のおすすめがない場合は「今日はメニューから選びましょう」に切り替える

#### Accessibility

- `StatCard` は `連続日数 12日` のように読み上げを結合
- カード全体をボタンにする場合はラベルを明示
- 主要 CTA と chip は 44pt 以上を確保

### 2. メニュー

#### レイアウト構造

- 縦スクロール
- 上から `画面タイトル` → `FilterTabRow` → `RoutineListSection` → `SceneChipSection`

#### 主要コンポーネント

- `FilterTab`
- `RoutineCard`
- `SceneChip`

#### 余白ルール

- 左右余白 `16`
- 上部フィルタとリストの間 `16`
- ルーチンカード間 `12`

#### スクロール有無

- 縦スクロールあり

#### ボタン配置

- ルーチンカード全体タップで開始前へ
- search は右上アイコンで optional

#### テキスト階層

- 画面タイトル: `screenTitle`
- カテゴリタブ: `captionStrong`
- ルーチン名: `cardTitle`
- 時間・補足: `caption`

#### イラスト配置

- カード左に 64〜72pt のサムネイル
- 人物が中央から切れないよう `fit` より `fill` を優先しつつ安全トリミング

#### mascot 配置ルール

- おすすめカテゴリの一部カードにだけ小さく添える
- 一覧全体に繰り返さない

#### エラーや未設定時の扱い

- カスタム 0 件なら「あとで自分用ルーチンを追加できます」
- premium lock は全体グレーアウトではなく、右上 lock badge と subtitle で示す

#### Accessibility

- lock 状態は読み上げで「プレミアム限定」を含める
- カテゴリ切替は selected 状態を VoiceOver で伝える

### 3. 開始前

#### レイアウト構造

- 縦スクロール + 下部固定 CTA
- 上から `NavBar` → `Hero Illustration` → `Summary` → `Included Stretches` → `TimeOptionSegment`

#### 主要コンポーネント

- `IllustrationCard`
- `MascotInlineHint`
- `SurfaceCard`
- `TimeOptionSegment`
- `PrimaryButton`

#### 余白ルール

- 上下のリズムは `20`
- hero 下の説明まで `16`
- CTA エリアは safe area 込みで `16`

#### スクロール有無

- あり
- CTA は固定

#### ボタン配置

- 下部に `開始する`
- 右上に bookmark を optional 配置

#### テキスト階層

- タイトル: `screenTitle`
- 概要文: `body`
- 補助メタ情報: `caption`
- セクション名: `sectionTitle`

#### イラスト配置

- 画面上半分に近い主役扱い
- 高さは 220〜280pt
- 背景に淡い楕円や葉のぼかしを入れてよい

#### mascot 配置ルール

- 説明文近くに 32pt 程度
- CTA 付近には置かない

#### エラーや未設定時の扱い

- イラスト asset 欠け時は silhouette placeholder を表示
- 含まれるストレッチが 1 件ならリストではなく単一説明に簡略化

#### Accessibility

- 時間変更セグメントは selected 状態を明示
- CTA は「首・肩リフレッシュを開始する」のように具体化する

### 4. 実施中

#### レイアウト構造

- 非スクロール
- 上から `CompactNav` → `StepIndicator` → `MainIllustration` → `TimerBlock` → `BreathingHint` → `NextStretchCard` → `BottomControls`

#### 主要コンポーネント

- `IllustrationCard`
- `ProgressRing`
- `TimerView`
- `MascotInlineHint`
- `RoutineCard` の next preview 版
- `SecondaryButton`

#### 余白ルール

- 画面全体を縦方向に均等配分
- 下部操作の左右余白は `16`

#### スクロール有無

- なし

#### ボタン配置

- 左下 `一時停止`
- 右下 `スキップ`
- 左上 close
- optional で左右 chevron

#### テキスト階層

- ポーズ名: `screenTitle`
- ステップ番号: `caption`
- タイマー: `timerNumber`
- 呼吸ヒント: `body`

#### イラスト配置

- 画面最大のビジュアル
- safe area を侵食しない範囲で大きく見せる
- 背景フレームは淡色円形または楕円

#### mascot 配置ルール

- タイマーの近くではなく、呼吸ヒントの横に小さく添える
- 存在感は 24〜32pt 程度

#### エラーや未設定時の扱い

- 次のストレッチがなければカードを「最後のストレッチです」に切り替える
- 一時停止中は progress ring を止め、ボタン文言を `再開する` に変える

#### Accessibility

- タイマーは更新頻度を抑え、必要時だけ読み上げる
- ボタンは「一時停止」「スキップして次へ」と意味を明確にする
- アニメーションは `Reduce Motion` で弱める

### 5. 完了・記録

#### レイアウト構造

- 小画面配慮のため縦スクロール
- 上から `CompletionHero` → `SummaryStats` → `MoodCheckin` → `TomorrowRecommendation` → `PrimaryButton`

#### 主要コンポーネント

- `MascotBadge`
- `StatCard`
- `MoodOptionChip`
- `RoutineCard`
- `PrimaryButton`

#### 余白ルール

- 冒頭の余白をやや広めに取る
- mood と recommendation の間は `20`

#### スクロール有無

- あり

#### ボタン配置

- 下部に `ホームに戻る`
- mood は任意選択でも離脱可能

#### テキスト階層

- 完了タイトル: `largeTitle`
- 完了したルーチン名: `cardTitle`
- 補助メッセージ: `body`
- mood 誘導文: `caption`

#### イラスト配置

- 中央は mascot 主体
- 人物イラストは明日のおすすめカードに小さく出す

#### mascot 配置ルール

- ここだけ少し大きくしてよい
- ただし画面半分以上を使わない

#### エラーや未設定時の扱い

- 気分未選択でも CTA を押せる
- 明日のおすすめが未生成なら「また明日、静かに整えましょう」とする

#### Accessibility

- mood 選択肢は状態を読み上げる
- 完了統計はラベルを結合して読み上げる

### 6. 設定・プレミアム

#### レイアウト構造

- 縦スクロール
- 上から `通知` → `サウンド・触覚` → `その他` → `PremiumUpsellCard`

#### 主要コンポーネント

- `SettingRow`
- `PremiumUpsellCard`

#### 余白ルール

- セクション間 `20`
- 行内 padding は `16`

#### スクロール有無

- あり

#### ボタン配置

- toggle は右側
- navigation row は chevron
- premium card 内に `詳しく見る`

#### テキスト階層

- 画面タイトル: `screenTitle`
- セクション見出し: `sectionTitle`
- 行ラベル: `body`
- premium 補助文: `caption`

#### イラスト配置

- premium card 下部または右下に寝ている mascot
- 大きくしすぎない

#### mascot 配置ルール

- premium 訴求を和らげる用途に限定
- 他セクションでは基本使わない

#### エラーや未設定時の扱い

- 通知未許可なら valueText に `未許可` を表示し、導線を設定アプリへ出す
- premium 加入済みなら upsell card は特典一覧カードへ差し替える

#### Accessibility

- toggle はラベルと状態を正しく関連付ける
- premium CTA は誇張表現を避けつつ、目的が分かる文言にする

---

## Task 6: データモデルとダミーデータ設計

### 目的

- 実装開始しやすいように、最低限のモデルとモックデータを定義する

### やること

- 必要なモデルを定義する
- enum / state を整理する
- Preview 用モックデータ構成を決める

### 成果物

- 推奨データモデル一覧
- モックデータ方針
- Preview 用サンプルデータ設計

### 推奨データモデル一覧

#### `StretchRoutine`

- `id`
- `slug`
- `title`
- `subtitle`
- `overview`
- `durationSeconds`
- `bodyParts: [BodyPart]`
- `sceneTags: [SceneTag]`
- `difficulty: RoutineDifficulty`
- `isPremium`
- `thumbnailAssetName`
- `heroIllustrationAssetName`
- `poses: [StretchPose]`

#### `StretchPose`

- `id`
- `slug`
- `title`
- `instruction`
- `breathingCue`
- `durationSeconds`
- `illustrationAssetName`
- `focusOverlayAssetName?`
- `bodyFocus: [BodyFocus]`

#### `UserStats`

- `currentStreakDays`
- `weeklySessions`
- `totalMinutes`
- `lastCompletedAt`

#### `DailyRecommendation`

- `date`
- `routine: StretchRoutine`
- `reasonText`
- `mascotVariant`

#### `ContinueSessionSummary`

- `routineTitle`
- `remainingPoseCount`
- `lastPlayedAt`
- `thumbnailAssetName`

#### `SessionState`

- `routine`
- `currentPoseIndex`
- `remainingSecondsInPose`
- `elapsedSeconds`
- `isPaused`
- `completedPoseIDs`
- `startedAt`

#### `MoodCheckin`

- `selected: MoodOption?`
- `availableOptions: [MoodOption]`

#### `ReminderSettings`

- `reminderTime`
- `isReminderEnabled`
- `isSoundEnabled`
- `isHapticsEnabled`
- `repeatWeekdays`
- `notificationPermissionState`

#### `PremiumPlanState`

- `status: PremiumStatus`
- `isTrialEligible`
- `lockedRoutineCount`
- `featureHighlights`

### 推奨 enum / state

#### `BodyPart`

- `neckShoulders`
- `back`
- `hip`
- `fullBody`

#### `SceneTag`

- `morningWake`
- `deskBreak`
- `beforeSleep`
- `relax`

#### `RoutineDifficulty`

- `gentle`
- `standard`
- `deep`

#### `BodyFocus`

- `neckLeft`
- `neckRight`
- `shoulders`
- `upperBack`
- `hips`

#### `MoodOption`

- `refreshed`
- `justRight`
- `stillHeavy`

#### `PremiumStatus`

- `notSubscribed`
- `trial`
- `subscribed`

#### `NotificationPermissionState`

- `unknown`
- `granted`
- `denied`

### モックデータ方針

- 画面プレビューは API 非依存で成立させる
- `MockData` 配下に screen 別 fixture を持たせる
- 画像 asset 名は本番と同じ命名規則で仮置きする
- premium / empty / paused / completed など、主要状態ごとに fixture を分ける

### Preview 用サンプルデータ設計

- `MockRoutines.neckRefresh`
- `MockRoutines.backReset`
- `MockRecommendations.today`
- `MockStats.standardUser`
- `MockStats.newUser`
- `MockSession.activePose2`
- `MockSession.pausedPose2`
- `MockSettings.default`
- `MockSettings.notificationDenied`
- `MockPremium.locked`
- `MockPremium.subscribed`

---

## Task 7: SwiftUI ファイル構成案

### 目的

- Codex が迷わずファイルを切れるようにする

### やること

- Feature 単位でファイル構成を提案する
- 各ディレクトリの責務を明記する
- Asset 命名方針を決める

### 成果物

- 推奨ファイル構成
- 命名規則
- Asset 管理ルール

### 推奨ファイル構成

```text
NobiHabit/
  App/
    NobiHabitApp.swift
    AppRootView.swift
    AppTab.swift
    AppRouter.swift
    AppEnvironment.swift
  DesignSystem/
    Tokens/
      ColorToken.swift
      TypographyToken.swift
      SpacingToken.swift
      RadiusToken.swift
      ShadowToken.swift
      IconToken.swift
    Theme/
      AppTheme.swift
      AppBackgroundStyle.swift
    Extensions/
      Color+Token.swift
      Font+Token.swift
      View+CardStyle.swift
      View+ScreenPadding.swift
  Components/
    Scaffold/
      AppScaffold.swift
      BackgroundContainer.swift
    Cards/
      SurfaceCard.swift
      StatCard.swift
      RoutineCard.swift
      PremiumUpsellCard.swift
      IllustrationCard.swift
    Controls/
      PrimaryButton.swift
      SecondaryButton.swift
      BodyPartChip.swift
      SceneChip.swift
      FilterTab.swift
      TimeOptionSegment.swift
      MoodOptionChip.swift
    Feedback/
      ProgressRing.swift
      TimerView.swift
      MascotBadge.swift
      MascotInlineHint.swift
      EmptyStateCard.swift
    Rows/
      SectionHeader.swift
      SettingRow.swift
  Features/
    Home/
      HomeScreen.swift
      HomeContent.swift
      HomeViewState.swift
    MenuLibrary/
      MenuLibraryScreen.swift
      MenuLibraryContent.swift
      MenuLibraryViewState.swift
    SessionPrep/
      SessionPrepScreen.swift
      SessionPrepContent.swift
      SessionPrepViewState.swift
    ActiveSession/
      ActiveSessionScreen.swift
      ActiveSessionContent.swift
      ActiveSessionViewState.swift
    Completion/
      CompletionScreen.swift
      CompletionContent.swift
      CompletionViewState.swift
    Settings/
      SettingsScreen.swift
      SettingsContent.swift
      SettingsViewState.swift
    Record/
      RecordPlaceholderScreen.swift
  Models/
    Domain/
      StretchRoutine.swift
      StretchPose.swift
      UserStats.swift
      DailyRecommendation.swift
      SessionState.swift
      ReminderSettings.swift
      PremiumPlanState.swift
    Enums/
      BodyPart.swift
      SceneTag.swift
      RoutineDifficulty.swift
      MoodOption.swift
      PremiumStatus.swift
  Mock/
    MockData.swift
    MockRoutines.swift
    MockSession.swift
    MockSettings.swift
    PreviewScenarios.swift
  Assets/
    Assets.xcassets/
      Colors/
      Icons/
      Illustrations/
      Mascots/
      Placeholders/
```

### 各ディレクトリの責務

- `App/`: app 起動、Tab、ルーティング、依存注入
- `DesignSystem/`: token、theme、共通 modifier
- `Components/`: Feature 非依存の共通 UI
- `Features/`: 画面単位の構成と state
- `Models/`: 画面共通で使う domain model
- `Mock/`: preview と開発用の fixture
- `Assets/`: 色、アイコン、イラスト、mascot

### 命名規則

#### Swift ファイル

- 画面: `HomeScreen.swift`
- 画面内分割: `HomeContent.swift`
- view state: `HomeViewState.swift`
- 共通 UI: `RoutineCard.swift`

#### Asset 名

- stretch illustration: `illust_stretch_neck_side`
- pose reference: `illust_pose_seated_front`
- focus overlay: `illust_focus_neck_left_soft`
- mascot: `mascot_greeting_small`
- mascot breathing: `mascot_breath_small`
- mascot celebrate: `mascot_celebrate_small`
- mascot sleep: `mascot_sleep_small`
- body icon: `icon_body_neck`
- scene icon: `icon_scene_sleep`
- placeholder: `placeholder_illust_routine`
- color set: `color_background_base`

### Asset 管理ルール

1. `Illustrations` と `Mascots` を分ける
2. stretch asset は意味単位で命名し、連番にしない
3. 将来差し替えしやすいよう、view 側で asset 名をハードコードしない
4. 部位ハイライトは base pose と overlay を分けられる余地を残す
5. placeholder 用 asset を正規 asset と同階層に置く

---

## Task 8: 実装タスク分割

### 目的

- Codex が順に作業できるように、依存関係を考慮した実装手順にする

### やること

- Phase 1〜7 に分けてタスクを設計する
- 各タスクに目的、着手条件、作業内容、完了条件を付ける
- 30〜90 分単位の小タスクにする

### 成果物

- 実装ロードマップ
- 小タスク一覧
- 完了条件つきチェックリスト

### 実装ロードマップ

#### Phase 1: DesignSystem

##### Task 8-1

- 目的: App shell の最小骨格を作る
- 着手条件: リポジトリ初期化済み
- 作業内容: `NobiHabitApp`, `AppRootView`, `AppTab`, 仮の `RecordPlaceholderScreen` を作る
- 完了条件: 4 タブの空画面が表示できる

##### Task 8-2

- 目的: color / typography / spacing token を定義する
- 着手条件: App shell がある
- 作業内容: `DesignSystem/Tokens` を追加し、色・文字・余白を実装する
- 完了条件: View 側で直接値を書かずに token 参照できる

##### Task 8-3

- 目的: 共通背景とカード外観を統一する
- 着手条件: Token 定義済み
- 作業内容: `BackgroundContainer`, `SurfaceCard`, 共通 modifier を作る
- 完了条件: どの画面でも同じ背景とカードスタイルを適用できる

#### Phase 2: Shared Components

##### Task 8-4

- 目的: 基本操作コンポーネントを揃える
- 着手条件: `SurfaceCard` 完了
- 作業内容: `PrimaryButton`, `SecondaryButton`, `BodyPartChip`, `SceneChip`, `FilterTab` を作る
- 完了条件: selected / disabled 差分が preview で確認できる

##### Task 8-5

- 目的: 情報カードを揃える
- 着手条件: 基本操作コンポーネント完了
- 作業内容: `SectionHeader`, `StatCard`, `RoutineCard`, `SettingRow` を作る
- 完了条件: 一覧画面と設定画面の骨格に流用できる

##### Task 8-6

- 目的: セッション専用 UI を揃える
- 着手条件: カード群完了
- 作業内容: `ProgressRing`, `TimerView`, `MascotBadge`, `MascotInlineHint`, `IllustrationCard` を作る
- 完了条件: 実施中画面の主要パーツが単体 preview できる

#### Phase 3: Models and Mock Data

##### Task 8-7

- 目的: domain model を整える
- 着手条件: 共通 UI の基本がある
- 作業内容: `StretchRoutine`, `StretchPose`, `SessionState`, `UserStats`, 各 enum を定義する
- 完了条件: 各 Feature の state に使える最小モデルが揃う

##### Task 8-8

- 目的: Preview 用 fixture を揃える
- 着手条件: model 定義済み
- 作業内容: `MockData`, `MockRoutines`, `MockSession`, `PreviewScenarios` を作る
- 完了条件: 各 screen preview が API なしで表示できる

#### Phase 4: Home / Menu

##### Task 8-9

- 目的: ホームを先に形にする
- 着手条件: 共通 UI と mock data がある
- 作業内容: greeting, stats, 今日のおすすめ, 部位 chip, 続きからを組む
- 完了条件: ホームがデザイン方向性に沿って表示される

##### Task 8-10

- 目的: メニュー画面を実装する
- 着手条件: `RoutineCard` と `FilterTab` が完成済み
- 作業内容: カテゴリ切替, ルーチン一覧, シーン導線, premium lock を組む
- 完了条件: 通常 / premium / custom empty の 3 state が preview できる

#### Phase 5: Pre-start / Active Session

##### Task 8-11

- 目的: 開始前画面を実装する
- 着手条件: `IllustrationCard` と `TimeOptionSegment` がある
- 作業内容: hero, summary, 含まれるストレッチ, 時間変更, CTA を組む
- 完了条件: 時間変更に応じて表示文言が切り替わる

##### Task 8-12

- 目的: 実施中画面を実装する
- 着手条件: `ProgressRing`, `TimerView` が完成済み
- 作業内容: current pose, timer, breathing hint, next card, pause/skip state を組む
- 完了条件: active / paused / final pose の preview が揃う

#### Phase 6: Completion / Settings

##### Task 8-13

- 目的: 完了画面を実装する
- 着手条件: `MoodOptionChip` と `StatCard` がある
- 作業内容: 完了 hero, 気分記録, 統計, 明日のおすすめを組む
- 完了条件: mood 未選択 / 選択済みの両 state を確認できる

##### Task 8-14

- 目的: 設定・premium を実装する
- 着手条件: `SettingRow`, `PremiumUpsellCard` がある
- 作業内容: 通知、音、その他、premium card を組む
- 完了条件: premium 未加入 / 加入済みの両 state を表示できる

#### Phase 7: Polish

##### Task 8-15

- 目的: Accessibility と空状態を整える
- 着手条件: 6 画面が表示済み
- 作業内容: VoiceOver label, 44pt target, empty states, denied permission state を入れる
- 完了条件: 主要操作にアクセシビリティラベルがつき、空状態の見た目が破綻しない

##### Task 8-16

- 目的: 上品な polish を入れる
- 着手条件: 主要機能完成
- 作業内容: 最小限の animation, shadow 微調整, placeholder asset, Tab bar 調整
- 完了条件: 派手すぎず、資料のトーンに近い完成度になる

### 完了条件つきチェックリスト

- [ ] 4 タブの App shell がある
- [ ] Token による色・余白・文字サイズ管理ができる
- [ ] 共通カードとボタンが揃っている
- [ ] mock data だけで主要画面 preview が表示できる
- [ ] ホームとメニューがつながる
- [ ] 開始前から実施中へ遷移できる
- [ ] 完了画面で mood 記録ができる
- [ ] 設定画面で toggle と premium card が表示できる
- [ ] empty / locked / paused の state がある
- [ ] Accessibility の最低限が満たされている

---

## Task 9: SwiftUI 実装ルール

### 目的

- 実装のブレを防ぐ

### やること

- View の責務分割、state 管理、preview、magic number 回避、token 利用、placeholder、animation をルール化する

### 成果物

- 実装ルールガイド
- やってはいけない実装例

### 実装ルールガイド

#### View の責務分割

1. `Screen` は画面全体の構成と遷移だけを持つ
2. 繰り返し使う見た目は `Components` に切り出す
3. 1 つの View で layout / business logic / asset lookup を同時に持たない
4. `body` が 150 行を大きく超える前に分割を検討する

#### State 管理の基本方針

1. 画面ローカル state は `@State`
2. 親子の単純な選択状態は `@Binding`
3. ルーチン一覧や session の共有状態は root から明示注入する
4. MVP では過剰な ViewModel 層を作らない
5. iOS 17+ 前提なら `@Observable` を優先し、必要になった時だけ導入する

#### Preview の書き方

1. 全 screen で最低 2 パターン以上 preview を持つ
2. `default / empty / locked / paused / completed` の代表 state を揃える
3. preview は本番 asset 名に近い mock を使う
4. preview 用にネットワークやストレージ依存を持ち込まない

#### Magic Number を避ける方針

1. 余白、角丸、影、色、文字サイズを直接値で書かない
2. 例外はイラスト比率など token 化しにくいものだけに絞る
3. イラストサイズも可能な限り `LayoutSpec` にまとめる

#### Design token を直接値でベタ書きしない方針

1. `Color(red:...)` を View に書かない
2. `.font(.system(size: 15))` を繰り返さない
3. `padding(16)` をその場で増殖させない

#### placeholder image の扱い

1. asset 欠けを前提に placeholder slot を用意する
2. placeholder は neutral silhouette とし、安っぽい仮画像を避ける
3. 本番と同じ枠サイズで表示崩れを防ぐ

#### アニメーション方針

1. 150〜240ms の短い opacity / scale / ring trim を中心にする
2. spring を使う場合も強すぎる反発は避ける
3. 完了画面は静かな祝福に留める
4. `Reduce Motion` で縮退できるようにする

#### シャドウやグラデーション

1. シャドウは `cardSoft` と `heroSoft` 程度に絞る
2. グラデーションは基本使わず、必要時もごく淡くする
3. premium card を金色や強い発光にしない

#### 将来の API / ローカル保存への伸びしろ

1. screen は `MockData` と本番 repository を差し替えられるようにする
2. domain model と UI 表示文言を分離する
3. `SessionState` は timer と persistence に拡張しやすい struct で持つ

### やってはいけない実装例

1. View 内に色コードや padding 数値を直書きする
2. 画面ごとに微妙に違う card style を乱立させる
3. mascot を毎セクションに出して主役化する
4. premium lock を暗いオーバーレイで強くブロックする
5. session 画面で情報を増やしすぎて「今やること」がぼやける
6. 完了画面で派手な祝福アニメーションを入れて世界観を崩す
7. 1 画面に複数の boolean sheet state を持ち込む
8. preview が 1 state しかなく、空状態や lock 状態が未確認のまま進める

---

## Task 10: 今後の拡張ポイント整理

### 目的

- 今回の設計を将来の成長につなげる

### やること

- 今回は実装しないが将来追加しやすい設計ポイントを整理する
- どの設計判断が将来効くか明記する

### 成果物

- 将来拡張メモ
- 今回仕込んでおくべき余白

### 将来拡張メモ

| 拡張項目 | 今回の設計で効く判断 | メモ |
| --- | --- | --- |
| Custom Routine Editor | `StretchRoutine` と `StretchPose` を value model で切っている | 編集 UI を別 Feature で追加しやすい |
| Premium Content Lock | `isPremium` と `PremiumPlanState` を分離 | lock 表示と entitlement 判定を切り替えやすい |
| Reminder Onboarding | `ReminderSettings` を独立 model にしている | onboarding flow を後から足せる |
| HealthKit 連携 | `UserStats` を集約している | total time / session count を後で統合しやすい |
| Streak Celebration Animation | 完了画面の hero を component 化する | 演出だけ局所追加できる |
| Mascot Variation System | `MascotBadge` を variant で切る | 季節差分や状態差分を増やしやすい |
| Illustration 差し替え基盤 | asset 名を model 側で持つ | 新イラスト投入時に View 修正を減らせる |
| Localization | 文言を screen 内で閉じ込めすぎない | Localizable 化しやすい |
| Dark Mode | semantic token を採用 | 見た目名依存を避けられる |
| 記録タブの本実装 | Tab 枠を先に確保 | 履歴、カレンダー、統計詳細へ拡張しやすい |

### 今回仕込んでおくべき余白

1. `Record` タブを placeholder でも用意する
2. asset 名はポーズの意味ベースにする
3. premium 判定は UI 分岐から切り離して model に寄せる
4. 通知許可状態は settings model に持つ
5. 完了画面は mood 記録領域を後で増やせるよう section で分ける
6. session 画面は pause / skip 以外の操作を増やしすぎない
7. color token を light 固定値で終わらせず意味名で持つ

---

## Task 11: 最終まとめ

### 目的

- ここまでの内容を、すぐ作業開始できる形で総括する

### やること

- デザインシステム要約、コンポーネント一覧、画面別仕様要約、ファイル構成、実装順序、仮定事項、リスクをまとめる
- 最初に着手すべき具体タスク 5 個を提示する

### 成果物

- 実装開始用サマリー
- 最初の着手タスク 5 個

### 1. デザインシステム要約

- 背景は暖かいアイボリー
- 主役色はセージグリーン
- 補助は淡いブルーとコーラル
- カードは薄いボーダーと浅い影
- タイポは静かな system sans 中心
- mascot は小さな案内役
- 人物イラストは painterly でマット、医療感を出さない

### 2. コンポーネント一覧

- `AppScaffold`
- `BackgroundContainer`
- `SectionHeader`
- `SurfaceCard`
- `StatCard`
- `RoutineCard`
- `BodyPartChip`
- `SceneChip`
- `FilterTab`
- `PrimaryButton`
- `SecondaryButton`
- `ProgressRing`
- `TimerView`
- `MoodOptionChip`
- `SettingRow`
- `PremiumUpsellCard`
- `MascotBadge`
- `MascotInlineHint`
- `IllustrationCard`
- `TimeOptionSegment`

### 3. 画面別仕様要約

- ホーム: 今日のおすすめを最優先に見せる
- メニュー: ルーチン選択を穏やかに整理する
- 開始前: 内容理解と時間調整に集中する
- 実施中: 今の動きと残り時間だけを強く見せる
- 完了: 静かな達成感と気分記録
- 設定: 毎日続けるための実用設定 + premium

### 4. ファイル構成

- `App/`
- `DesignSystem/`
- `Components/`
- `Features/Home`
- `Features/MenuLibrary`
- `Features/SessionPrep`
- `Features/ActiveSession`
- `Features/Completion`
- `Features/Settings`
- `Features/Record`
- `Models/`
- `Mock/`
- `Assets/`

### 5. 実装順序

1. App shell
2. Design tokens
3. 共通カードとボタン
4. Models + MockData
5. Home / Menu
6. SessionPrep / ActiveSession
7. Completion / Settings
8. Accessibility と polish

### 6. 仮定事項

1. iOS 17+ を推奨前提にする
2. 独立した記録タブは今回は placeholder とする
3. 人物イラストは画像 asset 前提とする
4. dark mode は今回は非対応だが token は対応可能な形で組む
5. 本仕様は iPhone 縦持ち最適化を優先する

### 7. リスク

1. 低コントラストを優先しすぎると可読性が落ちる
2. mascot を増やしすぎると世界観が幼くなる
3. premium 訴求を弱くしすぎると導線が埋もれる
4. イラスト asset の品質差が UI 全体の品位に直結する
5. 記録タブを後回しにしすぎると Tab 構成の再設計コストが出る

### 最初に着手すべき具体タスク 5 個

1. `App/` と 4 タブの最小 shell を作る
2. `DesignSystem/Tokens` に color / typography / spacing / radius を定義する
3. `SurfaceCard`, `PrimaryButton`, `RoutineCard`, `StatCard` を先に実装する
4. `StretchRoutine`, `StretchPose`, `SessionState`, `MockData` を作る
5. `HomeScreen` と `MenuLibraryScreen` を preview 付きで先行実装する

---

## I. 不明点・仮定事項

### 不明点

1. 対応 OS の下限
2. `記録` タブを今回どこまで実装するか
3. premium の価格表示や課金導線の具体仕様
4. リマインダーの曜日単位設定が MVP に必要か
5. 実イラスト asset の納品粒度と差し替えスケジュール

### 仮定事項

1. まずは静的 mock data で全画面を成立させる
2. 記録タブは placeholder で着地して問題ない
3. セッションは 1 ルーチン内の順送り再生を基本とする
4. mascot は 4 バリエーションで MVP を構成する
5. プレミアムは設定画面を主訴求面とする
