//
//  ViewController.swift
//  fit
//
//  Created by Avery Eastberg on 3/13/19.
//  Copyright © 2019 AvvCole. All rights reserved.
//

import UIKit
var progressForBar: Float!


class ViewController: UIViewController {

    @IBOutlet weak var progressBar: progressBar!
    @IBOutlet weak var waterGoals: UIButton!
    @IBOutlet weak var waterGoalsView: UIView!
    @IBOutlet weak var confirmWaterGoal: UIButton!
    @IBOutlet weak var waterGoal: UITextView!
    @IBOutlet weak var enteredGoals: UITextField!
    @IBOutlet weak var toGoCups: UILabel!
    @IBOutlet weak var steppper: UIStepper!
    var totalCups: Int!
    var stepper: Float!
    var goal: Float!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmWaterGoal.layer.cornerRadius = 15
        confirmWaterGoal.layer.borderWidth = 1.5
        confirmWaterGoal.layer.borderColor = UIColor(red: 0.0, green: 0.98, blue: 0.0, alpha: 1).cgColor

        stepper = 0
        goal = 1

        }
        


    //ADD GOAL MODAL
    @IBAction func waterGoalPressed(_ sender: Any) {
        
        waterGoalsView.isHidden = false
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            self.waterGoalsView.alpha = 1.0
        }) { (isCompleted) in
            
        }
        
        
        
       // waterGoalsView.isHidden = false
        progressBar.isHidden = true
        waterGoalsView.layer.cornerRadius = 8
    }
    
    //UPDATING THE COUNT OF CONSUMED CUPS W THE STEPPER
    @IBAction func updateTotal(_ sender: UIStepper) {
        
         stepper = Float(sender.value)
         //goal = Int(enteredGoals.text!)
        
        if(goal == nil){
            
            toGoCups.text = "Set your daily goal to start tracking!"
            stepper = 0
            progressBar.isHidden = true
        }
        else{
            steppper.isHidden = false
            
            let togo: Float = goal! - stepper
            
            progressBar.isHidden = false
            if goal == 0{
                return
            }else{
                print("stepper: \(stepper!)")
                print("goal: \(goal!)")
                let test = Double(stepper / goal!)
                let test2 = CGFloat(test)
                print("progress \(test)")
                print("progress \(test2)")
                progressBar.progress = CGFloat((stepper / goal!))
                //print("update total \(progressBar.progress)")
            }
        
            if (togo <= 0){
                toGoCups.text = "You made it to your daily goal!"
            }else if(togo == 1){
                toGoCups.text = "\(floorf(togo)) cup \n to daily goal!"
            }
            else{
                toGoCups.text = "\(togo) cups \n to daily goal!"
            }
        
    }
    }
    
    //PRESSING THE SET GOAL BUTTON IN THE GOAL SET VIEW
    @IBAction func confirmWaterPressed(_ sender: Any) {
        waterGoalsView.isHidden = true
        
        progressBar.isHidden = false
        setWaterGoal()
        steppper.isHidden = false
        progressBar.progress = CGFloat()
        
        
    }
    @IBAction func idk(_ sender: Any) {
      
        enteredGoals.becomeFirstResponder()
    }
    
    //RESIGNING KEYPAD WHEN TOUCHING OUTSIDE OF IT
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       enteredGoals.resignFirstResponder()

   }
    
    //SETTING THE GOAL CUPS FROM USER INPUT
    func setWaterGoal(){
        goal = Float(enteredGoals.text!)
        stepper = 0.0
        steppper.value = 0.0
        totalCups = 0
        
        
        waterGoal.text = "Current daily water goal: \n \(goal!) cups"
        toGoCups.text = "\(goal!) cups \n to daily goal!"
        
}
    
    //EXITING THE ADD GOAL VIEW BY PRESSING THE X
    @IBAction func exitAddGoal(_ sender: Any) {
  
        enteredGoals.resignFirstResponder()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.waterGoalsView.alpha = 0.0 
        }) { (isCompleted) in
            self.waterGoalsView.isHidden = true
            
        }
        
    }
}
