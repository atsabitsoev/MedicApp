//
//  RecordService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 08/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class RecordService {
    
    
    private init() {}
    static let standard = RecordService()
    
    
    var arrValidHours: [String]?
    var getHoursError: String?
    
    
    func getValidHoursRequest(day: String) {
        
        let url = "\(ApiInfo().baseUrl)/reservation?date=\(day)"
        
        let headers: HTTPHeaders = ["Cookie": "token=\(TokenService.standard.token!); id=\(TokenService.standard.id!)"]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: nil)
            .responseJSON { (response) in
                
                do {
                    
                    let responseValue = try response.result.get()
                    let json = JSON(responseValue)
                    print(json)
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        self.getHoursError = nil
                        let arrayOfRecords = json["data"]["hours"]["times"].arrayValue
                        let validHours = arrayOfRecords.map({ (json) -> String in
                            return json["time"].stringValue
                        })
                        self.arrValidHours = validHours
                        
                    default:
                        
                        self.getHoursError = json["data"]["error"].stringValue
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    print(errorString)
                    self.getHoursError = errorString
                }
                
                NotificationManager.post(.getValidHoursRequestAnswered)
        }
        
    }
    
}
