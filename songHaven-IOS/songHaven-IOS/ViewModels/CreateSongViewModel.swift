//
//  CreateSongViewModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 29/11/2022.
//
//
//import Foundation
//import UIKit
//@MainActor class CreateSongViewModel: ObservableObject {
//
//    @Published let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.mp3])
//
//    @Published var navigator: String? = nil
//    @Published var isLoading: Bool = false
//    @Published var isUploading: Bool = false
//
//    @Published var showSuccessToast : Bool = false
//    @Published var showFailToast : Bool = false
//    @Published var toastMessage = ""
//
//    init(){
//        documentPicker.delegate = self
//        documentPicker.modalPresentationStyle = .overFullScreen
//    }
//
//    func EditDetails(){
//        isLoading = true
//        UserService.EditDetails(id: UserDefaults.standard.string(forKey: "userId")!, firstname: firstname, lastname: lastname, password: password, completed: { (success, reponse) in
//
//            self.isLoading = false
//            if success {
//                print("success")
//                let currentUser = reponse as! User
//                self.toastMessage = "Success"
//                self.showSuccessToast = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
//                    self.navigator = "Profile"
//                    self.showSuccessToast = false
//                }
//            }
//            else {
//                self.toastMessage = reponse as! String
//                self.showFailToast = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
//                    self.showFailToast = false
//                }
//                print("fail")
//            }
//        })
//    }
//
//    func editImage(){
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
//    }
//
//    func validateFields()-> Bool{
//        //return true
//        return (self.isLettersOnly(strToValidate: self.firstname) && self.isLettersOnly(strToValidate: self.lastname) && self.password.count >= 8 || self.password.count == 0 && self.password == self.confirmPassword )
//    }
//
//    func isEmail(strToValidate : String)-> Bool{
//        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})+$"  // 1
//
//        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
//
//        return emailValidationPredicate.evaluate(with: strToValidate)  // 3
//    }
//
//    func isLettersOnly(strToValidate : String)-> Bool{
//        let emailValidationRegex = #"^([\p{L},.'’-]+(\s|$))+"#  // 1
//
//        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
//
//        return emailValidationPredicate.evaluate(with: strToValidate)  // 3
//    }
//
//
//}
