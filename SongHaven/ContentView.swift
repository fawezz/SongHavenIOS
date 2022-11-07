//
//  ContentView.swift
//  SongHaven
//
//  Created by fawez on 7/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            Text("Welcome To SongHaven")
                .foregroundColor(Color.white)
                .fontWeight(Font.Weight.bold)
            Spacer().frame(height: 50)
            VStack(alignment: .leading, spacing: 15) {
              TextField("Email", text: self.$email)
                .padding()
                .background(Color.white)
                .cornerRadius(20.0)
              SecureField("Password", text: self.$password)
                .padding()
                .background(Color.white)
                .cornerRadius(20.0)
            }.padding([.leading, .trailing], 27.5)
            Spacer().frame(height: 50)
            Button(action: {}) {
              Text("Sign In")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(15.0)
            }
            Spacer()
          }.background(
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
              .edgesIgnoringSafeArea(.all))
    }
/*
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/



}
