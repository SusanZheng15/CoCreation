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
    
    class func getMyVideosResource(search: String, types: String?, language: Int?, my_resources: Bool, page_number: Int, gid: Int?, favorites: Bool!, is_vr: Bool!, careers: Bool!, completion: @escaping (_ array: [GeniusResource], _ totalCount: Int)->()){
        MyResourcesNetwork.getResourcesBySearchWithAccessToken(search: search, types: types, language: language, my_resources: my_resources, page_number: page_number, gid: gid, favorites: favorites!, is_vr: is_vr, careers: careers) { (searchDictionary) in
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
        MyResourcesNetwork.getResourceDetail(resourceID: resourceID, completion: { (dictionary) in
            let resourceDetail = ResourceDetail.init(dictionary: dictionary)
            completion(resourceDetail)
        })
    }
    
    class func uploadVideo(title: String, description: String, type: Int, language: Int, videoOutput: URL, imageData: Data, completion: @escaping (Result<Any>)->()){
        MyResourcesNetwork.createResource(title: title, description: description, type: type, language: language, imageData: imageData, audio: nil, completion: { (resourceResult) in
            let id = resourceResult["resource_id"] as? Int
            guard let resource_id = id else {return}
    
            let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".m4v")
            
            compressVideo(inputURL: videoOutput, outputURL: compressedURL) { (exportSession) in
                guard let session = exportSession else {return}
                
                switch session.status{
                    
                case .unknown:
                    break
                case .waiting:
                    break
                case .exporting:
                    break
                case .completed:
                    guard let compressedData = try? Data(contentsOf: compressedURL) else {return}
                    
                    print("File size after compression: \(Double(compressedData.count / 1048576)) mb")
                    MyResourcesNetwork.uploadVideo(resource_id: resource_id, videoData: compressedData, completion: { (response) in
                        completion(response)
                    })
                case .failed:
                    break
                case .cancelled:
                    break
                }
            }
        })
    }
}
