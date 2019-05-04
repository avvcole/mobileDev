//
//  gymController.swift
//  fit
//
//  Created by Avery Eastberg on 3/26/19.
//  Copyright © 2019 AvvCole. All rights reserved.
//

import UIKit

class gymController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var addWorkoutView: UIView!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var time: UIDatePicker!
    @IBOutlet weak var mobility: UISwitch!
    @IBOutlet weak var cardio: UISwitch!
    @IBOutlet weak var weights: UISwitch!
    @IBOutlet weak var hiit: UISwitch!
    @IBOutlet weak var WorkoutList: UITableView!
    
    var workoutsArray: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WorkoutList.tableFooterView = UIView(frame: CGRect.zero)
        
        WorkoutList.separatorColor = UIColor(white: 0.95, alpha: 1)
    
        
        
        self.submitButton.layer.cornerRadius = 17
        submitButton.layer.masksToBounds = true
        submitButton.layer.borderWidth = 1.5;
        submitButton.layer.borderColor = UIColor(red: 0.0, green: 0.98, blue: 0, alpha: 1).cgColor
        
        time.countDownDuration = 3
        
        
    }
    
    
    
    //PRESSING THE + BUTTON AND THE CORRESPONDING VIEW APPEARS
    @IBAction func addWorkout(_ sender: Any) {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            self.addWorkoutView.alpha = 1.0
        }) { (isCompleted) in
            
        }
        addWorkoutView.isHidden = false
        WorkoutList.isHidden = true
        addWorkoutView.layer.cornerRadius = 8
        addWorkoutView.layer.masksToBounds = true
    }
    
    
    
    
    //PRESSING SUBMIT ON THE GOAL SETTER
    @IBAction func submitWorkout(_ sender: Any) {
        
        var mobilitySet: Bool = false
        var cardioSet: Bool = false
        var weightSet: Bool = false
        var hiitSet: Bool = false
        
        //GETTING VALUE FROM DATE PICKER
        //new instance of the DateFormatter
        let dateFormatter = DateFormatter()
        // display format
        dateFormatter.dateFormat = "MM/dd/YY"
        // convert it to a string
        let strDate = dateFormatter.string(from: date.date)
        // set label to our new string with the date
       // lblDisplayDate.text = strDate
        
        
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "H"
        let minFormatter = DateFormatter()
        minFormatter.dateFormat = "mm"
        
        let hourss = hourFormatter.string(from: time.date)
        let minss = minFormatter.string(from: time.date)
        
        let timeThatWorks: String
        
        if hourss == "0"{
            timeThatWorks = "\(minss) MIN"
        }
       else if hourss == "1"{
            if minss == "00"{
                timeThatWorks = "\(hourss) HR"
            }else{
                timeThatWorks = "\(hourss) HR \(minss) MIN"
            }
        }
        else{
            if minss == "00"{
                timeThatWorks = "\(hourss) HRS"
            }else{
                timeThatWorks = "\(hourss) HRS \(minss) MIN"
            }
            
        }
        
        
        if mobility.isOn == true {
            mobilitySet = true
        }
        if cardio.isOn == true {
            cardioSet = true
        }
        if weights.isOn == true {
            weightSet = true
        }
        if hiit.isOn == true {
            hiitSet = true
        }
        
        insertNewWorkout(incomingTime: timeThatWorks, incomingDate: strDate, incomingMobility: mobilitySet, incomingCardio: cardioSet, incomingWeights: weightSet, incomingHIIT: hiitSet)
       
        
        //RESUMES VIEW AND RESETS OPTIONS
        addWorkoutView.isHidden = true
        WorkoutList.isHidden = false
        mobility.isOn = false
        cardio.isOn = false
        weights.isOn = false
        hiit.isOn = false
        date.setDate(Date(), animated: false)
    }
    
    func insertNewWorkout(incomingTime: String, incomingDate: String, incomingMobility: Bool, incomingCardio: Bool, incomingWeights: Bool, incomingHIIT: Bool){
        
        var workoutList: String = ""
        if incomingMobility == true{
            workoutList = workoutList + " MOBILITY."
        }
        if incomingCardio == true{
            workoutList = workoutList + " CARDIO."
        }
        if incomingWeights == true{
            workoutList = workoutList + " WEIGHTS."
        }
        if incomingHIIT == true{
            workoutList = workoutList + " HIIT."
        }
    
        workoutsArray.append(Workout.init(time: incomingTime, date: incomingDate, workout: workoutList))
        let indexPath = IndexPath(row: workoutsArray.count - 1, section: 0)
        WorkoutList.beginUpdates()
        WorkoutList.insertRows(at: [indexPath], with: .automatic)
        WorkoutList.endUpdates()
        
        workoutList = ""
        
    }
    
    //PRESSING THE EXIT X ON THE ADD GOAL VIEW
    @IBAction func exitAddGoal(_ sender: Any) {
        addWorkoutView.isHidden = true
        WorkoutList.isHidden = false
        mobility.isOn = false
        cardio.isOn = false
        weights.isOn = false
        hiit.isOn = false
        
    }
    
    
let cellSpacing: CGFloat = 5

}


extension gymController: UITableViewDataSource, UITableViewDelegate{
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workout = workoutsArray[indexPath.row]
        let cell = WorkoutList.dequeueReusableCell(withIdentifier: "workoutCell") as! workoutCell
   
        cell.setWorkout(workout: workout)
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
       // cell.layer.borderColor = UIColor(red: 0.4784, green: 0.502, blue: 1, alpha: 1).cgColor
        cell.layer.borderWidth = 1.5
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacing
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return cellSpacing
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workoutsArray.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}
