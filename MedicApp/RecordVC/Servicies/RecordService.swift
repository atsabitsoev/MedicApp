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
    
    var errorReserve: String?
    
    var errorGetReservations: String?
    var reservations: [String]?
    
    
    
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
    
    
    func reserve(date: String,
                 time: String,
                 name: String,
                 surname: String) {
        
        let patientID = TokenService.standard.id!
        let url = "\(ApiInfo().baseUrl)/patient/\(patientID)/reserve"
        
        let headers: HTTPHeaders = ["Cookie": "token=\(TokenService.standard.token!); id=\(TokenService.standard.id!)"]
        
        let parameters: Parameters = ["date": date,
                                      "time": time,
                                      "name": name,
                                      "surname": surname]
        
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
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        let success = json["data"]["result"].boolValue
                        self.errorReserve = success ? nil : "Не удалось совершить запись"
                        
                    default:
                        
                        let errorString = json["data"]["error"].stringValue
                        self.errorReserve = errorString
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    print(errorString)
                    self.errorReserve = errorString
                    
                }
                
                NotificationManager.post(.reserveRequestAnswered)
        }
    }
    
    
    func getReservations() {
        
        let url = "\(ApiInfo().baseUrl)/patient/\(TokenService.standard.id!)/reservation"
        
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
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        self.errorGetReservations = nil
                        print(json)
                        
                        let reservationsJSON = json["data"]["reservations"].arrayValue
                        let reservations = reservationsJSON.map({ (json) -> String in
                            
                            let time = json["time"].stringValue
                            let date = json["date"].stringValue
                            return "\(time), \(date)"
                        })
                        
                        self.reservations = reservations
                        
                    default:
                        
                        let errorString = json["data"]["error"].stringValue
                        self.errorGetReservations = errorString
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    print(errorString)
                    self.errorGetReservations = errorString
                    
                }
                
                NotificationManager.post(.getReservationsRequestAnswered)
        }
    }
    
}
