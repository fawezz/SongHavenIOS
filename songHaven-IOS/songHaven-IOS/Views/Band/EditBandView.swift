//
//  EditBandView.swift
//  songHaven-IOS
//
//  Created by SongH on 10/12/2022.
//

import SwiftUI
import NavigationStack
import PhotosUI
struct EditBandView: View {
        @StateObject var viewModel  = EditBandViewModel()
    @StateObject private var languageService = LocalizationService.shared
        @EnvironmentObject private var navigationStack: NavigationStackCompat
        var body: some View {
            NavigationStack{
                ZStack{
                    LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing:20) {
                        
                        Text(" txtEdit ".localized(languageService.language))
                            .foregroundColor(.white)
                            .font(.title2)
//                        ZStack(alignment: .bottomTrailing){
//
//                            Image(uiImage: viewModel.image)
//                                .resizable()
//                                .frame( width: 200,height: 200)
//                                .aspectRatio(contentMode: .fill)
//                                .clipShape(Circle())
//                                .onTapGesture {
//                                    viewModel.isUploading = true
//
//                                }
//
//                                .sheet(isPresented: $viewModel.isUploading){
//                                    ImagePicker(sourceType : .photoLibrary,
//                                                selectedImage: $viewModel.image)
//                                }
//
//                        }
                        
                        TextField("editTxt1".localized(languageService.language),text:$viewModel.name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .autocorrectionDisabled(true)
                        TextField("editTxt2".localized(languageService.language),text:$viewModel.discription)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .autocorrectionDisabled(true)
                        PushView(destination: UserBandsView(), tag: "addBand", selection: $viewModel.navigator) {}

                            Button(action:{
                                viewModel.EditDetails()
                            })
                        {
                            Text("SaveTxt".localized(languageService.language))
                                .font(.headline)
                                .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(.green )
                            .cornerRadius(15.0)
                        }
//                                    .background(!viewModel.validateFields() ? .green : .gray)
//                                    .cornerRadius(15.0)
//                            }.disabled(viewModel.validateFields())

                    }.padding(.all)
                } .navigationBarItems(leading: BackButton(action: {navigationStack.push(UserBandsView())}))
                    if (viewModel.isLoading){
                        ZStack{
                            Color(.white)
                            ProgressView()
                        }
                    }
                }
              }
        }
struct EditBandView_Previews: PreviewProvider {
    static var previews: some View {
        EditBandView()
    }
}
