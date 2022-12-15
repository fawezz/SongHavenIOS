//
//  AddBandViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 25/11/2022.
//

import SwiftUI
import _PhotosUI_SwiftUI
@MainActor class AddBandViewModel: ObservableObject {
    @Published var name = ""
    @Published var discription = ""
    @Published var isUploading: Bool = false
    @Published var isLoading: Bool = false
    @Published var selectedImageData: Data? = nil
    @Published var navigator : String? = nil
    @Published var bandImageUrl: URL = URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    @Published var uplodedImg : UIImage = UIImage()
    @Published var toastMessage = ""
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var toastText: String = ""
    
    ///image methode 2
    @Published var image : UIImage = UIImage.init(named: "empty") ?? UIImage()
    
    

    
    func addBand (){
        BandService.add(band: Band(name: name, discription: discription),image: image, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                self.toastText = "Band created successfully"
                self.showSuccessToast = true
                print("success")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.navigator = "addBand"
                    print("Band created successfully")
                    self.showSuccessToast = false
                }
            } else {
                self.toastText = "add failed"
                self.showFailToast = true
                print("failure")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
            }
        })
    }
//            passed , statusCode in
//            if(passed){
//                self.navigator = "addBand"
//            }
        
        
    
    func validateFields()-> Bool{
        return (name.isEmpty || discription.isEmpty)
    }
    
}




//    func AddImage(){
//        self.isUploading = true
//        BandService.uploadImage(name: UserDefaults.standard.string(forKey: "name") ?? "name", image: UIImage(data: selectedImageData!), completed: { (success, reponse) in
//
//            self.isUploading = false
//            if success {
//                print("success add image")
//                self.bandImageUrl = URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
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
//
//
//    }
