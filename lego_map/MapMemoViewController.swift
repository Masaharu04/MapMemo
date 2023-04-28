//
//  MapMemoViewController.swift
//  lego_map
//
//  Created by Masaharu on 2023/04/25.
//

import UIKit
import CoreLocation
import UserNotifications


class MapMemoViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var IconField: UITextField!
    
    @IBOutlet var contentTextView: UITextView!
    
    var saveData: UserDefaults  = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = saveData.object(forKey: "title")as? String
        contentTextView.text = saveData.object(forKey: "content")as? String
        // Do any additional setup after loading the view.
    }
    @IBAction func saveMemo() {
        
        saveData.set(titleTextField.text, forKey: "title")
        saveData.set(contentTextView.text, forKey: "content")
        
        //セーブボタンアラート
        let alertController = UIAlertController(title: "保存", message: "保存完了", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
        //ローカル通知の設定
        
        let content = UNMutableNotificationContent()
        content.title = "メモ発見！"
        content.body = "メモを除いてみよう"
        content.sound = UNNotificationSound.default
        
        // 直ぐに通知を表示
        sleep(10)
        let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    @IBAction func listButton(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "ローカル通知"
        content.body = "5秒後に表示されます。"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ローカル通知の登録に失敗しました：", error)
            } else {
                print("ローカル通知を登録しました。")
            }
        }
    }
    
}
