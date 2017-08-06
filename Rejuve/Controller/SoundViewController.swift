//
//  SoundTableViewController.swift
//  Rejuve
//
//  Created by Justin Rose on 7/27/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit

// MARK: - Delegate
protocol SoundViewControllerDelegate {
    func soundSelected(_ sender: SoundViewController, selectedSound: Sound)
}

class SoundViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    var soundStore: SoundStore!
    var delegate: SoundViewControllerDelegate?
    
    // MARK: - IBActions
    @IBAction func dismissSoundController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sets the appropriate sound cell accessory type to .checkmark
        // Select the row so the accessory type changes to .none if user taps another cell
        for row in 0 ..< soundStore.sounds.count {
            if soundStore.sounds[row].fileURL == soundStore.sound.fileURL {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.soundSelected(self, selectedSound: soundStore.sound)
        soundStore.stop()
    }
    
    // MARK: - UI Setup
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Sound"
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource
extension SoundViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundStore.sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = soundStore.sounds[indexPath.row].name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SoundViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 34.0))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .checkmark
        
        soundStore.sound = soundStore.sounds[indexPath.row]
        soundStore.play()
        
        UserDefaults.standard.set(soundStore.sound.name, forKey: "soundName")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .none
        
        soundStore.stop()
    }
}
