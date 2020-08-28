//
//  Sidebar.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        
        ZStack {
            List() {
                NavigationLink(destination: Home()) {
                    HStack {
                        Image(systemName: "desktopcomputer")
                        Text("Installed")
                    }
                }
                
                NavigationLink(destination: SearchView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Updates")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(maxHeight: .infinity)
               
        }
    }
}
