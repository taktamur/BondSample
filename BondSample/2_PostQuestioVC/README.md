サンプル2_質問の投稿画面
----

知恵袋等への、質問投稿画面のサンプルです。
この投稿画面は、以下のルールが実装されています。

- テキストが5文字以上ないと、投稿ボタンは押せない
- テキストの文字数を表示する。
- 投稿中は画面をロックする（テキストとボタン）
    - ロックされてる時は、テキストの文字は灰色にする
- 投稿に成功したら、投稿成功したというメッセージを出す。テキストは消す
- 投稿に失敗したら、投稿失敗したというメッセージを出す。テキストはそのまま
- メッセージ部分はアニメーションする
- 投稿中（通信中）は、NetworkIndicatorを回す

サンプルでは通信そのものはせずに、「通信しているつもり」な実装になっています。テキストの長さが奇数の時は投稿失敗、偶数の時は投稿成功となります。

![](https://raw.githubusercontent.com/taktamur/BondSample/master/BondSample/2_PostQuestioVC/2_PostQuestion.gif)

接続状態
![](https://raw.githubusercontent.com/taktamur/BondSample/master/BondSample/2_PostQuestioVC/image.jpeg)
