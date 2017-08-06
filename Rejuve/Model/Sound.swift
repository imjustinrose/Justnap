//
//  Sound.swift
//  Rejuve
//
//  Created by Justin Rose on 8/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

public class Sound {
    private(set) var name: String
    private(set) var fileURL: String
    private(set) var type: String
    
    public init(_ name: String, fileURL: String, type: String) {
        self.name = name
        self.fileURL = fileURL
        self.type = type
    }
}


