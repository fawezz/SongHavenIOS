//
//  CreateEvent.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import SwiftUI
import AlertToast
import NavigationStack

struct CreateEvent: View {
    
    @StateObject var viewModel  = CreateEventViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(spacing:20) {
                    
                    Image("event")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(40)
                    
                    Text(" Do you want to create Your Event ")
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    
                    TextField("Choose title for your Event",text:$viewModel.titre)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    
                    TextField("Write something about your Event",text:$viewModel.description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    
                    DatePicker("Date Event", selection: $viewModel.dateEvent)
                    
                    Text(" Choose Loclisation ")
                        .foregroundColor(.white)
                    
                    
                     
                    
                    
                    
                    
                    
                   
                    
                    
                }
            }
        }
        
    }
    
}


