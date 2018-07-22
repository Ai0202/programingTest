//
//  DetailViewController.swift
//  programmingTest
//
//  Created by Atsushi on 2018/07/12.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var word: UITextField!
    
    @IBOutlet weak var detail: UITextView!
    
    var selectedNumber = Int()
    
    var selectedWord = [String: String]()
    
    let wordsManage = WordsManage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedWord = wordsManage.getSelected(selectedNumber: selectedNumber)
        
        setWord()
        
    }
    
    @IBAction func tapUpdate(_ sender: Any) {
        wordsManage.update(originalTitle: selectedWord["title"]!, newTitle: word.text!, newDetail: detail.text!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func setWord() {
        word.text! = selectedWord["title"]!
        detail.text! = selectedWord["detail"]!
    }
    
}
