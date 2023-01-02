//
//  AddBandView.swift
//  songHaven-IOS
//
//  Created by SongH on 25/11/2022.
//

import SwiftUI
import PhotosUI
import AlertToast
import NavigationStack
struct AddBandView: View {
    @StateObject var viewModel  = AddBandViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject private var languageService = LocalizationService.shared
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(spacing:20) {
                    
                    Text("bandTxt0".localized(languageService.language))
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
                    
                    TextField("bandTxt1".localized(languageService.language),text:$viewModel.name)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                    TextField("bandTxt2".localized(languageService.language),text:$viewModel.discription)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        .autocorrectionDisabled(true)
                        .foregroundColor(.black)
                    
                    PushView(destination: UserBandsView(), tag: "userBands", selection: $viewModel.navigator) {}
                    
                    Button(action:{
                        viewModel.addBand()
                    })
                    {
                        Text("bandTxt3".localized(languageService.language))
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


struct addTestView_Previews: PreviewProvider {
    static var previews: some View {
        AddBandView()
    }
}
