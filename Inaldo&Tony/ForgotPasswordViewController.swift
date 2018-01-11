//
//  ForgotPasswordViewController.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 11/01/18.
//  Copyright © 2018 Antonio Sirica. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: RoundedUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func sendRecoverEmail(_ sender: Any) {
        
        guard let text = emailTextField.text  else {return}
            Auth.auth().sendPasswordReset(withEmail: text) { error in
                if error != nil
                {
                    AlertController.showAlert(inViewController: self, title: "Email unknown", message: "There is no account with this email")
                } else
                {
                    AlertController.showAlert(inViewController: self, title: "Password restored", message: "Check your email box to reset your password")            }
            }
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func tapGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
}
