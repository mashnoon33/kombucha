//
//  SidebarRow.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import SwiftUI

struct FormulaeRow: View {
    let app: Formulae
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(app.name).font(.headline)
            if app.version != "" {
                Text(app.version.trimmingCharacters(in: .whitespacesAndNewlines)).font(.subheadline)
            }
            else {
                Text(app.isCask ? "Cask" : "Formulae").font(.subheadline)
            }

        }.padding(10)
    }
}

