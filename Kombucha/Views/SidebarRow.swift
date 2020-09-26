//
//  SidebarRow.swift
//  kombucha
//
//  Created by Mashnoon Ibtesum on 8/22/20.
//

import SwiftUI

struct SidebarRow: View {
    let app: Formulae
    var body: some View {
        VStack(alignment: .leading) {
            Text(app.name).font(.headline)
            Text(app.version.trimmingCharacters(in: .whitespacesAndNewlines)).font(.subheadline)

        }.padding(10)
    }
}

