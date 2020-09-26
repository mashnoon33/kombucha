//
//  Sidebar.swift
//  Kombucha
//
//  Created by Mashnoon Ibtesum on 8/23/20.
//

import SwiftUI

struct Sidebar: View {
    @State var selection: Set<Int> = [0]

    var body: some View {
        List(selection: self.$selection) {
            Label("Tasks", systemImage: "largecircle.fill.circle")
                .tag(0)
            Label("Today", systemImage: "star.fill")
            Label("Upcoming", systemImage: "calendar")
            
            Divider()
            
            Label("Activity", systemImage: "clock.fill")
            Label("Trash", systemImage: "trash.fill")
            
            Divider()
            
            Label("New List", systemImage: "plus")
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)

    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
