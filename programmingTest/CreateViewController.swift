//
//  CreateViewController.swift
//  programmingTest
//
//  Created by Atsushi on 2018/07/19.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController {
    
    @IBOutlet weak var word: UITextField!
    
    @IBOutlet weak var detail: UITextView!
    
    let wordsManage = WordsManage()
    
    @IBAction func tapDoneBtn(_ sender: Any) {
        wordsManage.create(title: word.text!, detail: detail.text!)
        
        //一つの前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }

}
