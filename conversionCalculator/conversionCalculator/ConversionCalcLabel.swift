//
//  ConversionCalcLabel.swift
//  conversionCalculator
//
//  Created by Xcode User on 2/14/20.
//  Copyright © 2020 GVSU. All rights reserved.
//

import UIKit

class ConversionCalcLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        //self.foregroundColor = FOREGROUND_COLOR
        self.textColor = FOREGROUND_COLOR
    }
}
