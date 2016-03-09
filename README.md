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
- まだ良くわかっていない事：
  - disposeBag()はまだ良くわかっていない。bindToで「配線した」ルールを「切断」するためのモノだと思うけど。
  - リアクティブプログラミングで「ストリーム」と呼ばれているモノは、SwiftBondで言う「Observable.next()」に該当するのか？
  - 言葉の揺らぎ：田村的には、bindTo()やobserve()は「接続する」「配線する」という、ケーブルの配線に例えるのがしっくりきているが、この辺どうなのだろう？
- これから調べていきたい：
  - Observable->map->bindTo した時と、イベントが発生した時に、どんな処理が行われるのか。
  - 用意されている変換(transform)のバリエーション(mapやfilter等など)
