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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        
        emailTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self

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
        
        
        
        //KeyboardNotificationTrigger
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //dismiss keyboard when user taps return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        //Move view according to keyboard height
        super.view.frame.origin = CGPoint(x: 0.0, y: -(keyboardHeight - 50.0))
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //Move view into original position
        super.view.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
    }
    
    
    //keyboard notification
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
       
        
    }
    

    //hide keyboard when user taps anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
