//
//  ContentView.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    let app: Formulae
    @State private var data : Info = Info(blob: "")
    
    func shell(_ command: String) -> String  {

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
    
    func asyncMethod(completion block: @escaping ((String) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            block(shell("/usr/local/bin/brew" + (app.isCask ? " cask " : " ") + "info " + self.app.name))
        }
    }
    
    var body: some View {
        DetailView(app: self.app, data: self.data).onAppear {
            asyncMethod { value in
                self.data = Info(blob: value)
            }
        }
    }
}
