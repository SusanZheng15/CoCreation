//
//  ResourcesModel.swift
//  ios-core
//
//  Created by Susan Zheng on 5/24/17.
//  Copyright © 2017 Ian O'Boyle. All rights reserved.
//

import Foundation


//Class for the list of resource's info
class GeniusResource
{
    private var title: String!
    private var descriptionString: String!
    private var creatorUsername: String!
    private var creatorAvatarURL: String!
    private var resourceImageURL: String!
    private var resourceVideoURL: String!
    private var hifiveCount: Int!
    private var resourceID: Int!
    private var user_Hifive: Bool!
    private var assigned: Bool!
    private var total_comments: Int!
    private var viewCount: Int!
    private var creator_role: String!
    private var status: Int!
    private var language: Int!
//    private var type: ListOfResourceTypes!
//    private var resourceDetail: ResourceDetail?
    private var resourceAudio: String!
    
    //Set/Get functions
    func setTitle(title: String){self.title = title}
    func getTitle() -> String {return self.title}
    func setDescriptionString(description: String){self.descriptionString = description}
    func getDescriptionString()->String{return self.descriptionString}
    func setCreatorUsername(username: String){self.creatorUsername = username}
    func getCreatorUsername()->String{return self.creatorUsername}
    func setCreatorAvatarURL(urlString: String){self.creatorAvatarURL = urlString}
    func getCreatorAvatarURLString()->String{return self.creatorAvatarURL}
    func setHifiveCount(hifiveCount: Int){self.hifiveCount = hifiveCount}
    func getHifiveCount()->Int{ return self.hifiveCount }
    func setResourceImageURL(resourceImageURL: String){self.resourceImageURL = resourceImageURL}
    func getResourceImageURL()->String{return self.resourceImageURL}
    func setResourceVideoURL(resourceVideoURL: String){self.resourceVideoURL = resourceVideoURL}
    func getResourceVideoURL()->String{return
        self.resourceVideoURL}
    func setResourceID(resourceID: Int){self.resourceID = resourceID}
    func getResourceID()->Int{return self.resourceID}
    func setUserHiFive(userHiFive: Bool){self.user_Hifive = userHiFive}
    func getUserHiFive()->Bool{return self.user_Hifive}
    func setAssigned(assigned: Bool){self.assigned = assigned}
    func getAssigned()->Bool{return self.assigned}
    func setTotalComments(totalComments: Int){self.total_comments = totalComments}
    func getTotalComments()->Int{return self.total_comments}
    func setViewCount(viewCount: Int){self.viewCount = viewCount}
    func getViewCount()->Int{return self.viewCount}
    func setCreatorRole(role: String){self.creator_role = role}
    func getCreatorRole()->String{return self.creator_role}
    func setStatus(status: Int){self.status = status}
    func getStatus()->Int{return self.status}
    func setLanguage(language: Int){self.language = language}
    func getLanguage()->Int{
        if let newLanguage = self.language{
            return newLanguage
        }
        return 0
    }
//    func setType(resourceType: ListOfResourceTypes){self.type = resourceType}
//    func getType()->ListOfResourceTypes{return self.type}
//    func setResourceDetail(detail: ResourceDetail?){self.resourceDetail = detail}
//    func getResourceDetail()->ResourceDetail?{return self.resourceDetail}
    func setResourceAudio(resourceAudio: String){self.resourceAudio = resourceAudio}
    func getResourceAudio()->String{return self.resourceAudio}
    
    //This initializer will be used when doing an API call for getting the resources's info via dictionary
    init(fromDictionary: [String: Any]) {
        if let title = fromDictionary["title"]{
            self.setTitle(title: title as! String)
        }
        if let description = fromDictionary["description"]{
            self.setDescriptionString(description: description as! String)
        }
//        if let typeString = fromDictionary["type"]{
//            let resourceTypeArray = ResourceDataStore.sharedInstance.getResourceTypeArray()
//            let resourceType = resourceTypeArray.first(where: {($0 ).apiString == (typeString as! String)})
//            self.setType(resourceType: resourceType!)
//
//        }
        if let urlString = fromDictionary["creator_avatar"]{
            self.setCreatorAvatarURL(urlString: urlString as! String)
        }
        if let username = fromDictionary["creator_username"]{
            self.setCreatorUsername(username: username as! String)
        }
        if let hifiveCount = fromDictionary["hifive_count"]{
            self.setHifiveCount(hifiveCount: hifiveCount as! Int)
        }
        if let resourceImage = fromDictionary["icon"]{
            self.setResourceImageURL(resourceImageURL: resourceImage as! String)
        }
        if let resourceVideoURL = fromDictionary["video_url"] {
            self.setResourceVideoURL(resourceVideoURL: resourceVideoURL as! String)
        }
        if let resourceID = fromDictionary["id"] {
            self.setResourceID(resourceID: resourceID as! Int)
        }
        if let userHi_five = fromDictionary["user_hifive"]{
            self.setUserHiFive(userHiFive: userHi_five as! Bool)
        }
        if let assigned = fromDictionary["assigned"]{
            self.setAssigned(assigned: assigned as! Bool)
        }
        if let totelComments = fromDictionary["total_comments"]{
            self.setTotalComments(totalComments: totelComments as! Int)
        }
        if let viewCount = fromDictionary["views"]{
            self.setViewCount(viewCount: viewCount as! Int)
        }
        if let creatorRole = fromDictionary["creator_role"]{
            self.setCreatorRole(role: creatorRole as! String)
        }
        if let status = fromDictionary["status"]{
            self.setStatus(status: status as! Int)
        }
        if let language = fromDictionary["language"]{
            if let languageInt = language as? Int {
                self.setLanguage(language: languageInt)
            } else {
                // Do nothing
            }
        }
        if let resourceAudio = fromDictionary["resource_audio"]{
            self.setResourceAudio(resourceAudio: resourceAudio as! String)
        }
        
    }
    
}


extension GeniusResource: CustomStringConvertible {
    var description: String {
        return "(\(self.getTitle()), \(self.getDescriptionString()))"
    }
}
