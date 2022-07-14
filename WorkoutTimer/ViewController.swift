//
//  ViewController.swift
//  WorkoutTimer
//
//  Created by Yana on 12.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    
    var isPlay = false
    var mainStopwatch = Stopwatch()
    var lapStopwatch = Stopwatch()
    var laps = [String]()
    


    
    
    

    
    // MARK: UI-components
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var clearButtonView: UIButton!
    @IBOutlet weak var startButtonView: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    
    
    
    
    
    
    
    
    // MARK: life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButtonView.isEnabled = false
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
        
    }
    
    
    
    // MARK: Actions
    @IBAction func startButton(_ sender: Any) {
        clearButtonView.isEnabled = true
        changeButton(clearButtonView, title: "Round", titleColor: UIColor.gray)
        
        if !isPlay {
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(startButtonView, title: "Stop", titleColor: UIColor.red)
            
        } else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(startButtonView, title: "Start", titleColor: UIColor.green)
            changeButton(clearButtonView, title: "Reset", titleColor: UIColor.gray)
        }
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(clearButtonView, title: "Round", titleColor: UIColor.darkGray)
            clearButtonView.isEnabled = false
            
            
        } else {
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
                
            }
            lapsTableView.reloadData()
            resetLapTimer()
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    
    
    
    
    
    
    // MARK: helper func
    func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    
    
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter += 0.035
        
        var minutes = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0\(seconds)"
        }
        
        label.text = "\(minutes):\(seconds)"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    
    
    
    
    func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }

    
 
    
//    // MARK: - UI Settings
//    override var shouldAutorotate : Bool {
//      return false
//    }
//
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//      return UIStatusBarStyle.lightContent
//    }
//
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//      return UIInterfaceOrientationMask.portrait
//    }
    
    
    
    
    
}




// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifire = "roundCell"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        if let labelNum = cell.viewWithTag(7) as? UILabel {
            labelNum.text = "Round \(laps.count - (indexPath as NSIndexPath).row)"
            
        }
        
        if let labelTimer = cell.viewWithTag(8) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
        return cell
    }
}


extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}






