//
//  Stopwatch.swift
//  WorkoutTimer
//
//  Created by Yana on 13.07.2022.
//

import Foundation

class Stopwatch {
    var counter: Double = 0.0
    var timer: Timer
    
    init() {
        counter = 0.0
        timer = Timer()
    }
}
