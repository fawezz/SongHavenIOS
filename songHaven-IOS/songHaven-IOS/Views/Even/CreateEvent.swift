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
                        .frame(width: 150, height: 150)
                        .cornerRadius(40)
                    
                    Text(" New Event ")
                        .bold()
                        .foregroundColor(.purple)
                        .font(.system(size: 34,weight: .light,design:.serif))
                    
                    
                    
                    TextField("Choose title for your Event",text:$viewModel.title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    
                    TextField("Write something about your Event....",text:$viewModel.description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    Group {
                        
                        
                        DatePicker("Date Event",
                                   selection: $viewModel.dateEvent)
                        
                        .accentColor(.purple)
                        .background(Color.purple)
                        
                    }
                  
                    
                    PushView(destination: MapEventView(), tag: "mapView", selection: $viewModel.navigator){}
                    
                    Button(action:{
                        self.navigationStack.push(MapEventView())})
                    {
                        Text("Choose Location")
                            .foregroundColor(.white)
                            .frame(width: 250, height: 30)
                            .padding(8).background(Color.purple)
                            .cornerRadius(20)
                            .frame(width: 36,height: 36 )
                            .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                    }
                  

                    PushView(destination: ArtistEvents(), tag: "addEvent", selection: $viewModel.navigator) {}
                    
                    Button(action:{
                        viewModel.AddEvent()
                    })
                    {
                        Text("Validate")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(!viewModel.validateFields() ? .green : .gray)
                            .cornerRadius(15.0)
                    }.disabled(viewModel.validateFields())
                    
                    
                    
                }.padding(.all)
                if(viewModel.isLoading){
                    ZStack{
                        Color(.white)
                            .opacity(0.7)
                            .ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .scaleEffect(3)
                        
                    }
                }
                
            }
            .toast(isPresenting: $viewModel.showFailToast){
                AlertToast(type: .error(.red), title: viewModel.toastText)
            }
            .toast(isPresenting: $viewModel.showSuccessToast){
                AlertToast(type: .complete(.green), title: viewModel.toastText)
            }
            .navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))
            
            
            if (viewModel.isLoading){
                ZStack{
                    Color(.white)
                    ProgressView()
                }
            }
            
        }
    }
}




