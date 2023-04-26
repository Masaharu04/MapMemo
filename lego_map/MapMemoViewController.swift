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

        let (map_x,map_y,title,text,date) = read_userdefault(keyword: "1")
        titleTextField.text = title
        contentTextView.text = text
        // Do any additional setup after loading the view.
    }
    @IBAction func saveMemo() {
        let date = Date()
        let st_date = date_to_string(date: date)
        write_userdefault(map_x: 0, map_y: 0, title: titleTextField.text, text: contentTextView.text, date: st_date, keyword: "1")
        
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
