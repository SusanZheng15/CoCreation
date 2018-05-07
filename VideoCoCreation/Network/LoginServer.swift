//
//  LoginServer.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginServer: NSObject {

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
    
    class func renewToken(completion: @escaping (Bool)->()){
        guard let url = URL(string: API_ENDPOINTS.getTokenURL()) else {return}
        
        if let refresh_token = KEYCHAIN_SWIFT.get(REFRESH_TOKEN_KEYCHAIN){
            let parameters = "grant_type=refresh_token&refresh_token=\(String(describing: refresh_token))"
            
            let request = self.getUserPostRequest(url: url, params: parameters, methodString: "POST")
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                guard let content = data else {return}
                
                do {
                    let json = try? JSONSerialization.jsonObject(with: content, options: []) as? NSDictionary
                    
                    guard let jsonDictionary = json else {return}
                    
                    if let accessToken = jsonDictionary?["access_token"] as? String, let refreshToken = jsonDictionary?["refresh_token"] as? String {
                        OperationQueue.main.addOperation({
                            KEYCHAIN_SWIFT.set(accessToken, forKey:ACCESS_TOKEN_KEYCHAIN)
                            KEYCHAIN_SWIFT.set(refreshToken, forKey:REFRESH_TOKEN_KEYCHAIN)
                            completion(true)
                        })
                    }else{
                        completion(false)
                    }
                }
            }
            dataTask.resume()
        }else{
            completion(false)
        }
    }
    
    class func getAccessToken(username: String, password: String, completion: @escaping (String)->()){
        let localURL = URL(string: API_ENDPOINTS.getTokenURL())
        let params = "grant_type=password&username=\(username)&password=\(password)"
        
        if let mutableURL = localURL{
            
            let request = self.getUserPostRequest(url: mutableURL, params: params, methodString: "POST")
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else{return}
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299{
                    if let content = data{
                        do{
                            let json = try! JSONSerialization.jsonObject(with: content, options: []) as? NSDictionary
                            
                            guard let jsonDictionary = json else {return}
                            
                            if let accessToken = jsonDictionary["access_token"] as? String, let refreshToken = jsonDictionary["refresh_token"] as? String {
                                OperationQueue.main.addOperation({
                                    KEYCHAIN_SWIFT.set(accessToken, forKey:ACCESS_TOKEN_KEYCHAIN)
                                    KEYCHAIN_SWIFT.set(refreshToken, forKey:REFRESH_TOKEN_KEYCHAIN)
                                    completion(accessToken)
                                })
                            }
                        }
                    }
                }else{
                    completion("")
                }
            }
            dataTask.resume()
        }
    }
    
    class func hasKeychain() -> Bool {
        if KEYCHAIN_SWIFT.get(ACCESS_TOKEN_KEYCHAIN) != nil {
            return true
        }
        return false
    }
}
