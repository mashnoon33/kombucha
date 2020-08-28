//
//  App.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import Foundation


struct Formulae : Hashable {
    let name, version: String
    var isCask: Bool = false
    
    init(name: String, version: String) {
        self.name = name
        self.version = version
    }
    
    init(name: String, version: String, isCask: Bool) {
        self.name = name
        self.version = version
        self.isCask = isCask
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name+version)
    }
}
//gdbm: stable 1.18.1 (bottled)
//GNU database manager
//https://www.gnu.org/software/gdbm/
///usr/local/Cellar/gdbm/1.18.1_1 (25 files, 787KB) *
//  Built from source on 2020-08-08 at 15:48:41
//From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/gdbm.rb
//License: GPL-3.0
//==> Analytics
//install: 505,976 (30 days), 898,506 (90 days), 2,939,331 (365 days)
//install-on-request: 10,819 (30 days), 13,594 (90 days), 31,158 (365 days)
//build-error: 0 (30 days)
