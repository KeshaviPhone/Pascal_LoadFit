//
//  URBAPI.swift
//  PASCAL
//
//  Created by My Mac on 15/10/21.
//

import Foundation
import UIKit

let prodHost: String = "https://www.keshavinfotechdemo1.com/keshav/KG1/URB/api/"


class PASCALAPI: NSObject {
    
    static var shared = PASCALAPI()
    
    private let baseUrl = prodHost
    
    private var networkingService: NetworkingService = NetworkingService()
    
    // MARK:-   API REGISTER
    
//    func register(userName:String?,
//                  password:String?,
//                  email:String?,
//                  userImage:UIImage?,
//                  completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//
//        let url = baseUrl + "register"
//
//        var parameters: [String:String] = [:]
//
//        parameters["username"] = userName
//        parameters["password"] = password
//        parameters["email"] = email
//
//        print(url)
//        print(parameters)
//
//        networkingService.connect(url: url, image: userImage!, imageParameterName: "image", inBodyParameters: parameters, completion: { (error, data, type) in
//            completion(error, data, type?.rawValue)
//        }, sendProgress: { (part, total) in
//            print(part as Any, total as Any)
//        }) { (part, total) in
//            print(part as Any, total as Any)
//        }
//    }
//
//    // MARK:-   API LOGIN
//
//    func login(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "login"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .post,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API SOCIALMEDIALOGIN
//
//    func socialMediaRegister(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "socialMediaLogin"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .post,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
    
    //    // MARK:-   API FORGOTPASSWORD
    //
    //    func forgotpassword(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
    //        let url = baseUrl + "forgotpassword"
    //
    //        print(url)
    //        print(dict!)
    //        networkingService.connect(type: .post,
    //                                  url: url,
    //                                  inPathParameters: dict,
    //                                  completion: { (error, data, type) in
    //                                    completion(error, data, type?.rawValue)
    //        })
    //    }
    
    // MARK:-   API GETPROFILE
    
//    func getprofile(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "getprofile"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .get,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API EDITPROFILE
//
//    func editprofile(user_id:String?,
//                     username:String?,
//                     userToken:String?,
//                     userImage:UIImage?,
//                     completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//
//        let url = baseUrl + "editprofile"
//
//        var parameters: [String:String] = [:]
//
//        parameters["userid"] = user_id
//        parameters["username"] = username
//        parameters["usertoken"] = userToken
//
//        print(url)
//        print(parameters)
//
//        networkingService.connect(url: url, image: userImage!, imageParameterName: "image", inBodyParameters: parameters, completion: { (error, data, type) in
//            completion(error, data, type?.rawValue)
//        }, sendProgress: { (part, total) in
//            print(part as Any, total as Any)
//        }) { (part, total) in
//            print(part as Any, total as Any)
//        }
//    }
//
//    // MARK:-   API CHANGE PASSWORD
//
//    func changepassword(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "changePassword"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .post,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API LOGOUT
//
//    func logout(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "logout"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .post,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API STATIC PAGE
//
//    func staticPage(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "staticPage"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .get,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API VERIFY EMAIL OTP
//
//    func verifyEmailOtp(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "verifyEmailOtp"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .get,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API RESEND OTP
//
//    func reSendOtp(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "reSendOtp"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .post,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API HOME LIST
//
//    func Home(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "Home"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .get,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//
//    // MARK:-   API GET TEMPRATURE
//
//    func getTemprature(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "getTemprature"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .get,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API GET MEAT
//
//    func getMeat(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "getMeat"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .get,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
//
//    // MARK:-   API CHANGE TIMER NAME
//
//    func changeTimer(dict: [String: String]?,completion:@escaping (_ error:Error?, _ data:Data?,_ type:String?)->()) {
//        let url = baseUrl + "changeTimer"
//
//        print(url)
//        print(dict!)
//        networkingService.connect(type: .post,
//                                  url: url,
//                                  inPathParameters: dict,
//                                  completion: { (error, data, type) in
//                                    completion(error, data, type?.rawValue)
//                                  })
//    }
}
