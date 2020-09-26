//
//  InfoView.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import SwiftUI

struct DetailView: View {
    let app: Formulae
    var data: Info
    @ObservedObject var installed: InstalledApps = .shared
    @State var console: String = "Nothing yet"
    @State private var showingAlert = false
    
    init(app: Formulae, data: Info) {
        self.app = app
        self.data = data
    }
    
    init() {
        self.app = Formulae(name: "", version: "")
        self.data = Info(blob:"")
    }
    
    func install()  {
        print(app)
        DispatchQueue.global(qos: .background).async {
            self.showingAlert = true
            shell("/usr/local/bin/brew" + (app.isCask ? " cask " : " ")  +  "install " + app.name)
            self.installed.updateList()
        }
    }
    
    func uninstall()  {
        print(app)
        DispatchQueue.global(qos: .background).async {
            self.showingAlert = true
            shell("/usr/local/bin/brew" + (app.isCask ? " cask " : " ")  +  "uninstall " + app.name)
            self.installed.updateList()
        }
    }
    
    func shell(_ command: String) {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        var outputString: String = ""
        
        pipe.fileHandleForReading.readabilityHandler = { (fileHandle) -> Void in
            let availableData = fileHandle.availableData
            let newOutput = String.init(data: availableData, encoding: .utf8)
            outputString.append(newOutput!)
            if !(newOutput?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false) {
                self.console = outputString
            }
        }
        
        task.launch()
        task.waitUntilExit()
        
        DispatchQueue.main.async {
            self.console = outputString
        }
        
        pipe.fileHandleForReading.readDataToEndOfFile()

    }
    
    var consoleSheet: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    Text(self.console).padding()
                }
            }
            Button("Close") {
                self.showingAlert = false
            }.padding()
        }.padding(10)
        .frame(width: 400, height: 200, alignment: .leading).foregroundColor(.black)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if  data.title != "nil" {
                VStack(alignment: .leading) {
                    Text(data.title).font(.title).bold()
                    Text(data.subtile).font(.title2)
                    if data.installed {
                        Button(action: install) {
                            Text("Install")
                        }.padding(5)
                        .sheet(isPresented: $showingAlert) {
                            consoleSheet
                        }
                        
                    }
                    else {
                        Button(action: uninstall) {
                            Text("Uninstall")
                        }.padding(5)
                        .sheet(isPresented: $showingAlert) {
                            consoleSheet
                        }
                    }
                    Text(data.url)
                    Text(data.dir)
                    Text(data.from)
                    Text(data.lisence)
                    Spacer()
                }.padding(20)
            }
            else if app.name == "" {
            }
            else {
                ProgressView()
            }
            if data.title != "nil" {
                Spacer()
            }
        }
    }
}
