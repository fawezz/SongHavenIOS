//
//  Verification.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct VerificationCodeView: View {
    
    @State private var code1 = ""
    @State private var code2 = ""
    @State private var code3 = ""
    @State private var code4 = ""
    @State private var code5 = ""
    
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
                    
                    
                    
                    HStack(spacing: 40){
                        CodeField(digit: $code1)
                        
                        CodeField(digit: $code2)
                        
                        CodeField(digit: $code3)
                        
                        CodeField(digit: $code4)
                        
                        CodeField(digit: $code5)
                    }.padding(.vertical, 40)
                    
                    NavigationLink(destination: ResetPasswordView()){
                         
                        Button("Send",action:{
                            print("yo")
                 
                        }
                        
                        )
                         .foregroundColor(.white)
                         .frame(width: 300, height: 50)
                         .background(Color.green)
                         .cornerRadius(10)
                     }
                 
                    
                    
                    }
                    
                }
                
            }
        
        }
    }
    
    struct Verification_Previews: PreviewProvider {
        static var previews: some View {
            VerificationCodeView()
        }
    }
    
    struct CodeField: View {
        @State var digit: Binding<String>
        
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
    }

