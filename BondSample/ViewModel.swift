//
//  ViewModel.swift
//  BondSample
//
//  Created by 田村孝文 on 2016/03/06.
//  Copyright © 2016年 田村孝文. All rights reserved.
//

import Foundation
import Bond

struct ViewModel{
    let questionModel:QuestionModel
    
    init(_ questionModel:QuestionModel){
        self.questionModel = questionModel
    }

    // bindToXXXX と分けている理由：
    // 複数箇所から同じインスタンス(bnd_xxx)にbindToすると、
    // 制御の流れがよくわからなくなり混乱するから。
    // 関数1つで、「1つのオブジェクトへのbindTo」という点を
    // 強調している。
    func bindToQuestionText(textField:UITextView){
        // 大元ModelのtestをtextFieldに反映させる
        self.questionModel.text
            .bindTo(textField.bnd_text);
        // 入力は通信以外の場合のみとする
        self.questionModel.latestPostEvent
            .map{$0 != .Posting}
            .bindTo(textField.bnd_userInteractionEnabled)
        // 入力可の時は黒に、そうでない場合はグレーにする
        // ↓UIKitのbnd_xxxも、入力元にすることができる
        textField.bnd_userInteractionEnabled
            .map{ $0 ? UIColor.blackColor() : UIColor.grayColor() }
            .bindTo(textField.bnd_textColor)
    }
    
    func bindToSubmitButton(button:UIButton){
        // 通信していなくて、かつ文字数が5文字以上の時のみ押せるようにする
        combineLatest(self.questionModel.latestPostEvent, self.questionModel.text )
            .map{ e,text in (e != .Posting)&&(text.characters.count>5) }
            .bindTo(button.bnd_enabled)
    }

    func bindToCounter(label:UILabel){
        // テキストの文字数をカウントする
        self.questionModel.text
            .map{
                let c = $0.characters.count ?? 0
                return c==0 ? "空です" : "文字数：\(c)" }
            .bindTo(label.bnd_text)
    }
    
    // NetworkIndicatorは特にbindToするインスタンスが無いが、
    // observeして
    // Application.sharedApplication.networkActivityIndicatiorVisible の値を書き換える。
    func bindToNetworkIndicator(){
        self.questionModel.latestPostEvent
            .map{ $0 == .Posting }
            .observe{
                UIApplication.sharedApplication().networkActivityIndicatorVisible = $0
        }
    }
    
    func bindToMessage(label:UILabel){
        // メッセージラベルには、通信の状態と結果を表示する
        self.questionModel.latestPostEvent
            .map{
                var s:String? = nil
                if let e = $0 {
                    switch e{
                    case .Posting: s = "投稿中..."
                    case .Success: s = "投稿完了！"
                    case .Failed: s = "投稿失敗しました.."
                    }
                }
                return s }
            .filter{ $0 != nil }
            // .observeは型を見失いがち？
            //         ↓ここで受け取る型を指定していないと、型推論が混乱した。
            .observe { (s:String?) -> Void in
                // アニメーションでふわっとさせる
                label.alpha = 0
                label.text = s
                UIView.animateWithDuration(0.3, animations: {
                    label.alpha = 1.0
                })
            }
    }
}