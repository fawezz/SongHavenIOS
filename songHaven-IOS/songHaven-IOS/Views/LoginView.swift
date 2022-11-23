//
//  LoginView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 11/11/2022.
//
import SwiftUI
import AlertToast

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack() {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 50)
                    
                    Text("Welcome To SongHaven")
                        .foregroundColor(Color.white)
                        .fontWeight(Font.Weight.bold)
                        .font(.title3)
                        .padding(.bottom, 50)
                    
                    VStack( spacing: 15) {
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .autocorrectionDisabled(true)
                        if(!viewModel.hiddenPass){
                            ZStack(alignment: .trailing){
                                SecureField("Password", text: $viewModel.password)
                                    .padding()
                                    .background(Color.white)
                                .cornerRadius(20.0)
                                Button (
                                    action: {
                                        viewModel.hiddenPass.toggle()
                                    },
                                    label: {
                                        Image(systemName: "eye.fill").foregroundColor(.black)
                                    }
                                ).padding(.trailing, 8)
                            }
                        }else{
                            ZStack(alignment: .trailing){
                                TextField("Password", text: $viewModel.password)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(20.0)
                                Button (
                                    action: {
                                        viewModel.hiddenPass.toggle()
                                    },
                                    label: {
                                        Image(systemName: "eye.slash.fill").foregroundColor(.black)
                                    }
                                ).padding(.trailing, 8)
                            }
                            
                        }
                        
                    }.padding([.leading, .trailing], 27.5)
                    HStack{
                        Spacer()
                        Button(action: {
                            viewModel.navigator = "ForgotPass"
                        }) {
                            Text("Forgot Password?")
                                .font(.headline)
                                .foregroundColor(.purple)
                                .frame(height: 50)
                                .background(Color.clear)
                                .cornerRadius(15.0)
                                
                        }
                    }.padding([.trailing, .bottom ])
                    
                    VStack(spacing: 15){
                        Button(action: {
                            viewModel.Login()
                            //self.selection = "home"
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(buttonColor)
                                .cornerRadius(15.0)
                        }
                        .disabled(!viewModel.validateFields())
                        .alert(isPresented: $viewModel.showAlert) {
                                Alert(
                                    title: Text("Account not Verified"),
                                    message: Text("This email is not confirmed, would you like to resend the confirmation email to " + UserDefaults.standard.string(forKey: "email")! + " ?"),
                                    primaryButton: .default(
                                        Text("Send Email"),
                                        action: {
                                            viewModel.ResendWelcomeMail()
                                        }
                                    ), secondaryButton: .cancel()
                                )
                            }
                        Color(.white).opacity(0.5)
                            .frame(width: 100, height: 3)
                            .clipShape(Capsule())
                        
                        Button(action: {
                            viewModel.navigator = "SignUp"
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        }
                    }
                }
                //LOADER
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
                NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true), tag: "Profile", selection: $viewModel.navigator) {}
                    
                NavigationLink(destination: SendOtpView(), tag: "ForgotPass", selection: $viewModel.navigator) {}
                NavigationLink(destination: RegisterView(), tag: "SignUp", selection: $viewModel.navigator) {}
                NavigationLink(destination: BandsView().navigationBarBackButtonHidden(true), tag: "Bands", selection: $viewModel.navigator) {}
                    
            }
            .toast(isPresenting: $viewModel.showSuccessToast){
                AlertToast(type: .complete(.green), title: viewModel.toastMessage)
            }
            .toast(isPresenting: $viewModel.showFailToast){
                AlertToast(type: .error(.red), title: viewModel.toastMessage)
            }
        }.accentColor(.white)
        .navigationBarHidden(true)
    }
    var buttonColor: Color{
        if(viewModel.validateFields()){
            return Color.green
        }else{
            return Color.gray
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
