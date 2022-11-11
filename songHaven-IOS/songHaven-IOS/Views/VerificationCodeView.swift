//
//  Verification.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct VerificationCodeView: View {
    @StateObject var viewModel = VerificationViewModel()
          @State var isFocused = false
          
          let textBoxWidth = UIScreen.main.bounds.width / 10
          let textBoxHeight = UIScreen.main.bounds.width / 7
          let spaceBetweenBoxes: CGFloat = 10
          let paddingOfBox: CGFloat = 1
          var textFieldOriginalWidth: CGFloat {
              (textBoxWidth*5)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
          }
    
    var body: some View {
        NavigationView{
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top) ){
                LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(spacing:30){
                    Text("Confirmation code")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.vertical, 70)
                    
                    Text("Please enter the code sent to your email:")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    
                    ZStack{
                        HStack(spacing: 40){
                            otpText(text: viewModel.otp1)
                            otpText(text: viewModel.otp2)
                            otpText(text: viewModel.otp3)
                            otpText(text: viewModel.otp4)
                            otpText(text: viewModel.otp5)
                        }.padding(.vertical, 40)
                        
                        TextField("", text: $viewModel.otpField)
                                              .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                                              .disabled(viewModel.isTextFieldDisabled)
                                              .textContentType(.oneTimeCode)
                                              .foregroundColor(.white)
                                              .accentColor(.clear)
                                              .background(Color.clear)
                                              .keyboardType(.numberPad)
                    }
                    
                    Button("Verify"){
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.pink)
                    .cornerRadius(10)
                    
                    
                    NavigationLink (destination :Text(" You are logged in")){
                        EmptyView()
                    }
                    
                }
                
            }
            NavigationLink (destination :Text(" You are logged in)")){
                EmptyView()
            }
        }
        
    }
    
    struct Verification_Previews: PreviewProvider {
        static var previews: some View {
            VerificationCodeView()
        }
    }
    
    private func otpText(text: String) -> some View {
        
        return ZStack{
            /*Circle().background(Circle().fill(.blue))
                .frame(width: textBoxWidth+20, height: textBoxWidth+20)*/
            Text(text)
                .background(
                    Circle().scale(2).foregroundColor(.white.opacity(0.15))
                )
                .frame(width: 35, height: 35, alignment: .center)
                .fixedSize(horizontal: true, vertical: false)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .fontWeight(Font.Weight.bold)
                .font( .largeTitle)
        }
    }
    /*
    struct CodeField: View {
        @State var digit: String
        
        var body: some View {
            TextField("", text: digit)
                .background(
                    Circle().scale(2).foregroundColor(.white.opacity(0.15))
                )
                .frame(width: 35, height: 35, alignment: .center)
                .fixedSize(horizontal: true, vertical: false)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .fontWeight(Font.Weight.bold)
                .font( .largeTitle)
        }
    }*/
}

extension VerificationCodeView{
    @MainActor class VerificationViewModel: ObservableObject {
        
        @Published var otpField = "" {
            didSet {
                guard otpField.count <= 5,
                      otpField.last?.isNumber ?? true else {
                    otpField = oldValue
                    return
                }
            }
        }
        var otp1: String {
            guard otpField.count >= 1 else {
                return ""
            }
            return String(Array(otpField)[0])
        }
        var otp2: String {
            guard otpField.count >= 2 else {
                return ""
            }
            return String(Array(otpField)[1])
        }
        var otp3: String {
            guard otpField.count >= 3 else {
                return ""
            }
            return String(Array(otpField)[2])
        }
        var otp4: String {
            guard otpField.count >= 4 else {
                return ""
            }
            return String(Array(otpField)[3])
        }
        
        var otp5: String {
            guard otpField.count >= 5 else {
                return ""
            }
            return String(Array(otpField)[4])
        }
        
        
        
        @Published var borderColor: Color = .black
        @Published var isTextFieldDisabled = false
        @Published var successCompletionHandler: (()->())?
        
        @Published var showResendText = false
        
    }
}
