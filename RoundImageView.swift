//
//  RoundImageView.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 13/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

@IBDesignable class RoundImageView: UIImageView {
    
    override init(image: UIImage?) {
        
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
}
