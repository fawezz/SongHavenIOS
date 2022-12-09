//
//  SuggetionModelView.swift
//  songHaven-IOS
//
//  Created by SongH on 6/12/2022.
//

import Foundation
@MainActor class ArtistSuggetionViewModel: ObservableObject {
    @Published var navigator : String? = nil
    @Published var users = [User]()
    @Published var searchText : String = ""
    
    init() {
          fetchUsers()
         }
    
    private func fetchUsers() {
        UserService.GetAllusers( completed: { (success, usersArray) in
                if(success){
                    self.users = usersArray ?? []
                    print("eeeeeeeee" + self.users.description)
                }
            })
        }
}
