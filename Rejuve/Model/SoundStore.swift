//
//  SoundStore.swift
//  Rejuve
//
//  Created by Justin Rose on 8/5/17.
//  Copyright © 2017 justncode. All rights reserved.
//

public class SoundStore {
    
    var sounds = [Sound]()
    
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
}
