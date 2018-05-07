//
//  RequestServer.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit

class RequestServer: NSObject {
    
    class func getUserPostRequest(url: URL, params: String, methodString: String)->URLRequest{
        var request = URLRequest(url: url)
        
        request.httpMethod = methodString
        request.httpBody = params.data(using: String.Encoding.utf8)
        request.addValue("Basic dGxMY2ZVZjc2SHpXRGpnNXBxZ0R5RkZ3QlpnZEYyb2FiandRQVZFSDo5VkZJbUFNZVhBUlBRZ0NDbXN2NlhlczZYWG5ZZHd6Q0VNc2FRN1M4R2hBcGJqN01pRFViUzlQdXRZSzBHdUIydm1vaHRhRWtrR0VaVU9BaHlPcHJtSWdUQnJyUzF4UmUzVkhDN3JKREg4UjJGZ3A4WVlEMzA1a0pvY25ySUhTdw==", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    
    class func getUserPostRequestWithoutHeader(url: URL, params: String, methodString: String)->URLRequest{
        var request = URLRequest(url: url)
        
        request.httpMethod = methodString
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        return request
    }
    
    
    class func getUserPostRequestWithParameters(url: URL, parameters: String, methodString: String)->URLRequest{
        var request = URLRequest(url: url)
        
        request.httpMethod = methodString
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        if let access_token = KEYCHAIN_SWIFT.get(ACCESS_TOKEN_KEYCHAIN){
            request.addValue("Bearer \(String(describing: access_token))", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    
    
    class func getURLRequestWithAuthenication(url: URL, methodString: String)->URLRequest{
        var request = URLRequest(url: url)
        
        request.httpMethod = methodString
        if let access_token = KEYCHAIN_SWIFT.get(ACCESS_TOKEN_KEYCHAIN){
            request.addValue("Bearer \(String(describing: access_token))", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    class func getURLRequestWithoutAuthenication(url: URL, methodString: String)->URLRequest{
        var request = URLRequest(url: url)
        
        request.httpMethod = methodString
        
        return request
    }
}
