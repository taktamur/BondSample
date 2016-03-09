//
//  HelloBondViewController.swift
//  BondSample
//
//  Created by 田村孝文 on 2016/03/08.
//  Copyright © 2016年 田村孝文. All rights reserved.
//

import UIKit
import Bond

class HelloBondViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!

    // 文字数の長さを一時保存しておくObervable<Int>
    private let lengthObservable:Observable<Int> = Observable(0);

    override func viewDidLoad() {
        super.viewDidLoad()

        // textFieldに入力された文字(=bnd_text)を、
        // そのままtextField2(=bnd_text)に入れる
        // bnd_textはObservable<String?>
        textField.bnd_text
            .bindTo(textField2.bnd_text)
        
        // textFieldの文字列を、「逆順」に変換して、
        // textField2のbnd_textに入れる
        // ここでいう変換(transform)は、SwiftBondの用語?
        //  https://github.com/SwiftBond/Bond#transforming-the-event-producers
        textField.bnd_text
            .map{ t in
                // ここはSwitBondとは関係ない、Swiftのテクニック
                // Optional型のmap関数を使って処理しています。
                // (BondのObservableのmap関数とは別物）
                //
                // tにはOptional<String>が入っている。
                // Optionalのmap関数は、nilの時にはnilを返し、
                // 値が入っている時にはその内容(v)に対しての操作となる
                t.map{ v in
                    String(v.characters.reverse())
                } }
            .bindTo(textField3.bnd_text)

        // textFieldの文字の文字数を一時保存するObservable
        // textFieldの文字列を、「文字数」に変換して
        // lengthObservableに一時保存
        textField.bnd_text
            .map{
                let s:String = $0 ?? ""
                return s.characters.count
            }
            .bindTo(self.lengthObservable)
        // 文字数をtextField4に反映
        self.lengthObservable
            .map{ "\($0)" }
            .bindTo(textField4.bnd_text)
        
        // 文字数に応じて、textField4の色を返る
        self.lengthObservable
            .map{
                let colors = [UIColor.redColor(),
                    UIColor.blueColor(),
                    UIColor.greenColor()]
                return colors[$0%colors.count]
            }.bindTo(textField4.bnd_textColor)
        
        // 大元のObservable(textFieldのbnd_text)を監視して、
        // いろいろ変形させて（.map関数）、
        // 他ObserbavleにbindToしているサンプルでした。
        
    }
}
