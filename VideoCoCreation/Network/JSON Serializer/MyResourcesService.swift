//
//  MyResourcesService.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import Alamofire

class MyResourcesService: NSObject {
    
    class func getMyVideosResource(search: String, types: String?, language: Int!, my_resources: Bool, page_number: Int, gid: Int, favorites: Bool!, is_vr: Bool!, careers: Bool!, completion: @escaping (_ array: [GeniusResource], _ totalCount: Int)->()){
        MyResourcesServer.getResourcesBySearchWithAccessToken(search: search, types: types, language: language, my_resources: my_resources, page_number: page_number, gid: gid, favorites: favorites!, is_vr: is_vr, careers: careers) { (searchDictionary) in
            let resources = searchDictionary["Resources"] as! NSArray
            let count = searchDictionary["count"] as! Int
            var tempMyResourceArray: [GeniusResource] = []
            for eachDictionary in resources{
                let resourcesDictionary = eachDictionary as! [String:Any]
                let resources = GeniusResource.init(fromDictionary: resourcesDictionary)
                tempMyResourceArray.append(resources)
            }
            completion(tempMyResourceArray, count)
        }
    }
    
    class func getResourceDetail(resourceID: Int, completion: @escaping (ResourceDetail)->()){
        MyResourcesServer.getResourceDetail(resourceID: resourceID, completion: { (dictionary) in
            let resourceDetail = ResourceDetail.init(dictionary: dictionary)
            completion(resourceDetail)
        })
    }
    
    class func uploadVideo(title: String, description: String, type: Int, language: Int, videoData: Data, imageData: Data, completion: @escaping (Result<Any>)->()){
        MyResourcesServer.createResource(title: title, description: description, type: type, language: language, imageData: imageData, audio: nil, completion: { (resourceResult) in
            let id = resourceResult["resource_id"] as? Int
            guard let resource_id = id else {return}
            
            MyResourcesServer.uploadVideo(resource_id: resource_id, videoData: videoData, completion: { (response) in
                completion(response)
            })
            
        })
    }
}
