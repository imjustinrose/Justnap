//
//  NapTimerViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 8/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit

class NapTimerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: -
    var soundStore: SoundStore!
    var timer: Timer!
    var time = (minutes: 0, seconds: 59)
    
    // MARK: - IBActions
    @IBAction func dismissNapTimerViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = "\(time.minutes):00"
        time.minutes -=  1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        setupProximitySensor()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
        soundStore.stop()
    }
    
    func setupProximitySensor() {
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    
    @objc func countdown() {
        switch time.seconds {
        case 0:
            if time.minutes == 0 && time.seconds == 0 {
                timer.invalidate()
                timerLabel.text = "0:00"
                soundStore.play()
                return
            }
            
            time.minutes -= 1
            timerLabel.text = "\(time.minutes):00"
            time.seconds = 59
            
            return
        case 1 ..< 10:
            timerLabel.text = "\(time.minutes):0\(time.seconds)"
            time.seconds -= 1
            return
        default:
            timerLabel.text = "\(time.minutes):\(time.seconds)"
            time.seconds -= 1
        }
    }
}
