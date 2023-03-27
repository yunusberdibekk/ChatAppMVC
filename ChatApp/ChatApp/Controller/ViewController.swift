//
//  ViewController.swift
//  ChatApp
//
//  Created by Yunus Emre Berdibek on 27.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -PROPORTIES
    let stoaryboard = UIStoryboard(name: "Main", bundle: nil)

    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let vc = stoaryboard.instantiateViewController(withIdentifier: "LoginStoryboardID") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        let vc = stoaryboard.instantiateViewController(withIdentifier: "RegisterStoryboardID") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

