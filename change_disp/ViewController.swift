//
//  ViewController.swift
//  change_disp
//
//  Created by Motoki on 2023/04/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AtoB(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "B") as! secondViewController
        secondViewController.modalPresentationStyle = .pageSheet
        self.present(secondViewController,animated: true,completion: nil)
    }


}

