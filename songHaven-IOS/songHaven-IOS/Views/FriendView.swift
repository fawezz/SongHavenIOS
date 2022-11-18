//
//  FriendView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct FriendView: View {
    @State private var name = ""
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("Friend & Groups")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                TextField("Search",text:$name)
                    .padding()
                    .frame(width: 300, height :50)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(10)

                Spacer()
                
                HStack{
                    Text("REQUESTS")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.clear)
                        .cornerRadius(15.0)
                    Text("REQUESTS")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.clear)
                        .cornerRadius(15.0)
                    Text("REQUESTS")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.clear)
                        .cornerRadius(15.0)
                    
                    
                }
                
                
            }
            
        }
    }
    
    struct FriendView_Previews: PreviewProvider {
        static var previews: some View {
            FriendView()
        }
    }
}


struct OutlinedTextFieldStyle: TextFieldStyle {
    
    @State var icon: Image?
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .foregroundColor(Color(UIColor.systemGray4))
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
        
        }
        .padding(.all)
    }
}

