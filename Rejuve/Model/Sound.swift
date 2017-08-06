//
//  Sound.swift
//  Rejuve
//
//  Created by Justin Rose on 8/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import AVFoundation

public class Sound {
    private(set) var name: String
    private(set) var fileURL: String
    private(set) var type: String
    var checked: Bool
    
    private var player: AVAudioPlayer?
    
    public init(_ name: String, fileURL: String, type: String) {
        self.name = name
        self.fileURL = fileURL
        self.type = type
        checked = false
    }
    
    func play() {
        guard let url = Bundle.main.url(forResource: fileURL, withExtension: type) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        player?.stop()
    }
}


