//
//  SoundTableViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/27/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit

class SoundViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var soundStore: SoundStore!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Sound"
        
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 34.0))
        
        switch section {
        case 0:
            break
        case 1:
            let label = UILabel()
            label.frame = CGRect(x: 16, y: 44.0 - 24.0, width: tableView.bounds.size.width, height: 18.0)
            label.font = UIFont.systemFont(ofSize: 14.0)
            label.textColor = UIColor(red: 160.0/255, green: 192.0/255, blue: 234.0/255, alpha: 1.0)
            label.text = "USE MY MUSIC"
            
            headerView.addSubview(label)
            
            return headerView
        default:
            break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch  section {
        case 0:
            return 34.0
        case 1:
            return 44.0
        default:
            break
        }
        
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return soundStore.sounds.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = soundStore.sounds[indexPath.row].name
            break
        case 1:
            cell.textLabel?.text = "Select track"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // UserDefaults
        let sound = soundStore.sounds[indexPath.row]
        sound.checked = true
        sound.play()
        
        cell.accessoryType = .checkmark
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // UserDefaults
        let sound = soundStore.sounds[indexPath.row]
        sound.checked = false
        sound.stop()
        
        cell.accessoryType = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func dismissSoundController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
