//
//  PopUpViewController.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 04/01/18.
//  Copyright © 2018 Antonio Sirica. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: RoundedUITextView!
    @IBOutlet weak var popUpCentralView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.8)
        
        if RequestDescription.shared.description != " " {
            descriptionTextView.text = RequestDescription.shared.description
        } else {
            descriptionTextView.text = "No description for this task."
        }
        
        popUpCentralView.layer.cornerRadius = 20.0
        
        showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closePopUp(_ sender: Any) {
        
        removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    
    //Animazioni
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
