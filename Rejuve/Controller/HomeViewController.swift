//
//  HomeViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit
import CircularSlider

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var napDescriptionLabel: UILabel!
    @IBOutlet weak var sleepButton: RoundedButton!
    
    // MARK: -
    var time = (minutes: 0, seconds: 0)
    var soundStore: SoundStore!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCircularSlider()
        setupNavigationBar()
        setNapDescriptionLabel()
    }
    
    // MARK: - UI Setup
    func setupNavigationBar() {
        guard let nav = navigationController else { return }
        
        nav.navigationBar.shadowImage = UIImage()
        extendedLayoutIncludesOpaqueBars = true
    }
    
    fileprivate func setupCircularSlider() {
        circularSlider.delegate = self
        time.minutes = UserDefaults.standard.integer(forKey: "minutes") == 0 ? 10 : UserDefaults.standard.integer(forKey: "minutes")
        circularSlider.value = Float(time.minutes)
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
            napDescriptionLabel.text = "REFRESHED & REJUVENATED"
        case 90:
            napDescriptionLabel.text = "THE PERFECT NAP"
        default:
            napDescriptionLabel.text = "CAT NAP"
        }
    }
    
    func setButtonState() {
        sleepButton.isEnabled = time.minutes == 0 ? false : true
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showNapTimer"?:
            let vc = segue.destination as! NapTimerViewController
            vc.time.minutes = time.minutes
            vc.soundStore = soundStore
        case "showSounds"?:
            let navController = segue.destination as! UINavigationController
            let vc = navController.topViewController as! SoundViewController
            vc.soundStore = soundStore
            vc.delegate = self
        default:
            preconditionFailure("Unexpected segue identifier: \(segue.identifier ?? "")")
        }
    }
}

// MARK: - SoundViewControllerDelegate
extension HomeViewController: SoundViewControllerDelegate {
    func soundSelected(_ sender: SoundViewController, selectedSound: Sound) {
        soundStore.sound = selectedSound
    }
}

// MARK: - CircularSliderDelegate
extension HomeViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        time.minutes = Int(floorf(value))
        UserDefaults.standard.set(time.minutes, forKey: "minutes")
        setNapDescriptionLabel()
        setButtonState()
        
        return floorf(value)
    }
}

