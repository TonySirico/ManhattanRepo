//
//  AlternativeRoundedUITextField.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 14/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

class AlternativeRoundedUITextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0);
    
    
    
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
        
        self.backgroundColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:0.2)
        self.tintColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
        // let str = NSAttributedString(string: (self.placeholder)!, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        //self.attributedPlaceholder = str
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)])
        
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}

