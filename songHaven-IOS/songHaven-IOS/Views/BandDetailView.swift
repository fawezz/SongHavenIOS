//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/11/2022.
//

import SwiftUI

struct BandDetailView: View {
    @State private var BandName = "Metalika"
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Text(BandName)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
                    
                    
                }
            }
        }
    }
    
    struct BandDetailView_Previews: PreviewProvider {
        static var previews: some View {
            BandDetailView()
        }
    }
}
