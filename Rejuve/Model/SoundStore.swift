//
//  SoundStore.swift
//  Rejuve
//
//  Created by Justin Rose on 8/5/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import AVFoundation

public class SoundStore {
    
    var sounds = [Sound]()
    var sound: Sound!
    private var player: AVAudioPlayer?
    
    @discardableResult func createSound(_ name: String, fileURL: String, type: String) -> Sound {
        let sound = Sound(name, fileURL: fileURL, type: type)
        sounds.append(sound)
        
        return sound
    }
    
    init(_ sounds: [Sound]) {
        for sound in sounds {
            createSound(sound.name, fileURL: sound.fileURL, type: sound.type)
        }
    }
    
    func play() {
        guard let url = Bundle.main.url(forResource: sound.fileURL, withExtension: sound.type) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.numberOfLoops = -1
            player.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        player?.stop()
    }
}
