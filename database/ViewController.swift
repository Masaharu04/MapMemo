//
//  ViewController.swift
//  database
//
//  Created by Motoki on 2023/04/27.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var titletextfield: UITextField!
    @IBOutlet var contentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let memo: Memo? = read()
        
        titletextfield.text = memo?.title
        contentTextField.text = memo?.title
    }
    
    func read() -> Memo? {
        return realm.objects(Memo.self).first
    }
    
    @IBAction func save() {
        let title: String = titletextfield.text!
        let content: String = contentTextField.text!
        
        let memo: Memo? = read()
        
        if memo != nil {
            try! realm.write {
                memo!.title = title
                memo!.content = content
            }
        } else {
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
                
            try! realm.write {
                realm.add(newMemo)
            }
        }
        
        let alert: UIAlertController = UIAlertController(title: "成功",
                                                         message: "保存しました",
                                                         preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title)
        )
        
    }


}

