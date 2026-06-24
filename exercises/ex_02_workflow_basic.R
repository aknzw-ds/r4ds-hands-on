# ==============================================================================
# Exercise 02: Workflow Basic
# ==============================================================================

# Q1. 次のコードの問題点
my_variable <- 10
my_varlable
# A. iがlになっていて違う変数名として扱われている。タブ機能で補完するとミスが少なくなる

# Q2. コマンドを修正
library(tidyverse)

ggplot(dta = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
# A. dta -> data
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
# A. = -> ==
fliter(mpg, cyl = 8)
filter(mpg, cyl == 8)
# A. diamond -> diamonds
filter(diamond, carat > 3)
filter(diamonds, carat > 3)

# Q3. Alt+Shift+kの作用とメニューからの操作
# A. ショートカットキー一覧が表示される。
# メニューからは[Tools] ＞ [Modify Keyboard Shortcuts...]
