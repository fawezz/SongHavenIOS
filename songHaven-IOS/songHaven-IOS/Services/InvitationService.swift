//
//  InvitationService.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//
import Alamofire
import SwiftyJSON
import Foundation
import UIKit

class InvitationService{

    static let SendInvitationURL = Constants.HOSTNAME + "/invitation/SendInvitation"
    static let AcceptInvitationURL = Constants.HOSTNAME + "/invitation/accepteInvitation/"
    static let RejectInvitation = Constants.HOSTNAME + "/invitation/declineInvitation/"
    static let getByRecepient = Constants.HOSTNAME + "/invitation/getByUser/"


    static func SendInvitation(userId: String, bandId: String, completed: @escaping (Bool, Any?) ->Void){

        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "userId": userId,
            "bandId": bandId
        ]
        AF.request(SendInvitationURL, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                let jsonData = JSON(response.data!)
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print( message)
                        completed(false, message)
                    }else{
                        print("Error" + error.errorDescription!)
                    }

                }
            }
 }
    static func getByUser(completed: @escaping (Bool, [Invitation]?) -> Void){
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        AF.request(getByRecepient + userId,  method: .get )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var invitations : [Invitation]? = []
                    for singleJsonItem in jsonData["invitation"] {
                        invitations!.append(Invitation.fromJson(jsonData: singleJsonItem.1))
                    }

                    completed(true, invitations)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)

                }
            }
    }

    static func acceptInvitation(userId: String, bandId: String, completed: @escaping (Bool,Invitation?) -> Void){

        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "userId" : userId,
            "bandId" : bandId
        ]

        AF.request(AcceptInvitationURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let invitation = Invitation.fromJson(jsonData: jsonData["invitation"])

                    completed(true, invitation)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)


                }
            }
    }

    static func declineInvitation(userId: String, bandId: String, completed: @escaping (Bool,Invitation?) -> Void){

        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "userId" : userId,
            "bandId" : bandId
        ]

        AF.request(RejectInvitation,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let invitation = Invitation.fromJson(jsonData: jsonData["invitation"])

                    completed(true, invitation)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)


                }
            }
    }


}
