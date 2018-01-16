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

class ProfileSellerViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //Back segue function
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    let mainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
    
    
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    var coding = ProfileSeller.shared.codingDescription
    var design = ProfileSeller.shared.designDescription
    var business = ProfileSeller.shared.businessDescription
    var language = ProfileSeller.shared.languageDescription
    var science = ProfileSeller.shared.scienceDescription
    var other = ProfileSeller.shared.othersDescription
    var flag: String = ""
    
    @IBOutlet weak var ProfilePic: RoundImageView!
    
    
    //Activity indicator
    lazy var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Outlets
    
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var timeCoinsLabel: UILabel!
    @IBOutlet weak var timeTextField: RoundedUITextField!
    
    @IBOutlet weak var timeSlider: UISlider!
    let ref = Database.database().reference()
    var userID = ""
    var interval = NSDate().timeIntervalSince1970
    let uid = Auth.auth().currentUser?.uid
    
    //TextFields
    
    @IBOutlet weak var descriptionTextField: AlternativeRoundedUITextField!
    @IBOutlet weak var requestDescriptionTextField: RoundedUITextView!
    
    //Buttons
    
    @IBOutlet weak var codingButton: RoundedButton!
    @IBOutlet weak var designButton: RoundedButton!
    @IBOutlet weak var businessButton: RoundedButton!
    @IBOutlet weak var languageButton: RoundedButton!
    @IBOutlet weak var scienceButton: RoundedButton!
    @IBOutlet weak var otherButton: RoundedButton!
    
    
  
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        
        let roundedValue = round(sender.value / 15) * 15
        sender.value = roundedValue
        
        //let value = Int(sender.value)
        
        let myValue = Int(roundedValue)
        
        timeTextField.text = "\(myValue)"
    }
    
    
    
    //BUTTONS ACTIONS
    @IBAction func requestAction(_ sender: Any) {
        let date = NSDate(timeIntervalSince1970: self.interval)
        
        let requestAlert = UIAlertController(title: "Request Sent!", message: "Request sent successfully to \(self.nameSurname.text!).", preferredStyle: .alert)
        requestAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.performSegue(withIdentifier: "unwindToHome", sender: self)
        }))
        
        
        
        guard let timeRequests = Int(self.timeTextField.text!) else {return}
        guard let descriptionRequests = requestDescriptionTextField.text else {return}
        FriendSystem.system.getTimeCoinsCurrentUser(uid!, { (timeCoins) in
            
            if timeCoins >= timeRequests {
                let uidRef = Database.database().reference().child("users").child(self.uid!)
                if descriptionRequests == "Tap to write a description for the request" {
                    FriendSystem.system.sendRequestToUser(self.userID, timeRequests, "\(date)", " ")
                } else {
                    FriendSystem.system.sendRequestToUser(self.userID, timeRequests, "\(date)", descriptionRequests)
                }
                uidRef.child("timeCoins").setValue(timeCoins-timeRequests)
                self.present(requestAlert, animated: true)
                
                //self.performSegue(withIdentifier: "unwindToHome", sender: self)
            } else {
                AlertController.showAlert(inViewController: self, title: "Missing Coins", message: "You don't have enought time")
            }
        })
    }
    
    @IBAction func codingAction(_ sender: Any) {
        if !codingButton.isSelected {
            fillButtons()
            deselectAllButtons()
            codingButton.isSelected = true
            descriptionTextField.text! = coding
            flag = "coding"
        }
        
    }
    
    @IBAction func designAction(_ sender: Any) {
        if !designButton.isSelected {
            fillButtons()
            deselectAllButtons()
            designButton.isSelected = true
            descriptionTextField.text! = design
            flag = "design"
        }
    }
    
    
    @IBAction func businessAction(_ sender: Any) {
        if !businessButton.isSelected {
            fillButtons()
            deselectAllButtons()
            businessButton.isSelected = true
            descriptionTextField.text! = business
            flag = "business"
        }
    }
    
    
    @IBAction func languageAction(_ sender: Any) {
        if !languageButton.isSelected {
            fillButtons()
            deselectAllButtons()
            languageButton.isSelected = true
            descriptionTextField.text! = language
            flag = "language"
        }
    }
    
    
    @IBAction func scienceAction(_ sender: Any) {
        if !scienceButton.isSelected {
            fillButtons()
            deselectAllButtons()
            scienceButton.isSelected = true
            descriptionTextField.text! = science
            flag = "science"
        }
    }
    
    @IBAction func otherAction(_ sender: Any) {
        if !otherButton.isSelected {
            fillButtons()
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
        
        startLoadingIndicator()
        
        //Labels
        nameSurname.adjustsFontSizeToFitWidth = true
        nameSurname.text = ProfileSeller.shared.name + " " + ProfileSeller.shared.surname
        
        let userRef = Database.database().reference().child("users").child(userID)
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                let credits = dictionary["timeCoins"] as! Int
                let hoursCoins = (credits/60) % 24
                let minutesCoins = credits % 60
                
                self.nameSurname.text = (dictionary["name"] as? String)! + " " + (dictionary["surname"] as? String)!
                //self.badgeLabel.text = dictionary["badge"] as? String
                //self.birthLabel.text = dictionary["date of birth"] as? String
                self.timeCoinsLabel.text = String(format: "%02d:%02d", hoursCoins, minutesCoins)
            }
        }, withCancel: nil)
        
        
        
        //skills
        userRef.child("skill").observe(.value, with: { (DataSnapshot) in //questo observe è in real time
            if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                self.coding = (dictionary["coding"] as? String)!
                self.design = (dictionary["design"] as? String)!
                self.language = (dictionary["language"] as? String)!
                self.other = (dictionary["other"] as? String)!
                self.science = (dictionary["science"] as? String)!
                self.business = (dictionary["business"] as? String)!
                
                
                self.fillButtons()
            }
        }, withCancel: nil)
        
        
        //profilePic
        let userPhotoRef = Storage.storage().reference().child("profile Image").child(userID)
        userPhotoRef.getData(maxSize: 1 * 1024 * 1024, completion: { (photoData, error) in
            if error != nil {
                return
            } else {
                if let data = photoData {
                    self.ProfilePic.image = UIImage(data: data)
                    self.endLoadingIndicator()
                }
            }
        })
        
        
        
        //delegate
        requestDescriptionTextField.delegate = self
        
        
        //Slider
        timeTextField.text = "30"
        timeSlider.minimumValue = 15
        timeSlider.value = 30
        
        

       
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
    
    //hide keyboard when user taps anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOUCH!")
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //Hide Keyboard when user press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    
    func fillButtons() {
        
        //Funzione che colora i pulsanti con le skill
        
        if coding != "" {
            codingButton.backgroundColor = mainColor
            codingButton.titleLabel?.textColor = UIColor.black
        }
        
        if design != "" {
            designButton.backgroundColor = mainColor
            designButton.titleLabel?.textColor = UIColor.black
        }
        
        if business != "" {
            businessButton.backgroundColor = mainColor
            businessButton.titleLabel?.textColor = UIColor.black
        }
        
        if language != "" {
            languageButton.backgroundColor = mainColor
            languageButton.titleLabel?.textColor = UIColor.black}
        
        if science != "" {
            scienceButton.backgroundColor = mainColor
            scienceButton.titleLabel?.textColor = UIColor.black
        }
        
        if other != "" {
            otherButton.backgroundColor = mainColor
            otherButton.titleLabel?.textColor = UIColor.black
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
   
    
    //Toglie tastiera textview quando si preme invio
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    
    func startLoadingIndicator() {
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    func endLoadingIndicator(){
        
        blurEffectView.removeFromSuperview()
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
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

