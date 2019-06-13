//
//  DiagnosticService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 13/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class DiagnosticService {
    
    
    private init() {}
    static let standard = DiagnosticService()
    
    
    func getDiagnosticInfoRequest() {
        
        let url = "\(ApiInfo().baseUrl)/patient/\(TokenService.standard.id!)/diagnosticInfo"
        
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
                    
                } catch {
                    
                    let errorString = error.localizedDescription
                    print(errorString)
                    
                }
        }
    }
}
