//
//  ResourceDetail.swift
//  ios-core
//
//  Created by Susan Zheng on 6/5/17.
//  Copyright © 2017 Ian O'Boyle. All rights reserved.
//

import Foundation

class ResourceDetail
{
    public var creator_role : String?
    public var language : Int?
    public var career_featured_order : Int?
    public var exercise_type : String?
    public var user_hifive : Bool?
    public var total_comments : Int?
    public var grade_subject : String?
    public var id : Int?
    public var hifive_count : Int?
    public var standard : String?
    public var creator_username : String?
    public var benchmark : String?
    public var status : Int?
    public var old_id : Int?
    public var user : Int?
    public var video_type : String?
    public var subject : String?
    public var views : Int?
    public var icon : String?
    public var title : String?
    public var approval_user : Int?
    public var assigned : Bool?
    public var grade : String?
    public var resource_image : String?
    public var is_vr : Bool?
    public var career : String?
    public var featured : String?
    public var active : String?
    public var game : String?
    public var resource_audio : String?
    public var skill : String?
    public var order : Int?
    public var sound : String?
    public var description : String?
    public var printable_type : String?
    public var exercise_code : String?
    public var video_url : String?
    public var creator_avatar : String?
    public var bank_featured_order : Int?
    public var type : String?
//    public var pages: [Page] = []
//    public var firstPagesAraay: [Page] = []
    public var totalPageCount: Int?
    public var printable_url: String?
    public var original_printable_url: String?
//    public var question = Array<Questions>()
//    public var words = Array<Word>()
    
    init(dictionary: NSDictionary)
    {
        creator_role = dictionary["creator_role"] as? String
        language = dictionary["language"] as? Int
        career_featured_order = dictionary["career_featured_order"] as? Int
        exercise_type = dictionary["exercise_type"] as? String
        user_hifive = dictionary["user_hifive"] as? Bool
        total_comments = dictionary["total_comments"] as? Int
        grade_subject = dictionary["grade_subject"] as? String
        id = dictionary["id"] as? Int
        hifive_count = dictionary["hifive_count"] as? Int
        standard = dictionary["standard"] as? String
        creator_username = dictionary["creator_username"] as? String
        benchmark = dictionary["benchmark"] as? String
        status = dictionary["status"] as? Int
        old_id = dictionary["old_id"] as? Int
        user = dictionary["user"] as? Int
        video_type = dictionary["video_type"] as? String
        subject = dictionary["subject"] as? String
        views = dictionary["views"] as? Int
        icon = dictionary["icon"] as? String
        title = dictionary["title"] as? String
        approval_user = dictionary["approval_user"] as? Int
        assigned = dictionary["assigned"] as? Bool
        grade = dictionary["grade"] as? String
        resource_image = dictionary["resource_image"] as? String
        is_vr = dictionary["is_vr"] as? Bool
        career = dictionary["career"] as? String
        featured = dictionary["featured"] as? String
        active = dictionary["active"] as? String
        game = dictionary["game"] as? String
        resource_audio = dictionary["resource_audio"] as? String
        skill = dictionary["skill"] as? String
        order = dictionary["order"] as? Int
        sound = dictionary["sound"] as? String
        description = dictionary["description"] as? String
        printable_type = dictionary["printable_type"] as? String
        exercise_code = dictionary["exercise_code"] as? String
        video_url = dictionary["video_url"] as? String
        creator_avatar = dictionary["creator_avatar"] as? String
        bank_featured_order = dictionary["bank_featured_order"] as? Int
        type = dictionary["type"] as? String
        printable_url = dictionary["printable_url"] as? String
        original_printable_url = dictionary["original_printable_url"] as? String
        // question = dictionary["question"] as! Array<Questions>
        
//        let pagesArray = dictionary["Pages"] as? NSArray
//        if let pagesArray = pagesArray{
//            var count = 0
//            for eachPage in pagesArray{
//                count = count + 1
//                let pageObjectDict = eachPage as? NSDictionary
//                if let pageObjectDict = pageObjectDict{
//                    var newPages = self.helperBreakUp(pages: [pageObjectDict], results: [], count: 0)
//                    newPages[0]["isFirstPage"] = true
//                    for eachSmallerPage in newPages{
//                        let pageObject = Page.init(dictionary: eachSmallerPage as NSDictionary)
//                        pageObject.resourceDetail = self
//                        self.pages.append(pageObject)
//                    }
//                }
//
//            }
//            self.totalPageCount = count
//        }
//
//        let questionArray = dictionary["questions"] as? NSArray
//        if let questionArray = questionArray{
//            for eachQuestion in questionArray{
//                let questionDict = eachQuestion as? NSDictionary
//                if let questionDict = questionDict{
//                    let questionObject = Questions.init(dictionary: questionDict)
//                    self.question.append(questionObject)
//                }
//            }
//        }
//
//        let wordsArray = dictionary["Words"] as? NSArray
//        if let wordsArray = wordsArray {
//            for eachWord in wordsArray {
//                if let wordDict = eachWord as? NSDictionary {
//                    let wordObject = Word.init(dictionary: wordDict)
//                    words.append(wordObject)
//                }
//            }
//        }
    }
    
    func breakUp(pageObjectDict: NSDictionary, isFirstPage: Bool)->[NSDictionary]{
        // Take a page dictionary coming from the API and break it up into
        // smaller dictionaries based on how many words are in the "text" field
        var results : [NSDictionary] = []
        if let old_text = pageObjectDict["text"] as? String{
            // Prototyping, need to implement tokinziation based on spaces and then
            // break by word count
            // This should remove all the trailing and leading whitespace and new line characters
            let text = old_text.trimmingCharacters(in: .whitespacesAndNewlines)
            let mutablePageObjectDict = pageObjectDict.mutableCopy() as? NSMutableDictionary
            let mutableTempDict = pageObjectDict.mutableCopy() as? NSMutableDictionary
            
            let separatedString = text.components(separatedBy: NSCharacterSet.whitespaces)
            let pageTextStringCount = separatedString.count
            
            let breakUpTextCount = 20
            
            if pageTextStringCount > breakUpTextCount {
                // Create mutable dictionary copies
                // We need to break the page into two page objects
                // Split Dictionary into two
                let textString = text
                //separating page text into array separated by " "
                let textStringArray = textString.components(separatedBy: " ")
                
                var firstHalfofArray = ArraySlice<String>()
                var secondHalfofArray = ArraySlice<String>()
                
                let firstPageDemoninator: Int = textStringArray.count / 2
                let postFirstPagedenominator: Int = textStringArray.count * 2/3
                // Substring the text field
                if isFirstPage{
                    firstHalfofArray = textStringArray[0 ..< firstPageDemoninator]
                    secondHalfofArray = textStringArray[firstPageDemoninator ..< textStringArray.count]
                } else {
                    firstHalfofArray = textStringArray[0 ..< postFirstPagedenominator]
                    secondHalfofArray = textStringArray[postFirstPagedenominator ..< textStringArray.count]
                }
                
                let first_half = firstHalfofArray.joined(separator: " ")
                let second_half = secondHalfofArray.joined(separator: " ")
                
                
                // set the value in our new dictionaries
                mutablePageObjectDict?.setValue(first_half, forKey: "text")
                mutablePageObjectDict?.setValue(false, forKey: "isSecondPage")
                
                mutableTempDict?.setValue(second_half, forKey: "text")
                mutableTempDict?.setValue(true, forKey: "isSecondPage")
                // append to results
                
                results.append(NSDictionary(dictionary: (mutablePageObjectDict as? Dictionary)!))
                results.append(NSDictionary(dictionary: (mutableTempDict as? Dictionary)!))
            } else {
                mutablePageObjectDict?.setValue(false, forKey: "isSecondPage")
                results.append(NSDictionary(dictionary: (mutablePageObjectDict as? Dictionary)!))
            }
        }
        return results
    }
    
    func helperBreakUp(pages: [NSDictionary], results: [NSDictionary], count: Int)->[[String: Any]]{
        // When this function is first called count should be 0
        var newResults = results
        let newCount = count + 1
        var newPages = [NSDictionary]()
        for page in pages{
            if newCount == 1{
                newPages = self.breakUp(pageObjectDict: page, isFirstPage: true)
            } else {
                newPages = self.breakUp(pageObjectDict: page, isFirstPage: false)
            }
            if newPages.count > 0 {
                newResults.append(newPages[0])
                newPages.remove(at: 0)
                return self.helperBreakUp(pages: newPages, results: newResults, count: newCount)
            }
        }
        return newResults as! [[String: Any]]
    }
    
    init(){
        //Empty Initializer
    }
  
}








