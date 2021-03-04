//
//  ResultsViewController.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 15.02.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var promile = Double()
    var estimateTime = Double()
    var time = Date()
    var day = String()

    @IBOutlet weak var promileLabel: UILabel!
    @IBOutlet weak var promileDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeDescriptionLabel: UILabel!
    @IBOutlet weak var estimateTimeLabel: UILabel!
    @IBOutlet weak var estimateTimeDescriptionLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    
    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        return df
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Calendar.current.dateComponents([.day], from: Date())
        let clear = Calendar.current.dateComponents([.day], from: time)
        
        day = clear.day! - now.day! == 0 ? "Today" : "Next day"
        
        promileLabel.text = String(format: "%.2f", promile)
        estimateTimeLabel.text = (timeString(time: estimateTime))
        timeLabel.text = formatter.string(from: time)
        timeDescriptionLabel.text = "\(day) at \(formatter.string(from: time)) you will be without blood alcohol"
        estimateTimeDescriptionLabel.text = "In \(timeString(time: estimateTime)) you will have 0 level of alcohol in your blood"
    }
    
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        return String(format: "%02ih %02im", hour, minute)
    }
    
    
    //MARK: - IBActions
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
