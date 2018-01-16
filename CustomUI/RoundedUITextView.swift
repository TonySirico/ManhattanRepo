//
//  RoundedUITextField.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 14/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

class RoundedUITextView: UITextView {
    
    
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }*/
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
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
    }
  
}


