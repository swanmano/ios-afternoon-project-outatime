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
    var timer: Timer?
    var stopTime: Int = 88 // changed this to Int from Date

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalDestinationDatePickerSegue" {
            guard let datePickerVC = segue.destination as? DatePickerViewController else { fatalError() }
            datePickerVC.delegate = self
        }
    }
    
    // MARK: Actions
    @IBAction func setDestinationButtonTapped(_ sender: UIButton) {
    }
    @IBAction func travelBackButtonTapped(_ sender: UIButton) {
        startTimer()
    }
    

    // MARK: Methods
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
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    private func updateSpeed(timer: Timer) {
        if speed < stopTime {
            speed += 2
            updateViews()
        } else {
            resetTimer()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension TimeCircuitsViewController: DatePickerDelegate {
    func destinationDateWasChosen(_ date: Date) {
        destinationLabel.text = string(from: date)
        updateViews()
    }
}
