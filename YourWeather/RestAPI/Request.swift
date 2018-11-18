//
//  Request.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]  
class Request {
    
    /// Params For Request
   static func params(params: [String : Any]) -> [String : Any] {
        var urlParams = params
        urlParams["APPID"] = "1934df326baa735f77cbc93aebf63669"
    
        return urlParams
    }
    
    static func apiRequest(link: RestAPI.Methods, urlParams: [String: Any], complition: @escaping (JSONDictionary) -> ()) {
    
        Alamofire.request(link.description, method: .get, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    
                    debugPrint("HTTP Response Body: \(String(describing: response.data))")
                    
                    if let json = response.result.value {
                        complition(json as! JSONDictionary)
                    }
                    
                } else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
            }
        }
    }
}
