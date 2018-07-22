//
//  Words.swift
//  programmingTest
//
//  Created by Atsushi on 2018/07/22.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct WordsManage {
    
    func create(title: String, detail: String) {
        let titleText = title
        
        let detailText = detail
        
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
    
    func readAll() -> [NSDictionary] {
        //AppDelegateのインスタンス化
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        //取り出し
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        var wordList:[NSDictionary] = []
        
        do {
            let fetchResults = try manageContext.fetch(fetchRequest)
            
            for result in fetchResults {
                
                //1件ずつ取り出し
                let title:String? = result.value(forKey: "title") as? String
                let detail:String? = result.value(forKey: "detail") as? String
                
                let dic = ["title":title, "detail":detail] as! [String: String]
                
                wordList.append(dic as NSDictionary)
            }
        } catch {
            print("read error", error)
        }
        return wordList
    }
    
    func delete(title:String) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        let predicate = NSPredicate(format: "title = %@", title)
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResults = try manageContext.fetch(fetchRequest)
            
            for result in fetchResults {
                manageContext.delete(result)
            }
            try manageContext.save() //削除した状態を保存
        } catch {
            print("read error:", error)
        }
    }
}
