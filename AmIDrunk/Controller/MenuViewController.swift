//
//  MenuViewController.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 13.02.2021.
//

import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate, UnitDelegate {
    
    
    var weight = Int()
    var firstDrinkTime = Date()
    var lastDrinkTime = Date()
    var sexConstant = Double()
    var weightConstant = Double()
    var weightUnitConstant = Double()
    var imperialUnits = Bool() {
        didSet {
            if imperialUnits == true {
                weightUnitConstant = 0.45359237
            } else if imperialUnits == false {
                weightUnitConstant = 1
            }
        }
    }
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var weightUnitLabel: UILabel!
    @IBOutlet weak var firstDrinkTimePicker: UIDatePicker!
    @IBOutlet weak var lastDrinkTimePicker: UIDatePicker!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        imperialUnits = defaults.bool(forKey: "Imperial")
    
        if defaults.bool(forKey: "Imperial") {
            imperialUnits = true
            weightUnitLabel.text = "lbs"
        }
    }
    
    
    //MARK: - IBActions
    
    @IBAction func sexSelected(_ sender: UIButton) {
        maleButton.isSelected = false
        femaleButton.isSelected = false
        sender.isSelected = true
        
        if maleButton.isSelected {
            sexConstant = 0.68
            weightConstant = 10
        } else {
            sexConstant = 0.55
            weightConstant = 11.5
        }
        weightTextField.endEditing(true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.settings, sender: self)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
                if weightTextField.hasText == true && sexConstant != 0 {
        print(weightUnitConstant)
                    performSegue(withIdentifier: K.Segue.drinkSelection , sender: self)
                }
    }
    
    //Hide keyboard when user touch background
    @IBAction func BackgroundPressed(_ sender: UITapGestureRecognizer) {
        weightTextField.resignFirstResponder()
    }
    
    
    //MARK: - Textfield delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Set maximum characters
        if textField ==  weightTextField{
            let char = string.cString(using: String.Encoding.utf8)
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
            return textField.text!.count <= 2
        }
        
        //Set only one dot
        if (weightTextField.text?.contains("."))! && string == "." {
            return false
        } else {
            return true
        }
    }
    
    
    //MARK: - Unit Protocol stubs
    
    func didChangeUnits(imperialUnits imperial: Bool) {
        self.imperialUnits = imperial
        if imperial == true {
            weightUnitLabel.text = "lbs"
        } else {
            weightUnitLabel.text = "kg"
        }
    }
    
    
    //MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.Segue.drinkSelection {
            if let drinkSelection = segue.destination as? DrinkSelectionViewController {
                drinkSelection.weight = Double(weightTextField.text!)! * weightUnitConstant
                print(Double(weightTextField.text!)! * weightUnitConstant)
                drinkSelection.sexConstant = sexConstant
                drinkSelection.weightConstant = weightConstant
                drinkSelection.lastDrink = lastDrinkTimePicker.date
                drinkSelection.imperialUnits = imperialUnits
            }
        }
        
        if segue.identifier == K.Segue.settings {
            let destination = segue.destination as! SettingsViewController
            destination.delegate = self
        }
    }
}


