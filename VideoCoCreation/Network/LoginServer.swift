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

    class func renewToken(completion: @escaping (Bool)->()){
        guard let url = URL(string: API_ENDPOINTS.getTokenURL()) else {return}
        
        if let refresh_token = KEYCHAIN_SWIFT.get(REFRESH_TOKEN_KEYCHAIN){
            let parameters = "grant_type=refresh_token&refresh_token=\(String(describing: refresh_token))"
            
            let request = RequestServer.getUserPostRequest(url: url, params: parameters, methodString: "POST")
            
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
            
            let request = RequestServer.getUserPostRequest(url: mutableURL, params: params, methodString: "POST")
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
