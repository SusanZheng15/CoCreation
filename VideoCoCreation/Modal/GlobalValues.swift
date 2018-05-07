//
//  GlobalValues.swift
//  ios-core
//
//  Created by Susan Zheng on 6/1/17.
//  Copyright © 2017 Ian O'Boyle. All rights reserved.
//

import Foundation
import KeychainSwift
import UIKit


//let BASICURL = "https://q3.geniusplaza.com"
//let BASICURL = "http://192.168.1.129:8000"
//let BASICURL = "http://0.0.0.0:8000"
let BASICURL = "https://www.geniusplaza.com"
let LIVEURL = "https://www.geniusplaza.com"

let ACCESS_TOKEN_KEYCHAIN = "accessToken"
let REFRESH_TOKEN_KEYCHAIN = "refreshToken"


var GLOBAL_LANGUAGE_ID = 0

//DETECTING SCREEN SIZE

let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_STANDARD_IPHONE_6 = (IS_IPHONE && UIScreen.main.bounds.size.height == 667.0 && UIScreen.main.nativeScale == UIScreen.main.scale)
let IS_ZOOMED_IPHONE_6 = (IS_IPHONE && UIScreen.main.bounds.size.height == 568.0 && UIScreen.main.nativeScale > UIScreen.main.scale)
let IS_STANDARD_IPHONE_6_PLUS = (IS_IPHONE && UIScreen.main.bounds.size.height == 736.0 )
let IS_ZOOMED_IPHONE_6_PLUS = (IS_IPHONE && UIScreen.main.bounds.size.height == 667.0 && UIScreen.main.nativeScale < UIScreen.main.scale)

let LANGUAGE_ID_TO_STRING = [
    1: "en",
    2: "es"
]


let BUTTON_IDENTIFIER_TO_ID = [
    "grade_prek": 5,
    "grade_k":6,
    "grade_1":7,
    "grade_2":8,
    "grade_3":9,
    "grade_4":10,
    "grade_5":11,
    "grade_6":13,
    "grade_7":14,
    "grade_8":15,
    "grade_9":16,
    "grade_10":17,
    "grade_11":18,
    "grade_12":19,
    "grade_parent":20,
    "grade_teacher":22,
    "grade_all_grades":0,
]



class languageCodes{
    let english = "en"
    let spanish = "es"
}


class apiEndpoints{
    // Resources API endpoints
    let resourcesList = "get_resources"
    let resourcesDetail = "get_resource"
    let createResource = "create_resource"
    let uploadVideo = "upload_video"
    // Resources Interactions
    let reflections = "reflections"
    let hifives = "hifive"
    // Approval Endpoints
    let approvalUsers = "get_approval_users"
    let approval = "approval"
    let searchApproval = "search_approval"
    
    let classes = "classes"
    let classesTypes = "classestypes"
    
    let students = "students"
    
    let assignment = "assignment"
    let completeAssignment = "complete_assignment"
    
    let grades = "grades"
    let usersGroups = "users_groups"
    let usersRegister = "users_register"
    let usersInfo = "users_info"
    
    let forgotPassword = "forgot_password"
    let updatePassword = "update_password"
    let changeStudentPassword = "change_student_password"
    
    let forgotUsername = "forgot_username"
    
    let modeMessages = "mode_messages"
    let salutations = "salutations"
    let genders = "genders"
    let languages = "languages"
    
    let studentsRegister = "students_register"
    let editUserProfile = "edit_user_profile"
    let editStudentProfile = "edit_student_profile"
    
    let changeStatusResource = "change_status_resource"
    let deleteResource = "delete_resource"
    let editResource = "edit_resource"
    
    //Graphics Bank EndPoints
    let graphicsBank = "graphics_bank"
    let graphicsBankCategories = "graphics_bank_categories"
    
    //countries and state
    let countries = "countries"
    let states = "states"
    
    //Schools Endpoint
    let schools = "schools"
    let createSchool = "create_school"
    let relateClassWithSchool = "relate_class_with_school"
    let relateUserWithSchool = "relate_user_with_school"
    let relate = "relate"
    
    //Ebooks Endpoint
    let createEbookPage = "create_page"
    let editEbookPage = "edit_page"
    let deleteEbookPage_endpoint = "delete_page"
    
    //SubmitExerciseAnswer
    let userQuestionAnswer = "v2/user_question_answer"
    
    //resourceProgress
    let resourceProgress = "v2/resource_progress"
    
    //UsersLessonResource
    let usersLessonsResource = "v2/users_lessons_resources"
    
    //userLesson
    let userLesson = "v2/users_lessons"
    let token = "token"
    
    
    //Courses
    
    let courses = "v2/courses"
    let units = "v2/units"
    let lessons = "v2/lessons"
    let lessonResrouces = "v2/resources"
    let coursesCategories = "v2/courses_categories"
    let userRegisterCourse = "v2/user_registered_course"
    let myCourses = "v2/courses?my_courses=true"
    let assignedUnits = "v2/units?assigned_units="
    
    //Careers
    let careers = "v2/careers"
    let career_user = "v2/careers_users"
    let currentCareer = "v2/careers/?user_id="
    
    func getURLForLanguageCode(languageCode: String, endpoint: String)->String{
        return "\(BASICURL)/api/\(endpoint)/?lang=\(languageCode)"
    }
    
    func getTokenURL()->String{
        return "\(BASICURL)/o/\(token)/"
    }
    
    func getURL(endpoint: String)->String{
        return "\(BASICURL)/api/\(endpoint)/"
    }
    func getURLWithParams(endpoint: String, params: String)->String{
        return "\(BASICURL)/api/\(endpoint)\(params)"
    }
    
    func getURLWithPK(endpoint: String, resourceID: Int) -> String {
        return "\(BASICURL)/api/\(endpoint)/\(resourceID)/"
    }
}


class GPStyle: NSObject {
    
    static let sharedInstance = GPStyle()
    
    let heightForTitleHeaders: CGFloat = 50
    let heightForSmallLabels: CGFloat = 20
    
    let heightForLessonResourceCell:CGFloat = 60
    let heightForLessonDetailView:CGFloat = 70
    let borderForLessonResourceTableContent:CGFloat = 10
    
    let colorForMesagges = UIColor(red:0.25, green:0.67, blue:0.87, alpha:1.0)
    let authoringToolsColor = UIColor(red:0.21, green:0.45, blue:0.66, alpha:1.0)
    let gamingToolsColor = UIColor(red:0.94, green:0.77, blue:0.19, alpha:1.0)
    let geniusPlazaOrange = UIColor(red:0.98, green:0.70, blue:0.15, alpha:1.0)
    let colorForEbookText = UIColor(red:0.05, green:0.40, blue:0.63, alpha:1.0)
    let recorderBackViewColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
    let GPBlue = UIColor(red:0.16, green:0.67, blue:0.89, alpha:1.0)
    
}



// Global Declaration of API ENDPOINTS
let API_ENDPOINTS = apiEndpoints()
let LANGUAGE_CODES = languageCodes()
let KEYCHAIN_SWIFT = KeychainSwift()

func checkStatusCode(statusCode: Int)->Bool{
    if statusCode >= 200 && statusCode <= 299{
        return true
    }
    else{
        return false
    }
}

func unAuthorizedCode(statusCode: Int)->Bool{
    if statusCode == 403{
        return true
    }
        
    else{
        return false
    }
}

extension UIViewController {
    
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertWithCompletion(message: String, alertTitle: String, actionTitle : String, completion: (()->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: completion)
    }
    
    func areThereAnyMissing(fields: [UIView])->[Bool]{
        var arrayOfBool: [Bool] = []
        
        for field in fields{
            if field is UITextField{
                let textField = field as! UITextField
                if (textField.text?.isReallyEmpty)!{
                    textField.shakeAnimation()
                    arrayOfBool.append(true)
                }
            }
            if view is UITextView{
                let textView = field as! UITextView
                if (textView.text?.isReallyEmpty)!{
                    textView.shakeAnimation()
                    arrayOfBool.append(true)
                }
            }
        }
        return arrayOfBool
    }
    
    func checkForMissingParameters(fields: [UIView], textViewPlaceholder: String?, requiredData: [Any?]?)->[Bool]{
        var arrayOfBool: [Bool] = []
        
        for field in fields{
            if field is UITextField{
                let textField = field as! UITextField
                if (textField.text?.isReallyEmpty)!{
                    textField.shakeAnimation()
                    arrayOfBool.append(true)
                }
            }
            if field is UITextView{
                let textView = field as! UITextView
                if let textViewPlaceholder = textViewPlaceholder{
                    if textView.text == textViewPlaceholder{
                        arrayOfBool.append(true)
                    }
                }
                
                if (textView.text?.isReallyEmpty)!{
                    textView.shakeAnimation()
                    arrayOfBool.append(true)
                }
            }
        }
        if let requiredData = requiredData{
            for data in requiredData{
                if data == nil{
                    arrayOfBool.append(true)
                }
            }
        }
        
        return arrayOfBool
    }
}

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension UITextField {
    
    func shakeAnimation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue.init(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue.init(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
        
    }
}

extension UITextView {
    func shakeAnimation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue.init(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue.init(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}
