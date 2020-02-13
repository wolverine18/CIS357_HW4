//
//  SettingsViewController.swift
//  conversionCalculator
//
//  Created by Xcode User on 2/4/20.
//  Copyright © 2020 GVSU. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
}

class SettingsViewController: UIViewController{

    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var isLengthMode: Bool?
    var pickerData: [String] = [String]()
    var delegate: SettingsViewControllerDelegate?
    var setFrom: Bool?
    var fromUnit: String?
    var toUnit: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let from = fromUnit {
            fromLabel.text = from
        }
        
        if let to = toUnit {
            toLabel.text = to
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
        if(isLengthMode == true)
        {
            pickerData = ["Yards", "Meters", "Miles"]
        }
        else
        {
            pickerData = ["Liters", "Gallons", "Quarts"]
        }
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.fromTapFunction))
        fromLabel.isUserInteractionEnabled = true
        fromLabel.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.toTapFunction))
        toLabel.isUserInteractionEnabled = true
        toLabel.addGestureRecognizer(tapTo)
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissPicker))
        self.view.addGestureRecognizer(detectTouch)
    }
    
    @objc func toTapFunction(sender: UITapGestureRecognizer) {
        self.setFrom = false
        self.picker.isHidden = false
    }
    
    @objc func fromTapFunction(sender: UITapGestureRecognizer) {
        self.setFrom = true
        self.picker.isHidden = false
    }
    
    @objc func dismissPicker() {
        self.picker.isHidden = true
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        if let d = self.delegate {
            if isLengthMode! {
                d.settingsChanged(fromUnits: LengthUnit(rawValue: fromLabel.text!)!, toUnits: LengthUnit(rawValue: toLabel.text!)!)
            }
            else {
                d.settingsChanged(fromUnits: VolumeUnit(rawValue:fromLabel.text!)!, toUnits: VolumeUnit(rawValue: toLabel.text!)!)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}


extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(self.setFrom ?? true) {
            self.fromLabel.text = pickerData[row]
        }
        else {
            self.toLabel.text = pickerData[row]
        }
        
    }
}
