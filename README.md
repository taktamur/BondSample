# BondSample
SwiftBondを勉強するために作ったサンプルプロジェクトです。
SwiftBond →[https://github.com/SwiftBond/Bond](https://github.com/SwiftBond/Bond)

- [1_HelloBond](https://github.com/taktamur/BondSample/tree/master/BondSample/1_HelloBond)
  - Observable と map() と bindTo()だけを使って触ってみたサンプル
- [2_PostQuestion](https://github.com/taktamur/BondSample/tree/master/BondSample/2_PostQuestioVC)
  - QAサイトに投稿する画面っぽいものを、SwiftBondで作ってみたサンプル

# SwiftBondを触ってみての感想
記録としてのメモ書きです。飽きるまで増えていきます。

- 画面のロジックを、「イベントの変換」として「繋げていく」やり方はとても良いと思う。
- 簡単にbindTo()で繋げる事ができるため、ここが混線する事がある。
  - とくに１つのObservableに対して複数からbindTo()すると、どのEventで値が変わったのかがわかりにくくなる。
  - NSNotificationCenterを乱用した時と同じような複雑さが発生しうる。
  - また簡単にループも作れてしまう。最悪無限ループに陥る？
- 混線しないように、設計段階での方針が重要になると思われます。
  - 主役のObservableを決め、他は「それに追従する」ようにした方が良さそう。王は二人要らない。
  - クラスのプロパティとして公開するObservableは最小にした方が良さそう
- Observable<T>は、「T型の値を保持し、新しい値が代入されたら通知を飛ばす」もの。
  - Tはいろいろ。StringやIntやMyEnum。Optional型も入る
  - 新しい値の代入は、Observable.next()で行う。
  - String型やInt型が、通知を飛ばしているわけではなくて、ラッピングしているObservableが飛ばしている。
- Observable<T>は、ありとあらゆる「変数」「プロパティ」として使えてしまうが、使いすぎると混乱する 
  - クラスのプロパティにObservable<T>を並べるのは、オススメしない。。。。混線して後悔しました。  
- まだ良くわかっていない事：
  - disposeBag()はまだ良くわかっていない。bindToで「配線した」ルールを「切断」するためのモノだと思うけど。
  - リアクティブプログラミングで「ストリーム」と呼ばれているモノは、SwiftBondで言うObservableに該当しそう。「時間軸」は.next()
    - よくある図→ https://gist.githubusercontent.com/staltz/868e7e9bc2a7b8c1f754/raw/b580ad4a33b63acb2ced9b8e5e90faab8ca7ef26/zmulticlickstream.png
  - 言葉の揺らぎ：田村的には、bindTo()やobserve()は「接続する」「配線する」という、ケーブルの配線に例えるのがしっくりきているが、この辺どうなのだろう？
- これから調べていきたい：
  - Observable->map->bindTo した時と、イベントが発生した時に、どんな処理が行われるのか。
  - 用意されている変換(transform)のバリエーション(mapやfilter等など)

# 参考にしたページ
- [【翻訳】あなたが求めていたリアクティブプログラミング入門](http://ninjinkun.hatenablog.com/entry/introrxja)
- 
