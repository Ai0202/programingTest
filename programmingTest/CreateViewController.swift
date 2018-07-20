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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapDoneBtn(_ sender: Any) {
        create()
        
        //一つの前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    func create() {
        //多分CoreDataのpath確認用
        //let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print(urls[urls.count-1] as URL)
        
        let titleText = word.text!
        
        let detailText = detail.text!
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let words = NSEntityDescription.entity(forEntityName:"Words", in: manageContext)
        
        let newRecord = NSManagedObject(entity: words!, insertInto: manageContext)
        
        newRecord.setValue(titleText, forKey: "title")
        newRecord.setValue(detailText, forKey: "detail")
        
        do {
            try manageContext.save()
        } catch {
            print("error", error)
        }
    }

}
