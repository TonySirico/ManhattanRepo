//
//  ProfileViewController.swift
//  Inaldo&Tony
//
//  Created by Andrea on 15/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    let mainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
    
    let darkMainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:0.6)
    
    var coding = ""
    var design = ""
    var business = ""
    var language = ""
    var science = ""
    var other = ""
    var flag: String = ""
    var selectedPhoto: UIImage?
    
    let uid = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var ProfilePic: RoundImageView!
    
    //LabelsOutlets
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var badgeNumberLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var timeCoinsLabel: UILabel!
    
    //TextFields
   
    @IBOutlet weak var descriptionTextField: AlternativeRoundedUITextField!
    
    @IBOutlet weak var requestDescriptionTextField: AlternativeRoundedUITextField!
    
    
    //Buttons
    
    @IBOutlet weak var codingButton: RoundedButton!
    @IBOutlet weak var designButton: RoundedButton!
    @IBOutlet weak var businessButton: RoundedButton!
    @IBOutlet weak var languageButton: RoundedButton!
    @IBOutlet weak var scienceButton: RoundedButton!
    @IBOutlet weak var otherButton: RoundedButton!
    
    //activityIndicator
    
    lazy var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    //BUTTONS ACTIONS
    
    
    @IBAction func logOutAction(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
            //          quando clicchi log out ti riporta sulla schermata di log in
            performSegue(withIdentifier: "unwindSegue", sender: self)
            print("You are logged out")
        } catch {
            print("There was a problem logging out")
        }
    }
    
    @IBAction func codingAction(_ sender: Any) {
        descriptionTextField.becomeFirstResponder()
        rightColourForButtons()
        if !codingButton.isSelected {
            deselectAllButtons()
            codingButton.isSelected = true
            if coding != "" {
                descriptionTextField.text! = coding
            } else {
                descriptionTextField.text = "#"
            }
            flag = "coding"
        }
    }
    
    @IBAction func designAction(_ sender: Any) {
        descriptionTextField.becomeFirstResponder()
        rightColourForButtons()
        if !designButton.isSelected {
            deselectAllButtons()
            designButton.isSelected = true
            if design != "" {
                descriptionTextField.text! = design
            } else {
                descriptionTextField.text = "#"
            }
            flag = "design"
        }
    }
    
    
    @IBAction func businessAction(_ sender: Any) {
        descriptionTextField.becomeFirstResponder()
        rightColourForButtons()
        if !businessButton.isSelected {
            deselectAllButtons()
            businessButton.isSelected = true
            if business != "" {
                descriptionTextField.text! = business
            } else {
                descriptionTextField.text = "#"
            }
            flag = "business"
        }
    }
    
    
    @IBAction func languageAction(_ sender: Any) {
        descriptionTextField.becomeFirstResponder()
        rightColourForButtons()
        if !languageButton.isSelected {
            deselectAllButtons()
            languageButton.isSelected = true
            if language != "" {
                descriptionTextField.text! = language
            } else {
                descriptionTextField.text = "#"
            }
            flag = "language"
        }
    }
    
    
    @IBAction func scienceAction(_ sender: Any) {
        descriptionTextField.becomeFirstResponder()
        rightColourForButtons()
        if !scienceButton.isSelected {
            deselectAllButtons()
            scienceButton.isSelected = true
            if science != "" {
                descriptionTextField.text! = science
            } else {
                descriptionTextField.text = "#"
            }
            flag = "science"
        }
    }
    
    @IBAction func otherAction(_ sender: Any) {
        descriptionTextField.becomeFirstResponder()
        rightColourForButtons()
        if !otherButton.isSelected {
            deselectAllButtons()
            otherButton.isSelected = true
            if other != "" {
                descriptionTextField.text! = other
            } else {
                descriptionTextField.text = "#"
            }
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
    
    override func viewDidDisappear(_ animated: Bool) {
        let userRef = Database.database().reference().child("users").child(uid!)
        userRef.child("skill").updateChildValues(["coding": coding])
        userRef.child("skill").updateChildValues(["design": design])
        userRef.child("skill").updateChildValues(["business": business])
        userRef.child("skill").updateChildValues(["language": language])
        userRef.child("skill").updateChildValues(["science": science])
        userRef.child("skill").updateChildValues(["other": other])
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLoadingIndicator()
        self.descriptionTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action:
            #selector(SignupViewController.handleProfileImageView)) // Ho scelto io il nome di handleProfileImageView è un metodo creato da me
        ProfilePic.addGestureRecognizer(tapGesture)
        ProfilePic.isUserInteractionEnabled = true
        
        let userRef = Database.database().reference().child("users").child(uid!)
        
        userRef.observe(.value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                let credits = dictionary["timeCoins"] as! Int
                let hoursCoins = (credits/60) % 24
                let minutesCoins = credits % 60
                
                self.nameSurnameLabel.text = (dictionary["name"] as? String)! + " " + (dictionary["surname"] as? String)!
              //  self.badgeNumberLabel.text = dictionary["badge"] as? String
              //  self.dateOfBirthLabel.text = dictionary["date of birth"] as? String
                self.timeCoinsLabel.text = String(format: "%02d:%02d", hoursCoins, minutesCoins)
            }
        })
        
        //this withCancel dovrebbe servire in caso di errore
        
        userRef.child("skill").observe(.value, with: { (DataSnapshot) in //questo observe è in real time
            if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                self.coding = (dictionary["coding"] as? String)!
                self.design = (dictionary["design"] as? String)!
                self.language = (dictionary["language"] as? String)!
                self.other = (dictionary["other"] as? String)!
                self.science = (dictionary["science"] as? String)!
                self.business = (dictionary["business"] as? String)!
                
                
                self.rightColourForButtons()
            }
        }, withCancel: nil)
        
        let userPhotoRef = Storage.storage().reference().child("profile Image").child(uid!)
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
    
    @objc func handleProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self // self ora è il delegato dell'image picker che usiamo
        // in questo modo è in grado di implementare i delegate di UIImagePickerControllerDelegate, UINavigationControllerDelegate che abbiamo utilizzato nella funziona a fine pagina
        present(pickerController, animated: true, completion: nil)
    }
    
    var secondLastTextCount = 0
    var lastTextCount = 0
    
    @IBAction func descriptionTextFieldEditingChanged(_ sender: Any) {
        if descriptionTextField.text?.count == 1 && descriptionTextField.text != "#" {
            var string = "#"
            string.append(descriptionTextField.text!)
            descriptionTextField.text = string
        }
        secondLastTextCount = lastTextCount
        lastTextCount = (descriptionTextField.text?.count)!
        if secondLastTextCount < lastTextCount {
            if descriptionTextField.text?.last == " " {
                descriptionTextField.text?.append("   #")
                lastTextCount = (descriptionTextField.text?.count)!
            }
        }
        descriptionFill()
        rightColourForButtons()
    }
    
    func rightColourForButtons() {
        if coding != "" {
            codingButton.backgroundColor = mainColor
            codingButton.titleLabel?.textColor = UIColor.black
        } else {
            if codingButton.isSelected {
                codingButton.backgroundColor = darkMainColor
            } else {
                codingButton.backgroundColor = .black
            }
        }
        
        if design != "" {
            designButton.backgroundColor = mainColor
            designButton.titleLabel?.textColor = UIColor.black
        } else {
            if designButton.isSelected {
                designButton.backgroundColor = darkMainColor
            } else {
                designButton.backgroundColor = .black
            }
        }
        
        if business != "" {
            businessButton.backgroundColor = mainColor
            businessButton.titleLabel?.textColor = UIColor.black
        } else {
            if businessButton.isSelected {
                businessButton.backgroundColor = darkMainColor
            } else {
                businessButton.backgroundColor = .black
            }
        }
        
        if language != "" {
            languageButton.backgroundColor = mainColor
            languageButton.titleLabel?.textColor = UIColor.black
        } else {
            if languageButton.isSelected {
                languageButton.backgroundColor = darkMainColor
            } else {
                languageButton.backgroundColor = .black
            }
        }
        
        if science != "" {
            scienceButton.backgroundColor = mainColor
            scienceButton.titleLabel?.textColor = UIColor.black
        } else {
            if scienceButton.isSelected {
                scienceButton.backgroundColor = darkMainColor
            } else {
                scienceButton.backgroundColor = .black
            }
        }
        
        if other != "" {
            otherButton.backgroundColor = mainColor
            otherButton.titleLabel?.textColor = UIColor.black
        } else {
            if otherButton.isSelected {
                otherButton.backgroundColor = darkMainColor
            } else {
                otherButton.backgroundColor = .black
            }
        }
    }
    
    func descriptionFill() {
        
        switch flag {
            
        case "coding":
            if descriptionTextField.text != "" && descriptionTextField.text != "#" {
                coding = descriptionTextField.text!
            } else {
                coding = ""
            }
            
        case "design":
            if descriptionTextField.text != "" && descriptionTextField.text != "#" {
                design = descriptionTextField.text!
            } else {
                design = ""
            }
            
        case "business":
            if descriptionTextField.text != "" && descriptionTextField.text != "#" {
                business = descriptionTextField.text!
            } else {
                business = ""
            }
            
        case "language":
            if descriptionTextField.text != "" && descriptionTextField.text != "#" {
                language = descriptionTextField.text!
            } else {
                language = ""
            }
            
        case "science":
            if descriptionTextField.text != "" && descriptionTextField.text != "#" {
                science = descriptionTextField.text!
            } else {
                science = ""
            }
            
        case "other":
            if descriptionTextField.text != "" && descriptionTextField.text != "#" {
                other = descriptionTextField.text!
            } else {
                other = ""
            }
            
        default:
            deselectAllButtons()
            
        }
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

    func textFieldDidEndEditing(_ textField: UITextField) {
        descriptionFill()
        rightColourForButtons()
        descriptionTextField.text = ""
        deselectAllButtons()
    }
    
    //Hide keyboard when user taps anywhere
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        print("TAP!")
        self.view.endEditing(true)
        
    }
    
    //Hide Keyboard when user press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         
        if string.contains(" ") {
            textField.text?.append("   ")
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text?.append("#")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
       
        //Codice
    
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedPhoto = image
            ProfilePic.image = image
            let userPhotoRef = Storage.storage().reference().child("profile Image").child(uid!)
            guard let image = ProfilePic.image else {return}
            if let newImage = UIImageJPEGRepresentation(image, 0.1){
                //upload to firebase storage
                userPhotoRef.putData(newImage, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                })
            }
        }
        dismiss(animated: true, completion: nil) //serve a far scomparire la libreria una volta scelta la foto
    }
}
