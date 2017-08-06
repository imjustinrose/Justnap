//
//  ViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit
import CircularSlider

class ViewController: UIViewController, SoundViewControllerDelegate {
    
    var soundStore: SoundStore!
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var napDescriptionLabel: UILabel!
    
    var time = (minutes: 0, seconds: 0)
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCircularSlider()
        
        extendedLayoutIncludesOpaqueBars = true
        setupNavigationBar()
        
        time.minutes = UserDefaults.standard.integer(forKey: "minutes")
        print("time.min: ", time.minutes)
        setNapDescriptionLabel()
    }
    
    func setupNavigationBar() {
        guard let nav = navigationController else { return }
        nav.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - methods
    fileprivate func setupCircularSlider() {
        circularSlider.delegate = self
    }
    
    // MARK: - IBActions
    @IBAction func decrementAction(_ sender: UIButton) {
        circularSlider.setValue(circularSlider.value - 50, animated: true)
    }
    
    @IBAction func incrementAction(_ sender: UIButton) {
        circularSlider.setValue(circularSlider.value + 50, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNapTimer" {
            let vc = segue.destination as! NapTimerViewController
            vc.time.minutes = time.minutes
            vc.soundStore = soundStore
        }
        
        if segue.identifier == "showSounds" {
            let navController = segue.destination as! UINavigationController
            let vc = navController.topViewController as! SoundViewController
            vc.soundStore = soundStore
            vc.soundStore = soundStore
            vc.delegate = self
        }
    }
    
    func soundSelected(_ sender: SoundViewController, selectedSound: Sound) {
        soundStore.sound = selectedSound
    }
    
    func setNapDescriptionLabel() {
        switch time.minutes {
        case 0:
            self.napDescriptionLabel.fadeOut()
            self.napDescriptionLabel.text = ""
            self.napDescriptionLabel.fadeIn()
        case 10...29:
            if time.minutes == 10 || time.minutes == 29 {
                self.napDescriptionLabel.fadeOut()
                self.napDescriptionLabel.text = "ENERGETIC BOOST"
                self.napDescriptionLabel.fadeIn()
            }
        case 30...59:
            if time.minutes == 30 || time.minutes == 59 {
                self.napDescriptionLabel.fadeOut()
                self.napDescriptionLabel.text = "POWER NAP"
                self.napDescriptionLabel.fadeIn()
            }
        case 60...89:
            if time.minutes == 60 || time.minutes == 89 {
                self.napDescriptionLabel.fadeOut()
                napDescriptionLabel.text = "REFRESHED & REJUVINATED"
                self.napDescriptionLabel.fadeIn()
            }
        case 90:
            if time.minutes == 90 {
                self.napDescriptionLabel.fadeOut()
                napDescriptionLabel.text = "THE PERFECT NAP"
                self.napDescriptionLabel.fadeIn()
            }
        default:
            if time.minutes == 1 || time.minutes == 9 {
                self.napDescriptionLabel.fadeOut()
                napDescriptionLabel.text = "CAT NAP"
                self.napDescriptionLabel.fadeIn()
            }
        }
    }
}


// MARK: - CircularSliderDelegate
extension ViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        print("called")
        time.minutes = Int(floorf(value))
        UserDefaults.standard.set(time.minutes, forKey: "minutes")
        print("time.min: ", time.minutes)
        
        setNapDescriptionLabel()
        
        return floorf(value)
    }
}

extension UIView {
    
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
}

