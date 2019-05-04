//
//  sleepController.swift
//  fit
//
//  Created by Avery Eastberg on 3/26/19.
//  Copyright © 2019 AvvCole. All rights reserved.
//

import UIKit

class sleepController: UIViewController {

    @IBOutlet weak var addGoalView: UIView!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var enteredText: UITextField!
    @IBOutlet weak var sleepAmountView: UIView!
    @IBOutlet weak var textEntry: UITextField!
    @IBOutlet weak var entryButton: UIButton!
    @IBOutlet weak var progressBarView: progressBar!
    var sleepGoal: Float = 0.0
    var sleepAmount: Float = 0.0
    @IBOutlet weak var statusMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setButton.layer.cornerRadius = 15
        setButton.layer.borderWidth = 1.5
        setButton.layer.borderColor = UIColor(red:0.00, green:0.98, blue:0.00, alpha:1.0).cgColor
        
        entryButton.layer.cornerRadius = 15
        entryButton.layer.borderWidth = 1.5
        entryButton.layer.borderColor = UIColor(red:0.00, green:0.98, blue:0.00, alpha:1.0).cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progressBarView.isHidden = true
        statusMessage.isHidden = true
        if (sleepGoal == 0.0 ){
            addGoalView.isHidden = false
            sleepAmountView.isHidden = true
        }
        else{
            textEntry.text?.removeAll()
            addGoalView.isHidden = true
            sleepAmountView.isHidden = false
        }
    }
    
    //ADD SLEEP GOAL TO BEGIN TRACKING
    @IBAction func addSleepGoal(_ sender: Any) {
        progressBarView.isHidden = true
         statusMessage.isHidden = true
        addGoalView.isHidden = false
        addGoalView.layer.cornerRadius = 8
        sleepAmountView.isHidden = true
        enteredText.text?.removeAll()
    }
    
    //HITTING SET GOAL BUTTON
    @IBAction func setSleepGoal(_ sender: Any) {
        
        addGoalView.isHidden = true
        
       enteredText.resignFirstResponder()
        sleepGoal = Float(enteredText.text!)!
        sleepAmountView.isHidden = false
        textEntry.text?.removeAll()
    }
    
    //PRESSING THE EXIT X ON THE ADD GOAL VIEW
    @IBAction func exitAddGoal(_ sender: Any) {
        addGoalView.isHidden = true
        enteredText.resignFirstResponder()
    }
    @IBAction func keyboardBro(_ sender: Any) {
        enteredText.becomeFirstResponder()
    }
    //RESIGNING KEYPAD WHEN TOUCHING OUTSIDE OF IT
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enteredText.resignFirstResponder()
        
    }
    @IBAction func enterSleepAmount(_ sender: Any) {
        addGoalView.isHidden = true
        sleepAmountView.isHidden = true
        sleepAmount = Float(textEntry.text!)!
        progressBarView.isHidden = false
         statusMessage.isHidden = false
        enteredText.resignFirstResponder()
        
        setProgressBar()
        
    }

    @IBAction func exitSleepAmount(_ sender: Any) {
        sleepAmountView.isHidden = true
    }
    
    func setProgressBar(){
        progressBarView.progress = CGFloat(sleepAmount/sleepGoal)
        var todaysAmount: Float = sleepAmount/sleepGoal
        if(todaysAmount == 1){
            statusMessage.text = "You made your daily sleep goal!"
        }
        else if(todaysAmount > sleepGoal){
            statusMessage.text = "You surpassed your daily goal!"
        }
        else{
            statusMessage.text = "Didn't quite make your sleep goal."
        }
    }
}
