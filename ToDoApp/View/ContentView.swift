//
//  ContentView.swift
//  ToDoApp
//
//  Created by Tatiana Simmer on 04/01/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("loginUsernameKey") var loginUsernameKey = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                Home()
                    .navigationBarTitle("Tick-Tack")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                GetUsernameView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    } 
}
