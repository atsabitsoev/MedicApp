//
//  AdvicesService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 23/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AdvicesService {
    
    static let standard = AdvicesService()
    private init() {}
    
    
    var advices: [Advice] = []
    var getAdvicesError: String?
    
    
    func getAdvicesRequest() {
        
        let url = "\(ApiInfo().baseUrl)/advice?skip=\(advices.count)&limit=10"
        let headers: HTTPHeaders = ["Cookie": "token=\(TokenService.standard.token!); id=\(TokenService.standard.id!)"]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: nil)
            .responseJSON { (response) in
                
                do {
                    
                    let result = try response.result.get()
                    let json = JSON(result)
                    print(json)
                    
                    switch response.response?.statusCode {
                    case 200:
                        
                        let advicesJSON = json["data"]["advices"].arrayValue
                        let advices = self.parseAdvices(json: advicesJSON)
                        self.advices = advices
                        self.getAdvicesError = nil
                        
                    default:
                        
                        let errorString = json["data"]["error"].stringValue
                        self.getAdvicesError = errorString
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    self.getAdvicesError = errorString
                    print(errorString)
                    
                }
                
                NotificationManager.post(.getAdvicesRequestAnswered)
        }
    }
    
    
    private func parseAdvices(json: [JSON]) -> [Advice] {
        
        let advices = json.map { (adviceJSON) -> Advice in
            
            let name = adviceJSON["name"].stringValue
            
            let text = adviceJSON["text"].stringValue
            
            let imageUrlStrings = adviceJSON["images"].arrayValue.map({ (urlJSON) -> String in
                return  "\(ApiInfo().baseUrl)\(urlJSON.stringValue)"
            })
            let imageUrls = imageUrlStrings.map({ (urlString) -> URL in
                return URL(string: urlString)!
            })
            
            let videosJSON = adviceJSON["videos"].arrayValue
            let videoUrlStrings = videosJSON.map({ (videoJSON) -> String in
                return videoJSON["video"].stringValue
            })
            let videoUrls = videoUrlStrings.map({ (urlString) -> URL in
                return URL(string: urlString)!
            })
            
            let videoPreviewUrlStrings = videosJSON.map({ (videoJSON) -> String in
                return videoJSON["preview"].stringValue
            })
            let videoPreviewUrls = videoPreviewUrlStrings.map({ (urlString) -> URL in
                return URL(string: urlString)!
            })
            
            var type = AdviceType.text
            if text == "" && imageUrlStrings == [] {
                type = .video
            } else if text == "" && videosJSON == [] {
                type = .image
            }
            
            let advice = Advice(type: type,
                                name: name,
                                text: text,
                                imageUrls: imageUrls,
                                videoUrls: videoUrls,
                                videoPreviewUrls: videoPreviewUrls)
            
            return advice
        }
        
        return advices
    }
    
}
