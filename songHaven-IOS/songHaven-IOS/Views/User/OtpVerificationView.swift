//
//  Verification.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI
import AlertToast
import NavigationStack

struct OtpVerificationView: View {
    @StateObject var viewModel = OtpVerificationViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat

    @State var isFocused = false
    
    let textBoxWidth = UIScreen.main.bounds.width / 10
    let textBoxHeight = UIScreen.main.bounds.width / 7
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*5)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top) ){
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(spacing:30){
                    Image("forgotPass2")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(40)
                    
                    Text("Confirmation code")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    Text("Please enter the 5 digit code sent to your email:")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    ZStack(alignment: .center){
                        HStack(spacing: 40){
                            otpText(text: viewModel.otp1)
                            otpText(text: viewModel.otp2)
                            otpText(text: viewModel.otp3)
                            otpText(text: viewModel.otp4)
                            otpText(text: viewModel.otp5)
                        }.padding(.vertical, 40)
                        
                        TextField("", text: $viewModel.otpField)
                            .frame(width: isFocused ? 0 : textFieldOriginalWidth*1.5, height: textBoxHeight)
                            .disabled(viewModel.isTextFieldDisabled)
                            .textContentType(.oneTimeCode)
                            .foregroundColor(.clear)
                            .accentColor(.clear)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                    }
                    VStack(){
                        HStack(){
                            Text("Did not receive a code?")
                                .font(.caption)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Button(action: {
                                viewModel.ResendCode()
                            }) {
                                Text("Resend")
                                    .font(.headline)
                                    .foregroundColor(.purple)
                                    .frame(height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                                    .underline()
                            }
                        }
                        Button(){
                            viewModel.VerifyOtp()
                        }label:{
                            Text("verify")
                                .padding(.horizontal, 120)
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(buttonColor)
                        .cornerRadius(10)
                        .disabled(viewModel.otpField.count < 5)
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(
                                title: Text("Access Denied"),
                                message: Text("The code entered does not match, Please Try Again.")
                            )
                        }
                    }
                    
                }
                PushView(destination: ResetPasswordView(), tag: "ResetPassword", selection: $viewModel.navigator) {}
                //Loader
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
            .navigationBarItems(
                leading: BackButton(action: {navigationStack.pop(to: .previous)})
                )
            .toast(isPresenting: $viewModel.showToast){
                AlertToast(displayMode: .banner(.slide), type: .complete(.green), title: "Email Sent")
            }
        }
    }
    
    var buttonColor: Color{
        if(viewModel.otpField.count < 5){
            return Color.gray
        }else{
            return Color.green
        }
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        OtpVerificationView()
    }
}

private func otpText(text: String) -> some View {
    
    return ZStack{
        if(text.isEmpty){
            Circle()
                .scale(2)
                .foregroundColor(.white.opacity(0.15))
                .frame(width: 30, height: 30)
        }
        else{
            Text(text)
                .background(
                    Circle()
                        .scale(2)
                        .foregroundColor(.purple.opacity(0.45))
                        .frame(width: 25, height: 25)
                )
                .frame(width: 35, height: 35)
                .fixedSize(horizontal: true, vertical: false)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .fontWeight(Font.Weight.bold)
                .font( .largeTitle)
        }
    }
}


