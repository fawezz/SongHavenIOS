//
//  SendOtpView.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI
import AlertToast
import NavigationStack

struct SendOtpView: View {
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject var viewModel = SendOtpViewModel()
    private var language = LocalizationService.shared.language

    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(){
                    Image("forgotPass1")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(40)
                    Text("ForgotPassTxt1".localized(language))
                        .foregroundColor(.white)
                        .bold()
                        .font(.title)
                        .padding(.vertical, 30)
                    Text("ForgotPassTxt2")
                        .foregroundColor(.white)
                        .bold()
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .padding(50)
                        .autocorrectionDisabled(true)
                    
                    Button(action: {
                        viewModel.sendOtp()
                        viewModel.navigator = "OtpVerification"
                    }) {
                        Text("ForgotPassTxt4".localized(language))
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(buttonColor)
                            .background(buttonColor)
                            .cornerRadius(15.0)
                    }.disabled(!viewModel.validateFields())
                    
                    PushView(destination: OtpVerificationView(), tag: "OtpVerification", selection: $viewModel.navigator) {}

                }
                .toast(isPresenting: $viewModel.showSuccessToast){
                    AlertToast(type: .complete(.green), title: viewModel.toastMessage)
                }
                .toast(isPresenting: $viewModel.showFailToast){
                    AlertToast(type: .error(.red), title: viewModel.toastMessage)
                }
                
            }
            .navigationBarItems(
                leading: BackButton(action: {
                    navigationStack.pop(to: .root)})
                )
        }
        
    }
        
    var buttonColor: Color{
        if(!viewModel.validateFields()){
            return Color.gray
        }else{
            return Color.green
        }
    }
}

struct SendOtpView_Previews: PreviewProvider {
    static var previews: some View {
        SendOtpView()
    }
}



