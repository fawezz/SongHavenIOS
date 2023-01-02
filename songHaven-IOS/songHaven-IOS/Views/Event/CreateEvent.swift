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
    @StateObject private var languageService = LocalizationService.shared
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
                    
                    Text("Txt1".localized(languageService.language))
                        .bold()
                        .foregroundColor(.purple)
                        .font(.system(size: 34,weight: .light,design:.serif))
                    
                    TextField("Txt2".localized(languageService.language),text:$viewModel.title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    
                    TextField("Txt3".localized(languageService.language),text:$viewModel.description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    HStack{
                        
                        TextField("Txt4".localized(languageService.language),text:$viewModel.longitud)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .autocorrectionDisabled(true)
                        
                        PushView(destination: MapView(), tag: "mapView", selection: $viewModel.navigator){}
                        Button (
                            action: {
                                self.navigationStack.push(MapView())
                                },
                            label: {
                                Label("", systemImage: "location.fill")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                    .background(.purple)
                                    .cornerRadius(50)
                            })
                        
                    }
                    Group {
                        
                        
                        DatePicker("Txt5".localized(languageService.language),
                                   selection: $viewModel.dateEvent)
                        .foregroundColor(.white)
                        .accentColor(.purple)
                        .background(Color.purple)
                        .cornerRadius(15)
                        .datePickerStyle(.automatic)
                        
                    }
                    PushView(destination: ArtistEvents(), tag: "artistEvents", selection: $viewModel.navigator) {}
                    
                    Button(action:{
                        viewModel.AddEvent()
                    })
                    {
                        Text("Txt6".localized(languageService.language))
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

struct CreateEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateEvent()
    }
    
}

