//
//  ConversationService.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 15/12/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
class ConversationService{
    static let getConversationByBandIdURL = Constants.HOSTNAME + "/chat/getByBand/"
    static let deleteMessageURL = Constants.HOSTNAME + "/chat/removeMessage/"
    
    static func GetConversationByBandId(bandId: String, completed: @escaping (Bool, Conversation?) -> Void){
        AF.request(getConversationByBandIdURL + bandId,  method: .get ) //"63749eac6781be3df2521807"
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let conv = jsonData["conversation"]
                    let conversation : Conversation = Conversation.fromJson(jsonData: conv)
                    print("total messages" + conversation.messages.count.description)
                    completed(true, conversation)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                    debugPrint(error)
                }
            }
    }
    static func DeleteMessage(textMessageId: String, completed: @escaping (Bool, String?) -> Void){
        AF.request(deleteMessageURL + textMessageId,  method: .delete )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message : String = jsonData["message"].string!
                    let textMessageId : String = jsonData["textMessageId"].string!
                    print(message)
                    completed(true, textMessageId)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                    debugPrint(error)
                }
            }
    }
}


