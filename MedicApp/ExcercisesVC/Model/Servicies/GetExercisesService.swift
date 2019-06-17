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
    
    
    var allExcercises: [Excercise]?
    var errorAllExcercises: String?
    
    
    func sendGetAllExercisesRequest() {
        
        let url = "\(ApiInfo().baseUrl)/exercise"
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
                    
                } catch {
                    
                    print(error.localizedDescription)
                }
        }
    }
    
}
