//
//  RoundedUITextField.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 14/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

class RoundedUITextField: UITextField {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setAttributes()
    }
    
    func setAttributes() {
        //self.layer.cornerRadius = 20.0
        self.textColor = UIColor.white
        
        self.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:1.0)
        self.tintColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
       // let str = NSAttributedString(string: (self.placeholder)!, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        //self.attributedPlaceholder = str
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)])
        
        
        
        
    }
    
}

