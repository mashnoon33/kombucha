//
//  InfoModel.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import Foundation


struct Info {
    let title, subtile, url, dir: String
    let from, lisence: String
    let installed: Bool

    init(blob: String) {
        let split = blob.split(separator: "\n")
        if (!split.isEmpty && blob != "") {
            self.title = String(split[0])
            self.subtile =  String(split[1])
            self.url =  String(split[2])
            self.dir =  String(split[3])
            self.from =  String(split[4])
            self.lisence =  String(split[5])
            self.installed = blob.contains("Not installed")
        }
        else {
            self.title = "nil"
            self.subtile =  "nil"
            self.url = "nil"
            self.dir = "nil"
            self.from =  "nil"
            self.lisence = "nil"
            self.installed = false

        }
    }
    
}

