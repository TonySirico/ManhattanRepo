//
//  AlertController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 20/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    
    static func showAlert(inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
    
}
