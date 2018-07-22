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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSelectedWord()
        
        setWord()
        
    }
    
    
    @IBAction func tapUpdate(_ sender: Any) {
        updateCoreData()
    }
    
    func getSelectedWord() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        do {
            let fetchResults = try manageContext.fetch(fetchRequest)
            
            var count = 0
            for result in fetchResults {
                
                if count == selectedNumber {
                    //1件ずつ取り出し
                    let title:String? = result.value(forKey: "title") as? String
                    let detail:String? = result.value(forKey: "detail") as? String
                    
                    selectedWord = ["title":title, "detail":detail] as! [String: String]
                }
                
                count = count + 1
            }
            
        } catch {
            print("read error", error)
        }
    }
    
    func setWord() {
        word.text! = selectedWord["title"]!
        detail.text! = selectedWord["detail"]!
    }
    
    func updateCoreData() {
        
    }
    
}
