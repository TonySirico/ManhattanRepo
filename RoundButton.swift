//
//  RoundedButton.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 13/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    let mainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //layer.borderWidth = 1/UIScreen.main.nativeScale
        
        //contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/4
        //layer.borderColor = isEnabled ? tintColor.cgColor : UIColor.lightGray.cgColor
        self.tintColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:0.0)
        self.frame.size = CGSize(width: 80, height: 40)
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0).cgColor
        
        if self.isSelected {
            
            self.backgroundColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:0.6)
            self.titleLabel?.textColor = UIColor.black
            self.layer.borderWidth = 2.5
            
        } else {
            if self.backgroundColor != mainColor {
                self.backgroundColor = UIColor.black
                self.titleLabel?.textColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
                
            } else {
                self.titleLabel?.textColor = UIColor.black
            }
        }
        
        
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

