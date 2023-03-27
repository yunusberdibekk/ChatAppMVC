//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Yunus Emre Berdibek on 27.03.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //MARK: -PROPORTIES
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClickedRegister(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ user, error in
            if error == nil {
                debugPrint("Registration succesful")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatsStoryboardID") as! ChatViewController
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else{
                debugPrint(error!)
                self.showAlert(error?.localizedDescription ?? "Error")
            }
            
        }
    }
    
    private func showAlert(_ msg:String){
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
        
    }

}
