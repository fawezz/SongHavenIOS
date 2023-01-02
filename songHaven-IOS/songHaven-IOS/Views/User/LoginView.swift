//
//  LoginView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 11/11/2022.
//
import SwiftUI
import AlertToast
import NavigationStack
import GoogleSignIn
struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @StateObject private var languageService = LocalizationService.shared
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack() {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 50)
                    
                    Text("loginTxt1".localized(languageService.language))
                        .foregroundColor(Color.white)
                        .fontWeight(Font.Weight.bold)
                        .font(.title3)
                        .padding(.bottom, 50)
                    
                    VStack( spacing: 15) {
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .autocorrectionDisabled(true)
                        if(!viewModel.hiddenPass){
                            ZStack(alignment: .trailing){
                                SecureField("loginTxt3".localized(languageService.language), text: $viewModel.password)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
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
                                TextField("loginTxt3".localized(languageService.language), text: $viewModel.password)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(20.0)
                                    .foregroundColor(.black)
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
                            Text("loginTxt2".localized(languageService.language))
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
                            Text("loginTxt4".localized(languageService.language))
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(buttonColor)
                                .cornerRadius(15.0)
                        }
                        .disabled(!viewModel.validateFields())
                        .alert(isPresented: $viewModel.showAlert) {
                                Alert(
                                    title: Text("alertTitle".localized(languageService.language)),
                                    message: Text("alertMessage".localized(languageService.language) + UserDefaults.standard.string(forKey: "email")! + " ?"),
                                    primaryButton: .default(
                                        Text("sendEmail".localized(languageService.language)),
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
                            Text("loginTxt5".localized(languageService.language))
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        }
                        HStack(){
                            Image("google")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(40)
                                .padding(.vertical, 10)
                            Button(action: {
                                viewModel.GoogleAuth()
                            }) {
                                Text("google".localized(languageService.language))
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            }
                        }
                        //FBLoginButtonView()
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
                PushView(destination: ProfileView().navigationBarBackButtonHidden(true), tag: "Profile", selection: $viewModel.navigator) {}
                PushView(destination: SendOtpView(), tag: "ForgotPass", selection: $viewModel.navigator) {}
                PushView(destination: RegisterView(), tag: "SignUp", selection: $viewModel.navigator) {}
                PushView(destination: HomeView(), tag: "HomeView", selection: $viewModel.navigator) {}
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
