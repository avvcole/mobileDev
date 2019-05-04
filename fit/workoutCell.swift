//
//  workoutCell.swift
//  fit
//
//  Created by Avery Eastberg on 4/17/19.
//  Copyright © 2019 AvvCole. All rights reserved.
//

import UIKit



class workoutCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    
    func setWorkout(workout: Workout){
        timeLabel.text = workout.time
        dateLabel.text = workout.date
        workoutLabel.text = workout.workout
    }
    


}
