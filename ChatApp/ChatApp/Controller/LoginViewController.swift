//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Yunus Emre Berdibek on 27.03.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: -PROPORTIES
    @IBOutlet weak var emailTF:UITextField!
    @IBOutlet weak var passwordTF:UITextField!
    
    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func showAlert(_ msg:String){
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
        
    }
    
    @IBAction func btnClickedLogin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            
            if error == nil {
                debugPrint("registration succesfull")
                self.emailTF.text = ""
                self.passwordTF.text = ""
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatsStoryboardID") as! ChatViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else{
                debugPrint(error!)
                self.showAlert(error?.localizedDescription ?? "Error")
            }
            
        }
        
    }

}
