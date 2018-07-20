//
//  ViewController.swift
//  programmingTest
//
//  Created by Atsushi on 2018/07/12.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var wordList:[NSDictionary] = []
    
    var label = UILabel()
    
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        readWords()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = UITableViewCell()
        
        let dic = wordList[indexPath.row]
        cell.textLabel?.text = dic["title"] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count = Int(indexPath.row)
        
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dic = wordList[indexPath.row]
            let title = dic["title"] as! String
            
            //CoreDataから削除
            deleteWord(title: title)
            
            //表示用の配列の削除
            wordList.remove(at: indexPath.row)
            
            //行が消える
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let DetailVC = segue.destination as! DetailViewController
            
            DetailVC.selectedNumber = count
        }
    }
    
    func readWords() {
        //AppDelegateのインスタンス化
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        //取り出し
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        do {
            let fetchResults = try manageContext.fetch(fetchRequest)
            
            wordList = []
            
            for result in fetchResults {
                
                //1件ずつ取り出し
                let title:String? = result.value(forKey: "title") as? String
                let detail:String? = result.value(forKey: "detail") as? String
                
                let dic = ["title":title, "detail":detail] as [String: Any]
                
                wordList.append(dic as NSDictionary)
                print(wordList)
                print(result)
            }
        } catch {
            print("read error", error)
        }
    }

    func deleteWord(title:String) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        let predicate = NSPredicate(format: "title = %@", title)
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResults = try manageContext.fetch(fetchRequest)
            
            for result in fetchResults {
//                let title:String? = result.value(forKey: "title") as? String
//                let detail:String? = result.value(forKey: "detail") as? String
                
                manageContext.delete(result)
            }
            try manageContext.save() //削除した状態を保存
        } catch {
            print("read error:", error)
        }
    }
}

