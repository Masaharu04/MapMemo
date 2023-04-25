//
//  MapMemoViewController.swift
//  lego_map
//
//  Created by Masaharu on 2023/04/25.
//

import UIKit

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
        let alertController = UIAlertController(title: "保存", message: "保存完了", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
       
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
