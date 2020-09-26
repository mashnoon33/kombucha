//
//  Home.swift
//  Kombucha
//
//  Created by Mashnoon Ibtesum on 8/23/20.
//

import SwiftUI

struct Home: View {
    @State  var installed : [Formulae] = [Formulae(name: "d", version: "")]

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
    
//    init() {
//        print("init")
//        installed = shell("/usr/local/bin/brew list -1 --version").split(separator: "\n").map {
//            Formulae(name:  String($0.split(separator: " ")[0]), version:  String($0.split(separator: " ")[1]))
//        }
//        print("Init ended")
//    }
    
    var body: some View {


            List(shell("/usr/local/bin/brew list -1 --version").split(separator: "\n").map {
                Formulae(name:  String($0.split(separator: " ")[0]), version:  String($0.split(separator: " ")[1]))
            }, id: \.self) {item in
                NavigationLink(destination : ContentView(app: item)) {
                    SidebarRow(app: item)
                }
            }
            
            
            
            
        

}
}
