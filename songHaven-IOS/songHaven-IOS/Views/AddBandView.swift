//
//  AddBandView.swift
//  songHaven-IOS
//
//  Created by SongH on 25/11/2022.
//

import SwiftUI

struct AddBandView: View {
    
    @State private var name = ""
    @State private var discription = ""
    @StateObject var viewModel  = AddBandViewModel()
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Text(" Do you want to create Your Band? ")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    VStack(spacing: 20){
                        Image("META")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFit()
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 50)
                            .frame(width: 150,height: 150)
                        
                        TextField("Choose name for your Band",text:$viewModel.name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .autocorrectionDisabled(true)
                        
                        
                        TextField("Read Something about you...",text:$viewModel.discription)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .autocorrectionDisabled(true)
                        
            
                        
                    }
                    ScrollView{
                        ArtistRowItem()
                        ArtistRowItem()
                        ArtistRowItem()
                        ArtistRowItem()
                    }
                    
                    
                    Button(action: {
                       
                    }) {
                        /*Text("Validate")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(.green)
                            .cornerRadius(15.0)*/
                        
                        Button("Submit",action:{
                            viewModel.createBand()
                        })
                    }
                    
                }
            }
        }
    }
        struct AddBandView_Previews: PreviewProvider {
            static var previews: some View {
                AddBandView()
            }
        }
    }

struct ArtistRowItem: View {
    var body: some View {
        Spacer()
        HStack{
            
            Image("user")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 50,height: 50)
            VStack{
                Text("Jean Paul")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                
            }
            Spacer()
            Button ("ADD",action:{
                
            }
            )
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .buttonStyle(.bordered)
            
            
            
        }.padding(.all)
        
        
    }
}
