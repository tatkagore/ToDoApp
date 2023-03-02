//
//  GetUsernameView.swift
//  ToDoApp
//
//  Created by Tatiana Simmer on 06/01/2023.
//

import SwiftUI

struct GetUsernameView: View {
    @State var loginUsername: String = ""
    @AppStorage("loginUsernameKey") var loginUsernameKey = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Lavender").opacity(0.7)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                   .scale(1.35)
                   .foregroundColor(.white)
                VStack {
                    Text("Welcome!")
                        .foregroundColor(Color.primary)
                        .font(.largeTitle)
                        .bold()
                        .padding(10)
                    TextField("Please enter your name", text:$loginUsernameKey)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(.black).opacity(0.05))
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(Color.primary.opacity(0.3)))
                        .padding(10)
                    Button {
                        isLoggedIn = true
                    } label: {
                            Text("Log In")
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("Lavender")
                            .cornerRadius(15))
                            .foregroundColor(Color.white)
                    }
                }
            }
    }
    }
}

struct GetUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        GetUsernameView()
    }
}
