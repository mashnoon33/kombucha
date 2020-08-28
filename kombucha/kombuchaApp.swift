//
//  darkBrewApp.swift
//  darkBrew
//
//  Created by Mashnoon Ibtesum on 8/20/20.
//

import SwiftUI

@main
struct KombuchaApp: App {
    @ObservedObject var installed: InstalledApps = .shared
    @ObservedObject var apps: AllApps = .shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                Sidebar()
                if apps.searching {
                    SearchView()
                }
                else {
                    Home()
                }
                DetailView()
            }.toolbar{
                ToolbarItem(placement: .primaryAction) {
                    TextField("Search", text: $apps.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:200)
                }
            }
        }
    }
}




