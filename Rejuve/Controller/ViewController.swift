//
//  ViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit
import CircularSlider

class ViewController: UIViewController {
    
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
        }
        
        if segue.identifier == "showSounds" {
            let navController = segue.destination as! UINavigationController
            let vc = navController.topViewController as! SoundViewController
            vc.soundStore = soundStore
        }
    }
}


// MARK: - CircularSliderDelegate
extension ViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        switch floorf(value) {
        case 0:
            napDescriptionLabel.text = ""
        case 10...29:
            napDescriptionLabel.text = "ENERGETIC BOOST"
        case 30...59:
            napDescriptionLabel.text = "POWER NAP"
        case 60...89:
            napDescriptionLabel.text = "REFRESHED & REJUVINATED"
        case 90:
            napDescriptionLabel.text = "THE PERFECT NAP"
        default:
            napDescriptionLabel.text = "CAT NAP"
        }
        
        time.minutes = Int(floorf(value))
        
        return floorf(value)
    }
}

