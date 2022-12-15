//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//
import SwiftUI
import PhotosUI
import AlertToast
import NavigationStack


struct EditProfileView: View {
    
    @StateObject var viewModel = EditProfileViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat

    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(spacing:20) {
                    ZStack(alignment: .bottomTrailing){
                        
                        AsyncImage(url:viewModel.profileImageUrl)
                        {
                            Image in Image
                                .resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .frame(width: 180,height: 180)
                        
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
                                        viewModel.selectedImageData = data
                                        print("Submitted image")
                                        viewModel.editImage()
                                    }
                                }
                            })
                        if(viewModel.isUploading){
                            ZStack{
                                Color(.white)
                                    .opacity(0.7)
                                    .cornerRadius(50)
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                                    .scaleEffect(3)
                                
                            }.frame(width: 200, height: 200)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 40)
                    
                    TextField("Enter your name",text:$viewModel.firstname)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    TextField("Enter your lastname",text:$viewModel.lastname)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    SecureField("Password",text:$viewModel.password)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    SecureField("Confirm your password",text:$viewModel.confirmPassword)
                        .textFieldStyle(ProfileTextFieldStyle())
                    Button (
                        action: {
                            viewModel.EditDetails(action: {navigationStack.pop()}())
                        },
                        label: {
                            Label("Edit", systemImage: "square.and.pencil")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(buttonColor)
                                .cornerRadius(15.0)
                        })
                    .padding(.vertical, 40)
                    .disabled(!viewModel.validateFields())
                }
                .padding(.all)
                
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
                PushView(destination: ProfileView(), tag: "Profile", selection: $viewModel.navigator) {}
            }
            .navigationBarItems(
                leading: BackButton(action: {navigationStack.pop(to: .previous)})
                )
            .toast(isPresenting: $viewModel.showSuccessToast){
                AlertToast(type: .complete(.green), title: viewModel.toastMessage)
            }
            .toast(isPresenting: $viewModel.showFailToast){
                AlertToast(type: .error(.red), title: viewModel.toastMessage)
            }
        }
    }
    
    var buttonColor: Color{
        if(viewModel.validateFields()){
            return Color.green
        }else{
            return Color.gray
        }
    }
    
    
    struct Register_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                EditProfileView()
            }
        }
    }
}

struct ProfileTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .autocorrectionDisabled(true)
        
    }
}
