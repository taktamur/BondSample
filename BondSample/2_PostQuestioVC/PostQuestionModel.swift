//
//  QuestionModel.swift
//  BondSample
//
//  Created by 田村孝文 on 2016/03/06.
//  Copyright © 2016年 田村孝文. All rights reserved.
//

import Foundation
import Bond

enum PostEvent{
    case Posting
    case Success
    case Failed
}

class PostQuestionModel{
    // Observalbeは「値」を保持できる。
    // 一方Eventは「その瞬間にあった何か」を表している。
    // そのため、ObservableにEventを保持しておく事に気持ち悪さを感じた。
    //
    // ここでは、Optional型を保持しておいて、
    // 変数名を「latestXXX」として、最後に発生したイベントだよと自己主張しつつ、
    // 初期状態はnilとしてみた。
    let latestPostEvent:Observable<PostEvent?> = Observable(nil)

    // ここ、最初はUITextViewと双方向バインディングするために、String? としていた。
    // ただ何かおかしい（ViewのためにModelの型が決まるのは何かおかしい）と思ったので、
    // 双方向バインディングは取りやめとした。
    let text:Observable<String> = Observable("")

    func post(){
        NSLog( "start posting... text=\(self.text.value)" )
        
        self.latestPostEvent.next(.Posting)
        // 通信しているつもり
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay) )
        dispatch_after(time,dispatch_get_main_queue(),{
            // textの長さで成功/失敗を振り分ける
            let s = self.text.value ?? ""
            if( s.characters.count % 2 == 0 ){
                // 成功のつもり
                // 通信し終わったらtextを削除
                self.text.next("");
                self.latestPostEvent.next(.Success)
            }else{
                // 失敗のつもり
                self.latestPostEvent.next(.Failed)
            }
        })
    }
}