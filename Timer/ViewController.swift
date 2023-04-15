//
//  ViewController.swift
//  Timer
//
//  Created by ホセ・ゴンザレス on 2023/04/09.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var timer : Timer?
    
    var count = 0
    
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let settings = UserDefaults.standard
        
        settings.register(defaults: [settingKey: 10])
        
    }

    @IBOutlet weak var countDown: UILabel!
    
    //リファクタリング
    fileprivate func timerSetting() {
        
        if let nowTimer = timer {
            
            if nowTimer.isValid == true {
                
                nowTimer.invalidate()
            }
            
        }
        
    }
    
    @IBAction func settingButton(_ sender: Any) {
        
        timerSetting()
        
        performSegue(withIdentifier: "goSetting", sender: nil)
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        if let nowTimer = timer {
            
            if nowTimer.isValid == true {
                return
            }
            
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                selector: #selector(self.timerInterrupt(_:)),
                userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButton(_ sender: Any) {
        
       timerSetting()
        
    }
    
    func displayUpdate() -> Int {
        
        let settings = UserDefaults.standard
        
        let timerValue = settings.integer(forKey: settingKey)
        
        let remainCount = timerValue - count
        
        countDown.text = "残り\(remainCount)秒"
        
        return remainCount
        
    }
    
    
    
    @objc func timerInterrupt(_ timer: Timer) {
        
        count += 1
        
        if displayUpdate() <= 0 {
            count = 0
            
            timer.invalidate()
            
       
            
            let alertController = UIAlertController(title: "終了", message: "タイマー終了です！", preferredStyle: .actionSheet)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        count = 0
        
        _ = displayUpdate()
    }
    
}

