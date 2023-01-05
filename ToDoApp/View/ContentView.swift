//
//  ContentView.swift
//  ToDoApp
//
//  Created by Tatiana Simmer on 04/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Tick Tack")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    } 
}
