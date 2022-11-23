//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI
import AlertToast

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20){
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    Text("Join Us Now")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    TextField("Enter your name",text:$viewModel.firstname)
                        .textFieldStyle(RegisterTextFieldStyle())
                    
                    TextField("Enter your lastname",text:$viewModel.lastname)
                        .textFieldStyle(RegisterTextFieldStyle())
                    
                    TextField("Enter your Email",text:$viewModel.email)
                        .textFieldStyle(RegisterTextFieldStyle())
                    
                    SecureField("Password",text:$viewModel.password)
                        .textFieldStyle(RegisterTextFieldStyle())
                    
                    SecureField("Confirm your password",text:$viewModel.confirmPassword)
                        .textFieldStyle(RegisterTextFieldStyle())
                    
                    Button("Submit"){
                        viewModel.register()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .disabled(!viewModel.validateFields())
                    
                }.padding()
                
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
                NavigationLink(destination: LoginView(), tag: "Login", selection: $viewModel.navigator) {}
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $viewModel.showFailToast){
                AlertToast(type: .error(.red), title: viewModel.toastText)
            }
            .toast(isPresenting: $viewModel.showSuccessToast){
                AlertToast(type: .complete(.green), title: viewModel.toastText)
            }
            
        }.accentColor(.white)
    }
    
    struct Register_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                RegisterView()
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
}


struct RegisterTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 20)
            .frame(height: 50)
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .foregroundColor(.black)
            .padding([.leading, .bottom, .trailing])
            .autocorrectionDisabled(true)
    }
}
