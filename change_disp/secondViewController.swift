//
//  secondViewController.swift
//  change_disp
//
//  Created by Motoki on 2023/04/28.
//

import UIKit

class secondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BtoA(){
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "A") as! ViewController
        ViewController.modalPresentationStyle = .overFullScreen
        self.present(ViewController,animated: true,completion: nil)
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
