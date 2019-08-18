//
//  GetExercisesService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 04/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetExercisesService {
    
    private init() {}
    static let standard = GetExercisesService()
    
    
    var allExercises: [[Exercise]]?
    var errorAllExcercises: String?
    
    var myExercises: [[Exercise]]?
    var errorMyExercises: String?
    
    
    func sendGetAllExercisesRequest() {
        
        let url = "\(ApiInfo().baseUrl)/exercise?limit=100"
        print("token - \(TokenService.standard.token!)")
        let headers: HTTPHeaders = ["Cookie": "token=\(TokenService.standard.token!); id=\(TokenService.standard.id!)"]
     
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers, interceptor: nil)
            .responseJSON { (response) in
            
                do {
                    
                    let responseValue = try response.result.get()
                    let json = JSON(responseValue)
                    print(json)
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        let exercisesJSON = json["data"]["exercises"].arrayValue
                        print(exercisesJSON)
                        
                        let exercises = self.parseExercises(exercisesJSON: exercisesJSON)
                        
                        self.allExercises = exercises
                        self.errorAllExcercises = nil
                        
                    default:
                        
                        self.errorAllExcercises = json["data"]["error"].stringValue
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    print(errorString)
                    self.errorAllExcercises = errorString
                }
                
                NotificationManager.post(.getAllExercisesRequestAnswered)
        }
    }
    
    
    func sendGetMyExcercisesRequest() {
        
        let url = "\(ApiInfo().baseUrl)/patient/\(TokenService.standard.id!)/exercise?limit=100"
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
                        
                        let exercisesJSON = json["data"]["exercises"].arrayValue
                        let exercises = self.parseExercises(exercisesJSON: exercisesJSON)
                        
                        self.myExercises = exercises
                        self.errorMyExercises = nil
                        
                    default:
                        
                        let errorString = json["message"].stringValue
                        self.errorMyExercises = errorString
                        print(errorString)
                        
                    }
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    self.errorMyExercises = errorString
                    print(errorString)
                    
                }
                NotificationManager.post(.getMyExercisesRequestAnswered)
        }
    }
    
    
    private func parseExercises(exercisesJSON: [JSON]) -> [[Exercise]] {
        
        let exercises = exercisesJSON
            .map({ (json) -> Exercise in
                print("gdsf")
                let category = json["category"].stringValue
                
                let previewString = json["videos"].arrayValue[0]["preview"].stringValue
                let videoString = json["videos"].arrayValue[0]["video"].stringValue
                
                let previewUrl = URL(string: "\(ApiInfo().baseUrl)\(previewString)")!
                let videoUrl = URL(string: "\(ApiInfo().baseUrl)\(videoString)")!
                let name = json["name"].stringValue
                
                return Exercise(name: name, preview: previewUrl, video: videoUrl, category: category)
            }).sorted { (ex1, ex2) -> Bool in
                return ex1.category < ex2.category
        }
        
        var previousEx: Exercise? = nil
        var masMasExercises: [[Exercise]] = []
        for ex in exercises {
            if ex.category != previousEx?.category {
                masMasExercises.append([ex])
            } else {
                masMasExercises[masMasExercises.count - 1].append(ex)
            }
            previousEx = ex
        }
        
        return masMasExercises
    }
    
}
