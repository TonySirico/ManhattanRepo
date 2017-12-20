//
//  LoginViewController.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 13/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextFieldOutlet: RoundedUITextField!
    @IBOutlet weak var passwordTextFieldOutlet: RoundedUITextField!
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTextFieldOutlet.text, let password = passwordTextFieldOutlet.text {
            if (email.isEmpty) || (password.isEmpty) {
                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Fill all fields")
                return
            }
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "segueToHome", sender: self)
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "segueLoggedIn", sender: self)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
