//
//  AddBandView.swift
//  songHaven-IOS
//
//  Created by SongH on 25/11/2022.
//

import SwiftUI
import PhotosUI

struct addTestView: View {
    
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
                        
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .frame( width: 200,height: 200)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .onTapGesture {
                                viewModel.isUploading = true
                                
                            }
                        
                            .sheet(isPresented: $viewModel.isUploading){
                                ImagePicker(sourceType : .photoLibrary,
                                            selectedImage: $viewModel.image)
                            }
                        
                    }
                    
                    
                    
                    
                    
                    
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
                    
                    
                    
                    NavigationLink(destination: TestView()){
                        Button(action:{
                            viewModel.addBand()
                     
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
                    
                    
                    
                }.padding(.all)
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

struct addTestView_Previews: PreviewProvider {
    static var previews: some View {
        addTestView()
    }
}
