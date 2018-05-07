//
//  MyResourcesServer.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import Alamofire

class MyResourcesServer: NSObject {
    
    class func getResourcesBySearchWithAccessToken(search: String, types: String?, language: Int!, my_resources: Bool, page_number: Int, gid: Int?, favorites: Bool!, is_vr: Bool!, careers: Bool!, completion: @escaping (NSDictionary)->()){
        
        DispatchQueue.global(qos: .background).async {
            
            var parameters = types != nil ? "types=\(types ?? "video,ebook,printable,exercise,vocabularyset")&keywords=\(search)&my_resources=\(my_resources)&page_number=\(page_number)&number_per_page=10" : "types=video,ebook,printable,exercise,vocabularyset&keywords=\(search)&my_resources=\(my_resources)&page_number=\(page_number)&number_per_page=10"
            
            
            if let language = language {
                parameters += "&lid=\(language)"
            }
            if let gid = gid{
                parameters += "&gid=\(gid)"
            }
            if let favorites = favorites{
                parameters += "&favorites=\(favorites)"
            }
            
            if let is_vr = is_vr{
                parameters += "&is_vr=\(is_vr)"
            }
            
            if let careers = careers{
                parameters += "&careers=\(careers)"
            }
            
            let urlString = API_ENDPOINTS.getURL(endpoint: API_ENDPOINTS.resourcesList)
            guard let url = URL(string: urlString) else {return}
            
            print("Parameters : ", parameters)
            
            let request = RequestServer.getUserPostRequestWithParameters(url: url, parameters: parameters, methodString: "POST")
            
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                guard let content = data else {return}
                guard let httpResponse = response as? HTTPURLResponse else{return}
                if checkStatusCode(statusCode: httpResponse.statusCode){
                    do{
                        let jsonDictionary = try! JSONSerialization.jsonObject(with: content, options: []) as? NSDictionary
                        guard let json = jsonDictionary else {return}
                        
                        completion(json)
                    }
                }else if unAuthorizedCode(statusCode: httpResponse.statusCode){
                    LoginServer.renewToken(completion: { (result) in
                        if result{
                            getResourcesBySearchWithAccessToken(search: search, types: types, language: language, my_resources: my_resources, page_number: page_number, gid: gid, favorites: favorites, is_vr: is_vr, careers: careers, completion: { (resourcesArray) in
                                completion(resourcesArray)
                            })
                        }else{
                            print("unauthorized")
                        }
                    })
                }else{
                    print("Error with api call")
                }
            }
            dataTask.resume()
        }
    }
    
    class func getResourceDetail(resourceID: Int, completion: @escaping (NSDictionary)->()){
        let urlString = API_ENDPOINTS.getURLWithPK(endpoint: API_ENDPOINTS.resourcesDetail, resourceID: resourceID)
        
        guard let url = URL(string: urlString) else {return}
        
        let request = RequestServer.getURLRequestWithAuthenication(url: url, methodString: "GET")
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let content = data else {return}
            guard let httpResponse = response as? HTTPURLResponse else{return}
            
            if checkStatusCode(statusCode: httpResponse.statusCode){
                do{
                    let json = try! JSONSerialization.jsonObject(with: content, options: []) as? NSDictionary
                    guard let jsonDictionary = json else {return}
                    completion(jsonDictionary)
                }
            }else if unAuthorizedCode(statusCode: httpResponse.statusCode){
                do{
                    LoginServer.renewToken(completion: { (result) in
                        if result{
                            getResourceDetail(resourceID: resourceID, completion: { (jsonDictionary) in
                                completion(jsonDictionary)
                            })
                        }
                    })
                }
            }else{
                print("Error with api call code: \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
    
    class func createResource(title: String, description: String, type: Int, language: Int, imageData: Data?, audio: Data?, completion: @escaping (NSDictionary)->()){
        
        let urlString = API_ENDPOINTS.getURL(endpoint: API_ENDPOINTS.createResource)
        
        let access_token = KEYCHAIN_SWIFT.get(ACCESS_TOKEN_KEYCHAIN)!
        let headers = ["Authorization" : "Bearer \(String(describing: access_token))", "Content-Type" : "multipart/form-data"]
        
        let parameters = ["title": "\(title)",
            "description": "\(description)",
            "type_id": "\(type)",
            "language_id": "\(GLOBAL_LANGUAGE_ID)"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let data = imageData {
                multipartFormData.append(data, withName: "icon", fileName: "png", mimeType: "image/png")
            }
            if let audio = audio{
                multipartFormData.append(audio, withName: "audio", fileName: "mp3", mimeType: "application/octet-stream")
            }
            
            for (key,value) in parameters{
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: urlString,
           headers: headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch(response.result){
                        
                    case .success:
                        let statusCode = response.response?.statusCode
                        if checkStatusCode(statusCode: statusCode!){
                            if let response = response.value as? NSDictionary{
                                completion(response)
                                print(response)
                            }
                        }else if unAuthorizedCode(statusCode: statusCode!){
                            do{
                                LoginServer.renewToken(completion: { (result) in
                                    if result{
                                        createResource(title: title, description: description, type: type, language: language, imageData: imageData, audio: audio, completion: { (response) in
                                            completion(response)
                                        })
                                    }
                                })
                            }
                        }
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut{
                            print("timeout error")
                        }
                    }
                }
            case .failure(let encodingError):
                print("encoding Error : \(encodingError)")
            }
        })
        
    }
    
    class func uploadVideo(resource_id: Int, videoData: Data, completion: @escaping (Result<Any>)->()){
        let urlString = API_ENDPOINTS.getURLWithPK(endpoint: API_ENDPOINTS.uploadVideo, resourceID: resource_id)
        
        let accessToken = KEYCHAIN_SWIFT.get(ACCESS_TOKEN_KEYCHAIN)!
        let headers = ["Authorization" : "Bearer \(accessToken)", "Content-Type" : "multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //specify video type (iOS videos: .mov)
                multipartFormData.append(videoData, withName: "mov_file", fileName: "mov_file", mimeType: "video/quicktime")
                
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        switch(response.result){
                            
                        case .success:
                            let statusCode = response.response?.statusCode
                            if checkStatusCode(statusCode: statusCode!){
                                completion(response.result)
                                print(response)
                            }else if unAuthorizedCode(statusCode: statusCode!){
                                do{
                                    LoginServer.renewToken(completion: { (result) in
                                        if result{
                                            self.uploadVideo(resource_id: resource_id, videoData: videoData, completion: { (result) in
                                                completion(result)
                                            })
                                        }
                                    })
                                }
                            }
                        case .failure(let error):
                            if error._code == NSURLErrorTimedOut{
                                print("timeout error")
                            }
                        }
                    }
                case .failure(let encodingError):
                    if encodingError._code == NSURLErrorTimedOut{
                        print("TIMED OUT")
                    }
                }
        })
        
    }
}
