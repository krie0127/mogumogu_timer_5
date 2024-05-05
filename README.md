## もぐもぐタイマー

## サービス概要
日々の食事の時間を計測し記録することで早食いを防止するサービスです。

## 想定されるユーザー層
忙しくてついつい早食いをしてしまう人。
自分がどれくらい食事の時間を取れているか把握できていない人。
ゆっくり食事をすることを習慣化したい人。

## サービスコンセプト

### ユーザーが抱えている課題感と提供するサービスでどのように解決するのか
時間がない時に無意識に早食いになる方は大勢いらっしゃると思います。
早食いが良くないことは皆さんご存知だと思いますが、ゆっくり食べることの継続は意外と難しいです。
早食いを改善するために実際に自分の食事にかけている時間を見える化することで防止できるのではないかと思います。

### なぜそのサービスを作ろうと思ったのか・どのようなサービスにしていきたいか
私自身、仕事をしながらプログラミングスクールに通い始めて、時間がなくなり味わってご飯を食べる機会が減りました。
元々食べることが好きだった私は食べる量も増えてしまい太ってしまいました。
食事制限をするよりも、食べ方を改善する方が手軽と考え、早食いを防止するアプリを作りたいと考えました。
また、リマインダー機能を利用し忘れることを防止した結果、日記の継続に成功した経験からラインでリマインダー機能を追加すれば継続の確率が上がると考えています。

### どこが売りになるか、差別化ポイントになるか
食事時間にフォーカスしたアプリを作成し、計測した時間を記録することで、日頃自分自身がどれくらい食事の時間を取れているのかを確認することで意識改善が期待されると思います。
継続する際に、完璧を求める・頑張りすぎると続かないと思うので、忙しい中でも手軽に利用してもらいたいです。

## 実装を予定している機能
### MVP
####  LINEログイン・ログアウト機能
####  ストップウォッチ機能
ログインしていないユーザーも使用できる機能です。
スタート・ストップボタンを押して簡単に食事時間を確認できます。
####  食事時間登録
ログインしているユーザーのみ保存ボタンが表示されます。
ストップボタンを押した後に保存ボタンを押すことで、食事時間が記録されます。
####  詳細ページ
1日の記録が表示されます。
朝ごはん、昼ごはん、夜ごはんのカテゴリーに分かれて食事時間を確認できます。
####  グラフ表示機能
記録した時間がが月間のグラフとして表示されます。
####  カレンダー機能
食事時間を記録した日付を確認することができます。
記録した日には🍙マークがつきます。
####  line通知機能
ユーザーが指定した時間を設定し、その時間に通知が来ます。
30分刻みで設定できます。（選択項目が、1分刻みで出たり30分刻みで出たりまちまちなのでこちらは今後修正します）

### その後の機能
* 目標設定機能
* 目標がランダムで表示される機能（一口の量を減らす、噛む回数をいつもより5回増やす、箸を置く、薄味の料理を食べる、ながら食べしない）
* 画像アップロード機能
* ゲストログイン機能

#### デモ動画

https://www.canva.com/design/DAGEWBb3ajo/pygJtizXYPxsw0FKGnBOIA/watch?utm_content=DAGEWBb3ajo&utm_campaign=designshare&utm_medium=link&utm_source=editor

![画面収録 2024-05-05 16 43 23](https://github.com/krie0127/mogumogu_timer_5/assets/130209491/559d757c-8cea-4b52-9985-fd519742564e)

