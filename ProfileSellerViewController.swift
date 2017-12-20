//
//  ProfileSellerViewController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 19/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileSellerViewController: UIViewController, UITextFieldDelegate {
    
    //Back segue function
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    let mainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
    
    
    var coding = ProfileSeller.shared.codingDescription
    var design = ProfileSeller.shared.designDescription
    var business = ProfileSeller.shared.businessDescription
    var language = ProfileSeller.shared.languageDescription
    var science = ProfileSeller.shared.scienceDescription
    var other = ProfileSeller.shared.othersDescription
    var flag: String = ""
    
    @IBOutlet weak var ProfilePic: RoundImageView!
    
    //Outlets
    
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var timeCoinsLabel: UILabel!
    @IBOutlet weak var timeTextField: RoundedUITextField!
    
    var userID = ""
    let uid = Auth.auth().currentUser?.uid
    
    //TextFields
    
    @IBOutlet weak var descriptionTextField: AlternativeRoundedUITextField!
    
    //Buttons
    
    @IBOutlet weak var codingButton: RoundedButton!
    @IBOutlet weak var designButton: RoundedButton!
    @IBOutlet weak var businessButton: RoundedButton!
    @IBOutlet weak var languageButton: RoundedButton!
    @IBOutlet weak var scienceButton: RoundedButton!
    @IBOutlet weak var otherButton: RoundedButton!
    
    //BUTTONS ACTIONS
    
    @IBAction func requestAction(_ sender: Any) {
        guard let timeRequests = Int(self.timeTextField.text!) else {return}
        FriendSystem.system.getTimeCoinsCurrentUser(uid!, { (timeCoins) in
            print("i miei coins + \(timeCoins)")
            if timeCoins >= timeRequests {
                let uidRef = Database.database().reference().child("users").child(self.uid!)
                FriendSystem.system.sendRequestToUser(self.userID, timeRequests)
                uidRef.child("timeCoins").setValue(timeCoins-timeRequests)
            } else {
                AlertController.showAlert(inViewController: self, title: "Missing Coins", message: "You don't have enought time")
            }
        })
    }
    
    @IBAction func codingAction(_ sender: Any) {
        if !codingButton.isSelected {
            deselectAllButtons()
            codingButton.isSelected = true
            descriptionTextField.text! = coding
            flag = "coding"
        }
        
    }
    
    @IBAction func designAction(_ sender: Any) {
        if !designButton.isSelected {
            deselectAllButtons()
            designButton.isSelected = true
            descriptionTextField.text! = design
            flag = "design"
        }
    }
    
    
    @IBAction func businessAction(_ sender: Any) {
        if !businessButton.isSelected {
            deselectAllButtons()
            businessButton.isSelected = true
            descriptionTextField.text! = business
            flag = "business"
        }
    }
    
    
    @IBAction func languageAction(_ sender: Any) {
        if !languageButton.isSelected {
            deselectAllButtons()
            languageButton.isSelected = true
            descriptionTextField.text! = language
            flag = "language"
        }
    }
    
    
    @IBAction func scienceAction(_ sender: Any) {
        if !scienceButton.isSelected {
            deselectAllButtons()
            scienceButton.isSelected = true
            descriptionTextField.text! = science
            flag = "science"
        }
    }
    
    @IBAction func otherAction(_ sender: Any) {
        if !otherButton.isSelected {
            deselectAllButtons()
            otherButton.isSelected = true
            descriptionTextField.text! = other
            flag = "other"
        }
    }
    
    func deselectAllButtons() {
        
        codingButton.isSelected = false
        designButton.isSelected = false
        businessButton.isSelected = false
        languageButton.isSelected = false
        scienceButton.isSelected = false
        otherButton.isSelected = false
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameSurname.adjustsFontSizeToFitWidth = true
        
        self.descriptionTextField.delegate = self
        
        nameSurname.text = ProfileSeller.shared.name + " " + ProfileSeller.shared.surname
        
        let userRef = Database.database().reference().child("users").child(userID)
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                let credits = dictionary["timeCoins"] as! Int
                let hoursCoins = (credits/60) % 24
                let minutesCoins = credits % 60
                
                self.nameSurname.text = (dictionary["name"] as? String)! + " " + (dictionary["surname"] as? String)!
                self.badgeLabel.text = dictionary["badge"] as? String
                self.birthLabel.text = dictionary["date of birth"] as? String
                self.timeCoinsLabel.text = String(format: "%02d:%02d", hoursCoins, minutesCoins)
            }
        }, withCancel: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
        
        
        //KeyboardNotificationTrigger
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Move view according to keyboard height
    @objc func keyboardWillShow(notification: Notification) {
        
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        
        super.view.frame.origin = CGPoint(x: 0.0, y: -(keyboardHeight - 50.0))
        
    }
    //Move view into original position
    @objc func keyboardWillHide(notification: Notification) {
        
        super.view.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
    }
    
    //Hide keyboard when user taps anywhere
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    
    //Hide Keyboard when user press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
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

