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
    
    
    var patientProfile: PatientProfile?
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
                    let json = JSON(responseValue)
                    print(json)
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        self.getErrorString = nil
                        
                        let id = json["patient"]["id"].stringValue
                        let role = json["patient"]["role"].stringValue
                        let created = json["patient"]["created"].intValue
                        let name = json["patient"]["name"].stringValue
                        let surname = json["patient"]["surname"].stringValue
                        let sex = json["patient"]["sex"].stringValue
                        let growth = json["patient"]["growth"].floatValue
                        let weight = json["patient"]["weight"].floatValue
                        let age = json["patient"]["age"].intValue
                        let sport = json["patient"]["sport"].boolValue
                        let workType = json["patient"]["workType"].stringValue
                        
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
    
    
    func postProfileRequest(patientProfile: PatientProfile) {
        
        let url = "\(ApiInfo().baseUrl)/patient/\(TokenService.standard.id!)/profile/update"
        
        let headers: HTTPHeaders = ["Cookie": "token=\(TokenService.standard.token!); id=\(TokenService.standard.id!)"]
        
        let parameters: Parameters = ["id": patientProfile.id,
                                      "role": patientProfile.role,
                                      "created": patientProfile.created,
                                      "name": patientProfile.name,
                                      "surname": patientProfile.surname,
                                      "sex": patientProfile.sex,
                                      "growth": patientProfile.growth,
                                      "weight": patientProfile.weight,
                                      "age": patientProfile.age,
                                      "sport": patientProfile.sport,
                                      "workType": patientProfile.workType]
        
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
