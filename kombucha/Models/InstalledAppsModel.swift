//
//  InstalledAppsModel.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/25/20.
//

import Foundation

class InstalledApps: ObservableObject {
    @Published var appList: [Formulae] = []
    @Published var formulaCount: Int = 0
    @Published var caskCount: Int = 0

    
    
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
        DispatchQueue.main.async {
            self.appList = self.updateList()
            print("Formulaes loaded")

            DispatchQueue.main.async {
                self.appList.append(contentsOf: self.updateListCask())
                print("Casks loaded")

            }

        }
    }

    static let shared = InstalledApps()

    func updateList() -> [Formulae] {
        
        let res =  shell("/usr/local/bin/brew list -1 --version").split(separator: "\n").map {
            Formulae(name:  String($0.split(separator: " ")[0]), version:  String($0.split(separator: " ")[1]))
        }

        DispatchQueue.main.async {
            self.formulaCount = res.count
            self.appList = res
                }
        
        return res
    }
    
    func updateListCask() -> [Formulae] {
        
        let res =  shell("/usr/local/bin/brew cask list --version").split(separator: "\n").map {
            Formulae(name:  String($0.split(separator: " ")[0]), version:  String($0.split(separator: " ")[1]), isCask: true)
        }
        self.caskCount = res.count

//        DispatchQueue.main.async {
//            self.appList = res
//                }
        return res
    }

}
