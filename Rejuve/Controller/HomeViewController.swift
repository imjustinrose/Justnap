//
//  HomeViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit
import CircularSlider

class HomeViewController: UIViewController, SoundViewControllerDelegate {
    
    var soundStore: SoundStore!
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var napDescriptionLabel: UILabel!
    
    var time = (minutes: 0, seconds: 0)
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCircularSlider()
        setupNavigationBar()
        setNapDescriptionLabel()
        
        
        
        
        time.minutes = UserDefaults.standard.integer(forKey: "minutes")
        circularSlider.value = Float(time.minutes)
        
        
    }
    
    func setupNavigationBar() {
        guard let nav = navigationController else { return }
        nav.navigationBar.shadowImage = UIImage()
        extendedLayoutIncludesOpaqueBars = true
    }
    
    fileprivate func setupCircularSlider() {
        circularSlider.delegate = self
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
            self.napDescriptionLabel.text = ""
        case 10...29:
            self.napDescriptionLabel.text = "ENERGETIC BOOST"
        case 30...59:
            self.napDescriptionLabel.text = "POWER NAP"
        case 60...89:
            napDescriptionLabel.text = "REFRESHED & REJUVINATED"
        case 90:
            napDescriptionLabel.text = "THE PERFECT NAP"
        default:
            napDescriptionLabel.text = "CAT NAP"
        }
    }
}


// MARK: - CircularSliderDelegate
extension HomeViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        time.minutes = Int(floorf(value))
        UserDefaults.standard.set(time.minutes, forKey: "minutes")
        setNapDescriptionLabel()
        
        return floorf(value)
    }
}

