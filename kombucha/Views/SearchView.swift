//
//  SearchView.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/24/20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var apps: AllApps = .shared
        
    var body: some View {
        List(apps.filteredApp, id: \.self) {item in
            NavigationLink(destination : ContentView(app: item)) {
                FormulaeRow(app: item)
            }
        }.navigationTitle("Kombucha")
        .navigationSubtitle(String(self.apps.allFound.count) + " search results. Showing first 20")
        
    }
}
