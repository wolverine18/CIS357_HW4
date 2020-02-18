//
//  ViewController.swift
//  conversionCalculator
//
//  Created by MacBook on 1/31/20.
//  Copyright © 2020 GVSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {

    @IBOutlet weak var fromField: DecimalMinusTextField!
    
    @IBOutlet weak var toField: DecimalMinusTextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    var isLengthMode = true
    var fromLengthUnit: LengthUnit = .Yards
    var toLengthUnit: LengthUnit = .Meters
    var fromVolumeUnit: VolumeUnit = .Gallons
    var toVolumeUnit: VolumeUnit = .Liters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = BACKGROUND_COLOR
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
        // make this controller the delegate of the text fields.
        self.fromField.delegate = self
        self.toField.delegate = self
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        self.dismissKeyboard()
        if(fromField.text?.isEmpty == false)
        {
            let fromText = fromField.text
            
            let val = convertUnits(fromVal: Double(fromText!)!)
            toField.text = String(format:"%.5f", val)
        }
        else if(toField.text?.isEmpty == false)
        {
            let toText = toField.text
            let val = convertUnits(fromVal: Double(toText!)!)
            fromField.text = String(format:"%.5f", val)
        }
        else
        {
            print("No Values Entered")
        }
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        fromField.text = nil
        toField.text = nil
    }
    
    @IBAction func modePressed(_ sender: UIButton) { 
        isLengthMode = !isLengthMode
        if(isLengthMode == true)
        {
            changeLengthLabels()
        }
        else
        {
            changeVolumeLabels()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSettings" {
            print("Destination is: \(segue.destination)")
            if let dest = segue.destination.children[0] as? SettingsViewController {
                dest.delegate = self
                dest.isLengthMode = self.isLengthMode
                dest.fromUnit = self.fromLabel.text
                dest.toUnit = self.toLabel.text
            }
        }
    }
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        fromLengthUnit = fromUnits
        toLengthUnit = toUnits
        changeLengthLabels()
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        fromVolumeUnit = fromUnits
        toVolumeUnit = toUnits
        changeVolumeLabels()
    }
    
    func changeLengthLabels() {
        fromLabel.text = fromLengthUnit.rawValue
        toLabel.text = toLengthUnit.rawValue
        fromField.placeholder = "Enter Length in " + fromLengthUnit.rawValue
        toField.placeholder = "Enter Length in " + toLengthUnit.rawValue
    }
    
    func changeVolumeLabels() {
        fromLabel.text = fromVolumeUnit.rawValue
        toLabel.text = toVolumeUnit.rawValue
        fromField.placeholder = "Enter Volume in " + fromVolumeUnit.rawValue
        toField.placeholder = "Enter Volume in " + toVolumeUnit.rawValue
    }
    
    func convertUnits(fromVal: Double) -> Double {
        var toVal: Double
        if(isLengthMode)
        {
            let convKey =  LengthConversionKey(toUnits: toLengthUnit, fromUnits: fromLengthUnit)
            toVal = fromVal * lengthConversionTable[convKey]!;
        }
        else
        {
            let convKey =  VolumeConversionKey(toUnits: toVolumeUnit, fromUnits: fromVolumeUnit)
            toVal = fromVal * volumeConversionTable[convKey]!;
        }
        return toVal
    }
    
    
    override var preferredStatusBarStyle :UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == self.toField {
            self.fromField.text = nil
        }
        else
        {
            self.toField.text = nil
        }
        return true
    }
}

