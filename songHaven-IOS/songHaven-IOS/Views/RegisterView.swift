//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI

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
                    TextField("Enter your name",text:$viewModel.name)
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
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                }.padding()
            }
            .navigationBarHidden(true)
        }.accentColor(.white)
    }
    
    struct Register_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                RegisterView()
            }
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
    }
}
