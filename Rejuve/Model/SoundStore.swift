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
    
    init() {
        
        sounds = [
            Sound(name: "Going Higher", fileURL: "bensound-goinghigher", type: "mp3"),
            Sound(name: "Energy", fileURL: "bensound-energy", type: "mp3"),
            Sound(name: "Memories", fileURL: "bensound-memories", type: "mp3"),
            Sound(name: "Ukulele", fileURL: "bensound-ukulele", type: "mp3"),
            Sound(name: "Better Days", fileURL: "bensound-betterdays", type: "mp3"),
            Sound(name: "A New Beginning", fileURL: "bensound-anewbeginning", type: "mp3"),
            Sound(name: "Happy Rock", fileURL: "bensound-happyrock", type: "mp3"),
            Sound(name: "Jazzy Frenchy", fileURL: "bensound-jazzyfrenchy", type: "mp3")
        ]
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
