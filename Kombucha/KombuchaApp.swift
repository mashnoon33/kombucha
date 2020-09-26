//
//  KombuchaApp.swift
//  Kombucha
//
//  Created by Mashnoon Ibtesum on 8/23/20.
//

import SwiftUI

@main
struct KombuchaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Sidebar()
                Home()
                ContentView(app: Formulae(name: "james", version: "String"))
            }
        }
    }
}
