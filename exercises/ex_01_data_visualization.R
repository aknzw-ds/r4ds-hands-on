# ==============================================================================
# Exercise 01: Data Visualization
# ==============================================================================
library(tidyverse)

# --- 1.1 はじめに --------------------------------------------------------

# --- 1.2 第1ステップ -----------------------------------------------------

# Q1. ggolot(data = mpg)を実行しなさい
ggplot(data = mpg)
# 空グラフが作成される

# Q2. mtcarsには何行あるか
dim(mtcars)

# Q3. drv変数は何を記述するか。?mpgのヘルプを読んで見つけなさい
?mpg
# the type of drive train, 車の駆動方式（ドライブトレイン）を表す記号、エンジンの位置やどのタイヤを動かすかを示しています
# where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# f: Front-wheel drive（前輪駆動）r: Rear-wheel drive（後輪駆動）4: 4-wheel drive（四輪駆動・4WD）

# Q4. hwyとcylの散布図を作りなさい
ggplot(data = mpg) +
  geom_point(aes(x = hwy, y = cyl))

# Q5. class対drvの散布図はどうなるか。なぜプロットが役に立たないか。
ggplot(data = mpg) +
  geom_point(aes(x = class, y = drv))
# カテゴリ変数を用いているため

# --- 1.3 エステティックマッピング ------------------------------------------------

# Q1. 次のコードはどこがおかしいか。なぜ点が青になっていないのか。
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy, color = "blue")
  )
# Q1.A
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy), color = "blue")

# Q2. mpgのどれがカテゴリ変数か。どれが連続変数か。（？mpgと入力してデータセットの<br>
# ドキュメントを読む）mpgを実行した時、この情報がどのようにして得られるか。
str(mpg)
# カテゴリ変数 : chr
# 連続変数 : int

# Q3. 連続変数をcolor, size, shapeにマップしてみる
# color グラデーションになる
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))

# size サイズは整数に丸められて作成される
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = year))

# shape エラーになる。形状（shape）に連続変数を割り当てることはできない
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = year))

# Q4. １つの変数に複数のエステティック属性をマップするとどうなるか
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy,
                           color = year, size = year))
# 属性が重ね付けされ、凡例は設定したそれぞれについて表示される

# Q5. エステティック属性strokeは何をするか、どんな形に作用するか
# 	stroke	→ via theme()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
             shape = 21, fill = "white", color = "black", stroke = 1)
# pointの枠線の大きさが変更される

# Q6. エステティック属性を変数名以外にマップするとどうなるか
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
# 変数に設定されている属性の真偽判定を行い新しいカテゴリで実行される

# --- 1.4 よくある不具合 ---------------

# --- 1.5 ファセット -------------------

# Q1. 連続変数を指定してファセット（facet_wrap）を作るとどうなるか。
# (例: displ や hwy などを指定してみる)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(hwy ~ .)
# 指定した変数の値がプロットされる（１変数のプロット）
# 存在する数値の数だけ、無限にグラフが分割される

# Q2. facet_grid(drv ~ cyl) で作ったグラフに、いくつか「空のマス（プロットがない場所）」
# があるのはなぜか。次のコードを実行した結果とどう関係しているか。
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl)) #+
  # facet_grid(drv ~ cyl)
# facet_gridの抽出結果が０なので空プロットが返ってきている


# Q3. 次のコードはそれぞれどんなグラフを描くか。「.」は何をしているか。
# グラフ1
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

# グラフ2
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# 「.」により行（横方向）や列（縦方向）のレイアウトを指定しています　１：行　２：列


# Q4. 今回学んだ最初のファセットグラフ（下記）を、ファセットではなく「色（color）」
# でクラス分けしたグラフと見比べたとき、ファセットを使うメリットとデメリットは何か。
# 変数がもっと多かったらどうなるか。
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)
# A. メリット：データが重ならないので、属性ごとの分布の可視化ができる
# A. デメリット：色で設定すると全体の傾向が見えるがファセットからは読めない。
# A. 変数が多いと１つ１つのプロットが潰れて読めない。


# Q5. ?facet_wrap を実行してヘルプを読め。
# nrow は何をするか。ncol は何をするか。
# facet_grid() にこれらの引数がないのはなぜか。

# A. １変数を指定の行（nrow）列（ncol）で並べるため
# A. facet_gridは２変数対象でマトリクスが強制的に決まるため。


# Q6. facet_grid() を使うとき、drv や cyl のようにユニークな値（水準）の数が
# 多い変数は、行（縦）と列（横）のどちらに配置すべきか。なぜか。

# A. 行に配置。グラフのY軸（高さ）を比較する際に横方向が理解しやすいため

# --- 1.6 幾何オブジェクト -----------------------------------------------------

# Q1. 次のグラフを描くには、それぞれどのgeom（geom_関数）を使うべきか。
# ① 折れ線グラフ (Line chart)
ggplot(data = mpg) +
  geom_line(mapping = aes(x = displ, y = hwy))
# ② 箱ひげ図 (Boxplot)
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = manufacturer, y = displ)) +
  theme(axis.text.x = element_text(angle = 90))
# ③ ヒストグラム (Histogram)
ggplot(data = mpg) +
  geom_histogram(mapping = aes(x = displ))
# ④ 面グラフ (Area chart)
ggplot(data = mpg) +
  geom_area(mapping = aes(x = year, y = displ, fill = class))

# Q2. 次のコードを実行すると、頭の中でどのようなグラフが描かれるか（予想せよ）。
# 予想をメモしたあと、実際に実行して結果を確認せよ。
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
# （予想）colorが無視されて散布図と近似曲線が追加される
# （結果）双方にcolorが適用される。shapeで確認したら、geom関数にない場合は無視されるだった


# Q3. geom_smooth() などの引数に `show.legend = FALSE` を設定すると何が起きるか。
# 削除するとどうなるか。なぜこれまでのコードで著者はこれを使ったと思うか。
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))
# 判例の表示/非表示を操作する、groupが多いと煩雑になるため

# Q4. geom_smooth() の `se` 引数は何をするものか。

# A. 標準誤差に基づく信頼区間の表示/非表示の設定

# Q5. 次の2つのコードが生成するグラフは、見た目が異なるか、同じか。
# なぜそうなるのか、理由も答えよ。
# コードA：
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# コードB：
ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# A. 最初のレイヤー（ggplot）で設定して部分レイヤーを重ねるか、
# 空のレイヤーに部分レイヤーごとの設定を上書きしているかの違いで
# 設定内容は同じなため出力が同じ

# Q6. 次のグラフを描くRコードをそれぞれ書け。
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, fill = drv)) +
  geom_point(color = "white", stroke = 1, shape = 21, size = 3)

# --- 1.7 統計変換 -----------------------

# Q1. stata_summary()のデフォルトgeomは何か。stat関数ではなくgeom関数を用いて
# 　　先ほどのコードを書き直すには
# A1. geom = "pointrange"
ggplot(data = diamonds, mapping = aes(x = cut, y = depth)) +
  geom_pointrange(
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )

# Q2.　geom_col()は何をするかgeom_bar()とはどのように異なるか。
# A. geom_col()はstat = "identity"をデフォルト値に持つ
diamonds %>% count(cut) %>%
  ggplot() + geom_col(aes(x = cut, y = n))

ggplot(diamonds) + geom_bar(aes(x = cut))

# Q3.　geomとstatの対リスト作成
# geom:座標の値をそのまま図形にする。statを呼び出す。
# stat:統計処理等の計算が自動でされる。geomを呼び出す。
geom_stat_list <- read.csv("./data/geom_stat.csv")
head(geom_stat_list)
# 番号             geom            stat                          description
#     1     geom_point() stat_identity()                   散布図（点を打つ）
#     2      geom_line() stat_identity()                         折れ線グラフ
#     3       geom_bar()    stat_count()         棒グラフ（個数を自動で集計）
#     4       geom_col() stat_identity()   列グラフ（集計済みの値を棒にする）
#     5 geom_histogram()      stat_bin() ヒストグラム（データを区切って集計）
#     6   geom_boxplot()  stat_boxplot()                             箱ひげ図

# Q4. stat_smooth()はどの変数を計算するか。どの引数が制御するか。
# A. yまたはxの予測値、ymin/ymaxの自信区間の下限と上限、seの標準誤差
# 　 spanやmethodで制御する。

# Q5. 次の２つのグラフの問題は何か。
# A. group = 1 がないと、カットごとに100%の棒が並ぶだけで、全体の割合が分からない
# 　group = 1で分母が全体に、group = factor＋position = "fill"でx項目を分母に計算する
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = after_stat(prop), group = 1))
# A.　fill = color を指定したことで自動的に色ごとにグループ化されてしまい、
# group = 1 がないため、各カットにおける各色の比率（prop）が正しく計算されず、
# すべての棒の高さが1（100%）になって重ね書きされてしまうのが問題。
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = color, y = after_stat(prop))
  )

# --- 1.8 位置調整 -------------------------
# Q1. 散布図の問題は何か。どうすれば改善できるか。
# A. 値が重なっているので、各座標に乱数を加え位置調整をすることで見えやすくなる。
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )

# Q2. geom_jitter()のどの引数がジッターの量を制御するのか。
# A. widthとheight

# Q3.　geom_jitter()とgeom_count()を比較しなさい。
# A. geom_jitter()は各点をプロットするのに対し、とgeom_count()は合計ちのプロットをする。
ggplot(data = mpg) +
  geom_jitter(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )
ggplot(data = mpg) +
  geom_count(mapping = aes(x = displ, y = hwy))

# Q4.　geom_boxplot()のデフォルトの位置調整は何か。mpgを可視化しなさい。
# A.　position = "dodge2"
# 　　通常の "dodge" はグループ化の指定が必要ですが、
# 　　"dodge2" は要素のデータ自体から自動で判断して横並びにしてくれます。
ggplot(mpg, aes(class, hwy)) +
  geom_boxplot()

# --- 1.9 座標系 -------------------------
# Q1. 積み上げ棒グラフを円グラフに変換
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  coord_polar()

# Q2. labs()の作用
# 既存のタイトルや軸のラベルなどを任意の名前で上書き出来る

# Q3. coord_quickmap()とcoord_map()の違い
# A. coord_map() は地球の球体を正確に平面に投影するため計算が重いです。
#  一方、coord_quickmap() は直線を直線として素早く近似計算するため、
#  圧倒的に軽くて速いという実務上の大きなメリットがあります。
#  実務の地図プロットでは、まず quickmap を使うのが定石です。

# Q4. 次のプロットから何が読み取れるか。coord_fixed()の重要性とgeom_abline()の作用
# A. 対角線（geom_abline()）よりすべての点（プロット）が上側にあります。
#   これは「どの車も、街乗り燃費（cty）より高速道路の燃費（hwy）の方が絶対に良い」
#   という、データの持つ重要なビジネス的意味を綺麗に読み解けている証拠です。
#   また、coord_fixed() があるおかげで「ctyの1目盛り」と「hwyの1目盛り」の
#   物理的な長さが同じになり、視覚的な歪み（ウソ）がなくなっています。
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()

# --- 1.10 階層グラフィックス文法 -------------------------
# テキストはまとめのみ
