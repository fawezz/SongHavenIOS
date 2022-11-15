//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//
import SwiftUI
import PhotosUI
import AlertToast


struct EditProfileView: View {
    
    @StateObject var viewModel = EditProfileViewModel()

        
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(spacing:20) {
                    ZStack(alignment: .bottomTrailing){
                        Image("userIcon")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFit()
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .frame(width: 150,height: 150)
                        PhotosPicker(
                            selection: $viewModel.selectedItems,
                            matching: .images,
                            photoLibrary: .shared()
                        )
                        {
                            Image(systemName: "camera")
                                .frame(width: 40, height: 40)
                                .background(Color(.white))
                                .cornerRadius(50)
                                .padding(.trailing, 3)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 40)
                    
                    TextField("Enter your name",text:$viewModel.firstname)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    TextField("Enter your lastname",text:$viewModel.lastname)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    /*TextField("Enter your Email",text:$viewModel.email)
                        .textFieldStyle(ProfileTextFieldStyle())*/
                    
                    SecureField("Password",text:$viewModel.password)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    SecureField("Confirm your password",text:$viewModel.confirmPassword)
                        .textFieldStyle(ProfileTextFieldStyle())
                    Button (
                        action: {
                            viewModel.EditDetails()
                        },
                        label: {
                            Label("Edit", systemImage: "square.and.pencil")
                                .foregroundColor(buttonColor)
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
                NavigationLink(destination: ProfileView(), tag: "Profile", selection: $viewModel.navigator) {}
            }
            .navigationBarHidden(true)
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
