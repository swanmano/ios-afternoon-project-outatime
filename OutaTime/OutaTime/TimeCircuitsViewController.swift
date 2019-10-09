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
    var speed: Int = 0
    var lastDeparted: Date? = nil
    var destination: Date?
    var timer: Timer?
    var stopTime: Int = 88  // hard coded the critical speed for the Delorean

    // format the three date labels
    var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = TimeZone(abbreviation: "CDT")
        return formatter
    }()
    
    // include the metal looking background in the VC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
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
        // set presentLabel to the formatted current time
        presentLabel.text = string(from: currentTime)
        // set the speedLabel to the calculated speed
        speedLabel.text = String("\(speed) MPH")
        //set the departed label to dashes if nil or a formatted date if not nil
        if let lastDeparted = lastDeparted {
            departedLabel.text = string(from: lastDeparted)
        } else {
            departedLabel.text = "--- -- ----"
        }
        // set the destination label to a formatted date if not nil
        guard let destination = destination else { return }
            destinationLabel.text = string(from: destination)
    }
    
    // format the dates into a string
    private func string(from dateEntry: Date) -> String {
        return dateFormatter.string(from: dateEntry)
    }
    
    // set the timer to update the speed label ever tenth of a second
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    // update the speed until the speed equals the stopTime of 88
    // when the speed reaches 88, stop the timer, adjust the labels, and show an alert.
    private func updateSpeed(timer: Timer) {
        if speed < stopTime {
            speed += 2
            updateViews()
        } else {
            resetTimer()
            speed = 0
            speedLabel.text = String("\(speed) MPH")
            departedLabel.text = presentLabel.text
            presentLabel.text = destinationLabel.text
            showAlert()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func showAlert() {
        guard let destination = destination else { return }
        let alert = UIAlertController(title: "Time Travel Successful", message: "Congratulations time traveler! Your new date is \(string(from: destination))", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Let's get Biff!", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension TimeCircuitsViewController: DatePickerDelegate {
    func destinationDateWasChosen(_ date: Date) {
        destination = date
        updateViews()
    }
}
