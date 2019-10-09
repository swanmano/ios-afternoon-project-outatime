//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by Craig Swanson on 10/8/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var departedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    // MARK: Properties
    var currentTime = Date()
    var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = TimeZone(abbreviation: "CDT")
        return formatter
    }()
    var speed: Int = 0
    var lastDeparted: Date? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    // MARK: Actions
    @IBAction func setDestinationButtonTapped(_ sender: UIButton) {
    }
    @IBAction func trabelBackButtonTapped(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func updateViews() {
        presentLabel.text = string(from: currentTime)
        speedLabel.text = String("\(speed) MPH")
        if let lastDeparted = lastDeparted {
            departedLabel.text = string(from: lastDeparted)
        } else {
            departedLabel.text = "--- -- ----"
        }
    }
    
    private func string(from dateEntry: Date) -> String {
        return dateFormatter.string(from: dateEntry)
    }

}
