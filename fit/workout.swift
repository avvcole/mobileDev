//
//  workout.swift
//  fit
//
//  Created by Avery Eastberg on 4/17/19.
//  Copyright © 2019 AvvCole. All rights reserved.
//

import Foundation


class Workout {
    var time: String
    var date: String
    var workout: String
    
    init(time: String, date: String, workout: String){
        self.time = time
        self.date = date
        self.workout = workout
    }
}
