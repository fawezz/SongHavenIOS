//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//
import SwiftUI
import PhotosUI


struct EditProfileView: View {
    @State private var name = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State  private var ShowingLoginscrean = false
    @State var isPresented = false
    @State var selectedItems: [PhotosPickerItem] = []
    
    
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
                            selection: $selectedItems,
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
                    
                    TextField("Enter your name",text:$name)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    TextField("Enter your lastname",text:$lastname)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    
                    TextField("Enter your Email",text:$email)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    SecureField("Password",text:$password)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    SecureField("Confirm your password",text:$confirmPassword)
                        .textFieldStyle(ProfileTextFieldStyle())
                    
                    
                    
                    Button (
                        action: { self.isPresented = true },
                        label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        })
                    .padding(.vertical, 40)
                }
                .padding(.all)
            }
            .navigationBarHidden(true)
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
        
    }
}
