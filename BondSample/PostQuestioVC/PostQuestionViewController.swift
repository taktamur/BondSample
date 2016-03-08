//
//  PostQuestionViewController.swift
//  BondSample
//
//  Created by 田村孝文 on 2016/03/06.
//  Copyright © 2016年 田村孝文. All rights reserved.
//

import UIKit

class PostQuestionViewController: UIViewController {
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    let questionModel:QuestionModel=QuestionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // model → viewへのイベントを接続
        // self.questionModel で何かの状態が変わったらViewに反映させるための
        // ルールを設定しておく。
        // ViewModelそのものは、「ルール」の登録を行うだけで、
        // ほとんど何もしていない。
        // 
        // viewModelというより、「画面ロジックの登録」係、builderパターンに近い？
        let viewModel = ViewModel(self.questionModel)
        viewModel.bindToQuestionText(self.questionTextView)
        viewModel.bindToSubmitButton(self.submitButton)
        viewModel.bindToCounter(self.counterLabel)
        viewModel.bindToMessage(self.messageLabel)
        viewModel.bindToNetworkIndicator()
        
        // view→Modelへのイベントを接続
        self.questionTextView.bnd_text
            // ここ、絶対何か別の書き方があるはず。
            // .flatMapが使えそう？strategyってなんや？
            .filter{$0 != nil}
            .map{
                if let s = $0 {
                    return s
                }else{
                    return ""  // ここには来ない。
                } }
            .bindTo(self.questionModel.text)

        // ボタンタップのイベントも、Bondで拾う事ができる。
        self.submitButton.bnd_tap
            .observe( self.questionModel.post )
        // post()メソッドが、() -> Void な関数なので、そのままobserveの引数にできる。
        // ↓のように書いてもいける
        //  .observe{ self.questionModel.post() }

    }
    
}
