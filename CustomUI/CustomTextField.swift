//
//  CustomTextField.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 13/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextField: UITextField {
    
    
    
    
    init(frame: CGRect, arg1: CGFloat, arg2: String) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = arg1
        print(arg2)
        print("Instantiated")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
