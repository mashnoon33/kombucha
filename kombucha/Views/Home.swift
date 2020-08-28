//
//  Sidebar.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import SwiftUI


struct Home: View {
    @ObservedObject var installed: InstalledApps = .shared
    
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
    var body: some View {
        List(self.installed.appList, id: \.self) {item in
                NavigationLink(destination : ContentView(app: item)) {
                    FormulaeRow(app: item)
                }
            }.navigationTitle("Kombucha")
        .navigationSubtitle(String(self.installed.appList.count) + " formulaes installed")
    }
}
