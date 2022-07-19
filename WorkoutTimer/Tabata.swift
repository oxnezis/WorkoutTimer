//
//  Tabata.swift
//  WorkoutTimer
//
//  Created by Yana on 15.07.2022.
//

import Foundation

class Tabata {
    var rounds: Int
    var time: Double
    var workTime: Double
    var restTime: Double
    var timer: Timer
    
    
    init() {
        rounds = 0
        time = 10.00
        workTime = 40.00
        restTime = 0.00
        timer = Timer()
    }
    
    
}
