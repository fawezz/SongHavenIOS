//
//  AddBandView.swift
//  songHaven-IOS
//
//  Created by SongH on 25/11/2022.
//

import SwiftUI
import PhotosUI

struct AddBandView: View {
    
    @State private var name = ""
    @State private var discription = ""
    @StateObject var viewModel  = AddBandViewModel()
    @State private var   shouldChange = false
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(spacing:20) {
                 
                        Text(" Do you want to create Your Band? ")
                            .foregroundColor(.white)
                            .font(.title2)
                    ZStack(alignment: .bottomTrailing){
                                                        
                        Image(uiImage: viewModel.uplodedImg)
                            .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .frame(width: 130,height: 130)
                                                        
                                PhotosPicker(
                                                        selection: $viewModel.selectedItem,
                                                        matching: .images,
                                                        photoLibrary: .shared()){
                                                        Image(systemName: "camera")
                                                        .frame(width: 40, height: 40)
                                                        .background(Color(.white))
                                                        .cornerRadius(50)
                                                        .padding(.trailing, 3)
                                                        .foregroundColor(.black)
                                                        }
                                                        .onChange(of: viewModel.selectedItem,
                                                        perform: {
                                                        newItem in
                                                        Task {
                                                        if let data = try? await newItem?.loadTransferable(type: Data.self){
                                                        viewModel.selectedImageData = data//ll
                                                            viewModel.uplodedImg = UIImage(data: data) ?? UIImage()
                                                        print("Submitted image")
                                                        viewModel.AddImage()
                                                        }
                                                        }
                                                        })
                                                        }
                                                        
                                                        .frame(width: 100, height: 100)
                                                        .padding(.bottom, 40)
                                                     
                        
                  
                        
                    
                        
                        
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
                    
                    Button(action: {
                        
                    }) {
        
                        NavigationLink(destination: TestView()) {
                            Button(action:{
                                viewModel.createBand()
                            })
                            {
                                Text("Validate")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(.green)
                                    .cornerRadius(15.0)
                            }

                        }
                    }
                        
                        
                }.padding(.all)
                }
            }}
    }
        struct AddBandView_Previews: PreviewProvider {
            static var previews: some View {
                AddBandView()
            }
        }

