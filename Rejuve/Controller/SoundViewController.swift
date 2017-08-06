//
//  SoundTableViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/27/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit

protocol SoundViewControllerDelegate {
    func soundSelected(_ sender: SoundViewController, selectedSound: Sound)
}

class SoundViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var soundStore: SoundStore!
    var delegate: SoundViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Sound"
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for row in 0 ..< soundStore.sounds.count {
            if soundStore.sounds[row].fileURL == soundStore.sound.fileURL {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 34.0))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundStore.sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = soundStore.sounds[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // UserDefaults
        soundStore.sound = soundStore.sounds[indexPath.row]
        UserDefaults.standard.set(soundStore.sound.name, forKey: "soundName")
        soundStore.play()
        
        cell.accessoryType = .checkmark
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        soundStore.stop()
        cell.accessoryType = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.soundSelected(self, selectedSound: soundStore.sound)
        soundStore.stop()
    }
    
    @IBAction func dismissSoundController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
