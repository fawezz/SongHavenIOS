//
//  DetailsEvent.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import SwiftUI
import Foundation
import NavigationStack
struct DetailsEvent: View {
    @StateObject var viewModel : DetailEventViewModel
    @StateObject private var languageService = LocalizationService.shared
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    
                    BackButton(action: {navigationStack.pop()})
                    
                    Text("About your Event ".localized(languageService.language))
                        .bold()
                        .foregroundColor(.main_color_hard)
                        .font(.system(size: 34,weight: .light,design: .serif))
                    
                    
                    VStack(spacing: 5) {
                        Text(viewModel.selectedEvent.title! )
                            .font(.system(size: 25,weight: .light,design: .serif).italic())
                            .foregroundColor(.white)
                            .frame(alignment: .topTrailing)
                        
                        Text( viewModel.selectedEvent.description!)
                            .bold()
                            .foregroundColor(.white)
                        
                    }.padding()
                }
            }
        }
    }
}

