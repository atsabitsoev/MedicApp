//
//  ProfileAPIService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 06/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ProfileAPIService {
    
    
    private init() {}
    static let standard = ProfileAPIService()
    
    
    var patientProfile: PatientProfile!
    var getErrorString: String?
    var postErrorString: String?
    
    
    func getProfileRequest() {
        
        let url = "\(ApiInfo().baseUrl)/patient/\(TokenService.standard.id!)/profile"
        
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
                    let json = JSON(responseValue)["data"]
                    print(json)
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        self.getErrorString = nil
                        
                        let id = json["patient"]["id"].stringValue
                        let role = json["patient"]["role"].stringValue
                        let created = json["patient"]["created"].intValue
                        let name = json["patient"]["name"].stringValue
                        let surname = json["patient"]["surname"].stringValue
                        let sex = json["patient"]["sex"].string ?? Sex.male.rawValue
                        let growth = json["patient"]["growth"].floatValue
                        let weight = json["patient"]["weight"].floatValue
                        let age = json["patient"]["age"].intValue
                        let sport = json["patient"]["sport"].bool ?? true
                        let workType = json["patient"]["workType"].string ?? WorkType.active.rawValue
                        
                        let patientProfile = PatientProfile(id: id,
                                                            role: role,
                                                            created: created,
                                                            name: name,
                                                            surname: surname,
                                                            sex: sex,
                                                            growth: growth,
                                                            weight: weight,
                                                            age: age,
                                                            sport: sport,
                                                            workType: workType)
                        
                        self.patientProfile = patientProfile
                        
                    default:
                        
                        self.getErrorString = json["data"]["error"].stringValue
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    self.getErrorString = errorString
                    print(errorString)
                }
                
                NotificationManager.post(.getProfileRequestAnswered)
        }
    }
    
    
    func postProfileRequest() {
        
        let url = "\(ApiInfo().baseUrl)/patient/\(TokenService.standard.id!)/profile/update"
        
        let headers: HTTPHeaders = ["Cookie": "token=\(TokenService.standard.token!); id=\(TokenService.standard.id!)"]
        
        let parameters: Parameters = ["profile":["id": self.patientProfile.id,
                                                 "role": self.patientProfile.role,
                                                 "created": self.patientProfile.created,
                                                 "name": self.patientProfile.name,
                                                 "surname": self.patientProfile.surname,
                                                 "sex": self.patientProfile.sex,
                                                 "growth": self.patientProfile.growth,
                                                 "weight": self.patientProfile.weight,
                                                 "age": self.patientProfile.age,
                                                 "sport": self.patientProfile.sport,
                                                 "workType": self.patientProfile.workType]]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
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
                        
                        self.postErrorString = nil
                        
                    default:
                        
                        self.postErrorString = json["data"]["error"].stringValue
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    self.postErrorString = errorString
                    print(errorString)
                    
                }
                
                NotificationManager.post(.postProfileRequestAnswered)
        }
    }
}
