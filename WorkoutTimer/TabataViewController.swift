//
//  TabataViewController.swift
//  WorkoutTimer
//
//  Created by Yana on 15.07.2022.
//

import UIKit

class TabataViewController: UIViewController {
    
    var tabata = Tabata()
    var isWork = false
    
    //MARK: UI-components
    
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var tabataWorkTimerLabel: UILabel!
    @IBOutlet weak var tabataRestTimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetPauseButton: UIButton!
    @IBOutlet weak var tabataProgresView: UIProgressView!
    
    
    //MARK: Actions
    
    @IBAction func startStopButton(_ sender: UIButton) {
        resetPauseButton.isEnabled = true
        changeTabataButton(resetPauseButton, title: "Pause", color: .lightGray)
        if !isWork {
            tabata.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateWorkTimer), userInfo: nil, repeats: true)
            isWork = true
            changeTabataButton(startStopButton, title: "Stop", color: .red)
            
            
            
        } else {
            
            
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func resetPauseButton(_ sender: UIButton) {
        if !isWork {
            
            
            
        } else {
            
            
            
            
            
        }
    }
    
    
    //MARK: Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: Helper func
    func changeTabataButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(color, for: UIControl.State())
    }
    
    func updateTimer(_ tabataTimer: Tabata, label: UILabel) {
        
        if tabataTimer.time > 0.035 {
            tabataTimer.time -= 0.035
            var minutes = "\((Int)(tabataTimer.time / 60))"
            if ((Int)(tabataTimer.time / 60)) < 10 {
            minutes = "0\((Int)(tabataTimer.time / 60))"
            }
        
            var seconds = String(format: "%.2f",(tabataTimer.time.truncatingRemainder(dividingBy: 60)))
            if tabataTimer.time.truncatingRemainder(dividingBy: 60) < 10 {
                seconds = "0\(seconds)"
            }
            label.text = "\(minutes):\(seconds)"
        } else {
            isWork = false
        }
    }

    @objc func updateWorkTimer() {
        updateTimer(tabata, label: tabataWorkTimerLabel)
    }

}
