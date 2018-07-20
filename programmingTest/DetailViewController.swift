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

    var selectedNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let selectedWord = getSelectedWord()
        
//        print(selectedWord)
    }
    
    func getSelectedWord() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        
    }

}
