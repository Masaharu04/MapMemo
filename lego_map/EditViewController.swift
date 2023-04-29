//
//  EditViewController.swift
//  lego_map
//
//  Created by 山本聖留 on 2023/04/29.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications


protocol SampleDelegate: class  {
    func save_prepare()
    //func addpin()
}
protocol Sample2Delegate: class {
    func addpin()
}

class EditViewController: UIViewController {

    var val_x: Double = 0.0
    var val_y: Double = 0.0
    weak var delegate: SampleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save_to_ViewController(){
        //ViewController().save_prepare()
        delegate?.save_prepare()
//        if let controller = self.presentingViewController as? ViewController {
//            controller.save_prepare()
//        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func a(){
        let alertcontroller = UIAlertController(title: "保存", message: "保存完了", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default,handler: nil)
        alertcontroller.addAction(okAction)
        present(alertcontroller,animated: true,completion: nil)
    }

}
