//
//  SettingsViewController.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 15.02.2021.
//

import UIKit

protocol UnitDelegate {
    func didChangeUnits(imperialUnits: Bool)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var imperialButton: UIButton!
    
    let defaults = UserDefaults.standard
    var delegate: UnitDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.bool(forKey: "Imperial") {
            imperialButton.isSelected = true
        } else {
            metricButton.isSelected = true
        }
    }
    
    @IBAction func unitsSelected(_ sender: UIButton) {
        metricButton.isSelected = false
        imperialButton.isSelected = false
        sender.isSelected = true
        
        if sender.tag == 1 {
            delegate?.didChangeUnits(imperialUnits: true)
            defaults.set(true, forKey: "Imperial")
        } else {
            delegate?.didChangeUnits(imperialUnits: false)
            defaults.set(false, forKey: "Imperial")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
