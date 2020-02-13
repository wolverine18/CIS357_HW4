//
//  ConversionCalcTextField.swift
//  conversionCalculator
//
//  Created by Xcode User on 2/13/20.
//  Copyright © 2020 GVSU. All rights reserved.
//

import UIKit

class ConversionCalcTextField: DecimalMinusTextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        //self.foregroundColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.textColor = FOREGROUND_COLOR
        
        self.layer.borderWidth = 1
        self.borderStyle = .roundedRect
        //self.layer.borderColor = FOREGROUND_COLOR
    }

}
