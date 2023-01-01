//
//  CreateSongViewModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 29/11/2022.


import Foundation
import UIKit
@MainActor class CreateSongViewModel: ObservableObject {

    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    @Published var isUploading: Bool = false

    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    @Published var title = ""
    @Published var genre = ""
    @Published var fileURL : URL?


    init(){
     
    }

    func publishSong(){
        self.isUploading = true
        SongService.createSong(title: self.title, genre: self.genre, songfileURL: self.fileURL!, completed: { (success, reponse) in
            self.isUploading = false
            print(success.description)
        })
    }

    func editImage(){
//        self.isUploading = true
//        UserService.uploadImage(email: UserDefaults.standard.string(forKey: "email")!, image: UIImage(data: selectedImageData!), completed: { (success, reponse) in
//
//            self.isUploading = false
//            if success {
//                print("success edit image")
//                self.profileImageUrl = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
//                self.toastMessage = reponse
//                self.showSuccessToast = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                    self.showSuccessToast = false
//                }
//            }
//            else {
//                self.toastMessage = reponse
//                self.showFailToast = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                    self.showFailToast = false
//                }
//                print("fail edit")
//            }
//        })
    }

    func validateFields()-> Bool{
//        //return true
        return (self.isLettersOnly(strToValidate: self.genre)
                && self.title.count > 0
                && self.fileURL != nil
        )
    }

    func isLettersOnly(strToValidate : String)-> Bool{
        let emailValidationRegex = #"^([\p{L},.'’-]+(\s|$))+"#  // 1

        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2

        return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }


}


