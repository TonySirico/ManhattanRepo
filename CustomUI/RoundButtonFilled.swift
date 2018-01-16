//
//  RoundedButton.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 14/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

class RoundedButtonFilled: UIButton {
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
        self.tintColor = UIColor.white
        //self.frame.size = CGSize(width: 215, height: 40)
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0).cgColor
        self.backgroundColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
    }
    
    
    
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}


