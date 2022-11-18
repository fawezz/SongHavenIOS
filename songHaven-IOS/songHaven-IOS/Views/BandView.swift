//
//  BandView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct BandView: View {
    @State private var name = ""
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
                
                Text("Friend & Groups")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Text("FRIEND")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        Text("BANDS")
                            .bold()
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        Text("REQUESTS")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        
                        
                    }
                    
                    TextField("Search...",text:$name)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    
                    
                }
            }
        }}
    struct BandView_Previews: PreviewProvider {
        static var previews: some View {
            BandView()
        }
    }
}
