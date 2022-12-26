//
//  EditEvent.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import SwiftUI
import NavigationStack
struct EditEvent: View {
    @StateObject var viewModel  = EditEventViewModel()
    @StateObject private var languageService = LocalizationService.shared
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(spacing:20) {
                    Text(" Do you want to Edit Your Event? ".localized(languageService.language))
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    
                    TextField("Choose name for your Event".localized(languageService.language),text:$viewModel.title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    TextField("Write Something about the event ...".localized(languageService.language),text:$viewModel.description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    PushView(destination:ArtistEvents(), tag: "enditBand", selection: $viewModel.navigator) {}
                    
                    Button(action:{
                        viewModel.EditDetails()
                    })
                    {
                        Text("Save changes".localized(languageService.language))
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(.green )
                            .cornerRadius(15.0)
                    }.padding(.all)
                } .navigationBarItems(leading: BackButton(action: {navigationStack.push(ArtistEvents())}))
                
                
                if (viewModel.isLoading){
                    ZStack{
                        Color(.white)
                        ProgressView()
                    }
                } 
            }
        }
    }
}
struct EditEvent_Previews: PreviewProvider {
    static var previews: some View {
        EditEvent()
    }
}
