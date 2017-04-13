//
//  ViewController.swift
//  aStopWatch
//
//  Created by 黄少华 on 2017/4/13.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var LapButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var LapsTableView: UITableView!
    
    fileprivate var isPlay: Bool = false
    fileprivate let mainStopWatch: StopWatch = StopWatch()
    fileprivate let lapStopWatch: StopWatch = StopWatch()
    fileprivate var laps: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LapButton.layer.cornerRadius = 5
        StopButton.layer.cornerRadius = 5
        
        LapButton.isEnabled = false
        
        LapsTableView.dataSource = self
        LapsTableView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    // MARK: event response
    //点击记录按钮
    @IBAction func layResetTimer(_ sender: UIButton) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(button: sender, title: "记次")
            sender.isEnabled = false
        }else {
            if let timerLabelText = TimerLabel.text {
                laps.append(timerLabelText)
            }
            LapsTableView.reloadData()
            resetLapTimer()
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoopMode.commonModes)
        }
    }

    //点击开始按钮
    @IBAction func stopTimer(_ sender: UIButton) {
        LapButton.isEnabled = true
        changeButton(button: LapButton, title: "记次")
        
        //未计时
        if !isPlay {
            mainStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(mainStopWatch.timer, forMode: RunLoopMode.commonModes)
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoopMode.commonModes)
            
            isPlay = true
            changeButton(button: sender, title: "停止")
        }else {
            mainStopWatch.timer.invalidate()
            lapStopWatch.timer.invalidate()
            
            isPlay = false
            changeButton(button: sender, title: "启动")
            changeButton(button: LapButton, title: "复位")
        }
    }
    
    func updateMainTimer() {
        updateTimer(mainStopWatch, label: TimerLabel)
    }
    
    func updateLapTimer() {
        updateTimer(lapStopWatch, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: StopWatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var secounds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            secounds = "0" + secounds
        }
        
        label.text = minutes + ":" + secounds
    }
    
    func resetMainTimer() {
        mainStopWatch.timer.invalidate()
        mainStopWatch.counter = 0.0
        TimerLabel.text = "00:00:00"
        laps.removeAll()
        LapsTableView.reloadData()
    }
    
    func resetLapTimer() {
        lapStopWatch.timer.invalidate()
        lapStopWatch.counter = 0.0
        lapTimerLabel.text = "00:00:00"
    }
    
    fileprivate func changeButton(button: UIButton, title: String) {
        button.setTitle(title, for: UIControlState.normal)
    }
    
    // MARK: datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID: String = "lapCell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath)
        
        if let labelIndex = cell.viewWithTag(11) as? UILabel {
            labelIndex.text = "记录 \(laps.count - (indexPath as NSIndexPath).row)"
        }
        
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
        return cell
    }
}

fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
