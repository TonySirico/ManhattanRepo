//
//  SignupViewController.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 13/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    let ourGreen = UIColor(red:0.31, green:0.82, blue:0.30, alpha:0.0)
    
    let mainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
    
    let darkMainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:0.6)
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    //vars
    var selectedPhoto: UIImage?
    var coding = ""
    var design = ""
    var business = ""
    var language = ""
    var science = ""
    var other = ""
    var flag: String = ""
    
    
    //Hide keyboard when user taps anywhere
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    /*-----------OUTLETS-----------*/
    
    //TextFields
    @IBOutlet weak var nameTextField: RoundedUITextField!
    @IBOutlet weak var surnameTextField: RoundedUITextField!
    @IBOutlet weak var emailTextField: RoundedUITextField!
    @IBOutlet weak var badgeTextField: RoundedUITextField!
    @IBOutlet weak var birthdayTextField: RoundedUITextField!
    @IBOutlet weak var passwordTextField: RoundedUITextField!
    @IBOutlet weak var descriptionTextField: AlternativeRoundedUITextField!
    
    //Buttons
    @IBOutlet weak var imageSelectionButton: UIButton!
    @IBOutlet weak var codingButton: RoundedButton!
    @IBOutlet weak var designButton: RoundedButton!
    @IBOutlet weak var businessButton: RoundedButton!
    @IBOutlet weak var languageButton: RoundedButton!
    @IBOutlet weak var scienceButton: RoundedButton!
    @IBOutlet weak var otherButton: RoundedButton!
    
    
    @IBOutlet weak var profilePhotoIV: RoundImageView!
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    
    //BUTTONS ACTIONS
    @IBAction func imageSelectionAction(_ sender: Any) {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TextField delegate
        self.nameTextField.delegate = self
        self.surnameTextField.delegate = self
        self.emailTextField.delegate = self
        self.badgeTextField.delegate = self
        self.passwordTextField.delegate = self
        self.descriptionTextField.delegate = self
        
        //  **Edit the placeholder into the main storyboard**
        
        //Calling DatePicker when typing into birthdayTextField
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = UIDatePickerMode.date
        myDatePicker.addTarget(self, action: #selector(SignupViewController.datePickeralueChanged(sender:)), for: UIControlEvents.valueChanged)
        birthdayTextField.inputView = myDatePicker
        myDatePicker.setValue(mainColor, forKeyPath: "textColor")
        myDatePicker.setValue(UIColor.black, forKey: "backgroundColor")
        
        let tapGesture = UITapGestureRecognizer(target: self, action:
            #selector(SignupViewController.handleProfileImageView)) // Ho scelto io il nome di handleProfileImageView è un metodo creato da me
        profilePhotoIV.addGestureRecognizer(tapGesture)
        profilePhotoIV.isUserInteractionEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
        
        
        //KeyboardNotificationTrigger
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
        navBar.isHidden = true
        
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        descriptionFill()
        rightColourForButtons()
        descriptionTextField.text = ""
        deselectAllButtons()
    }
    
    @objc func handleProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self // self ora è il delegato dell'image picker che usiamo
        // in questo modo è in grado di implementare i delegate di UIImagePickerControllerDelegate, UINavigationControllerDelegate che abbiamo utilizzato nella funziona a fine pagina
        present(pickerController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide Keyboard when user press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        
        //Move view according to keyboard height
        
        if nameTextField.isEditing {}
        else if descriptionTextField.isEditing {super.view.frame.origin = CGPoint(x: 0.0, y: -(keyboardHeight - 5))}
        else {super.view.frame.origin = CGPoint(x: 0.0, y: -(keyboardHeight - 50.0))}
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //Move view into original position
        super.view.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
    }
    
    func deselectAllButtons() {
        codingButton.isSelected = false
        designButton.isSelected = false
        businessButton.isSelected = false
        languageButton.isSelected = false
        scienceButton.isSelected = false
        otherButton.isSelected = false
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
    
    @objc func datePickeralueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "dd/MM/yyyy"
        birthdayTextField.text = formatter.string(from: sender.date)
    }
    
    //-----------------------------------------------------
    
    @IBAction func signUpAction(_ sender: Any) {
        if let name = nameTextField.text, let surname = surnameTextField.text, let email = emailTextField.text?.lowercased(), let password = passwordTextField.text, let badge = badgeTextField.text  {
            
            if name.isEmpty || password.isEmpty || email.isEmpty || password.isEmpty {
                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Fill all fields")
                return
            } else if password.count < 6 {
                AlertController.showAlert(inViewController: self, title: "Error", message: "You have to add a password of 6 characters")
                return
            }
            Auth.auth().createUser(withEmail:email, password: password, completion: { user, error in
                if error != nil {
                    AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                    return
                }
                let uid = user?.uid // abbiamo semplicemente salvato l'user id in una costante chiamata uid da usare in seguito
                let userPhotoRef = Storage.storage().reference().child("profile Image").child(uid!)
                //abbiamo creato la reference al nostor database e creato un figlio per metterci la foto profilo
                if let profilePhoto = self.selectedPhoto, let photoData = UIImageJPEGRepresentation(profilePhoto, 0.1) {
                    //let photoData serve per convertire la foto in JPEG e 0,1 è l'unità di compressione
                    userPhotoRef.putData(photoData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        }
                    })
                } else {
                    let photoData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "dummyProfileImage"), 0.1)
                    userPhotoRef.putData(photoData!, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        }
                    })
                    
                }
                
                let userReference = Database.database().reference().child("users").child(uid!)
                userReference.setValue(["email": email, "name": name, "surname": surname, "badge": badge, "date of birth": self.birthdayTextField.text!, "timeCoins": 120])
                userReference.child("skill").setValue(["coding": self.coding, "design": self.design, "language": self.language, "business": self.business, "science": self.science, "other": self.other])
                self.showLoggedInView()
            })
        }
    }
    
    func showLoggedInView () {
        performSegue(withIdentifier: "segueToHome", sender: self)
    }
    
    
}





//extension usata per implementare la scelta dell'immagine profilo dall'utente
extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedPhoto = image
            profilePhotoIV.image = image
        }
        dismiss(animated: true, completion: nil) //serve a far scomparire la libreria una volta scelta la foto
    }
    
    
    
}
