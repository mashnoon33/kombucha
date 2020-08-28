//
//  AllAppsModel.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/25/20.
//


import Foundation
import Combine


class AllApps: ObservableObject {
    
    @Published var searchText = ""
    @Published var searching = false
    var allApps: [Formulae] = []
    var filteredApp: [Formulae] = [Formulae]()
    var allFound: [Formulae] = [Formulae]()
    
    var publisher: AnyCancellable?
    
    func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    private init() {
        self.updateList()
        self.filteredApp = self.allApps
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [self] (str) in
                if (!self.searchText.isEmpty ) {
                    self.searching = true
                    self.allFound = self.allApps.filter { $0.name.trimmingCharacters(in: .whitespacesAndNewlines).contains(str.trimmingCharacters(in: .whitespacesAndNewlines)) }
                    var index : Int = 20
                    if (self.allFound.count < 20) {
                        index = self.allFound.count
                    }
                    if !self.allFound.isEmpty {
                        self.filteredApp = Array(self.allFound[0 ..< index])
                    }
                    
                } else {
                    if !self.allApps.isEmpty {
                        self.filteredApp = Array(self.allApps[0 ..< 20])
                        self.allFound = self.allApps
                    }
                }
            })
        
    }
    
    static let shared = AllApps()
    
    func updateList()  {
        DispatchQueue.global(qos: .background).async {
            var all = [Formulae]()
            let formule =  self.shell("/usr/local/bin/brew search --formula").split(separator: "\n").map {
                Formulae(name:  String($0), version: "")
            }
            let casks =  self.shell("/usr/local/bin/brew search --cask").split(separator: "\n").map {
                Formulae(name:  String($0), version: "", isCask: true)
            }
            all.append(contentsOf: formule)
            all.append(contentsOf: casks)
            
            self.allApps = all
            self.filteredApp = Array(all[0 ..< 20])
            self.allFound = all
            print("Search items loaded")
        }
    }
}
