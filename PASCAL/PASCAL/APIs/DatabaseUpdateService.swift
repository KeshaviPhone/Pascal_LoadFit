//
//  DatabaseUpdateService.swift
//  PASCAL
//
//  Created by My Mac on 15/10/21.
//

import Foundation
import UIKit

class DatabaseUpdateService: NSObject {
    
    static let shared = DatabaseUpdateService()
    private let systemErrorKey = "Network system error"
    
    // MARK:-   API REGISTER

//    func register(userName:String?,password:String?,email:String?,userImage:UIImage?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.register(userName: userName, password: password, email: email, userImage: userImage){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API LOGIN
//
//    func login(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.login(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API SOCIALMEDIALOGIN
//
//    func socialMediaRegister(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.socialMediaRegister(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }

//    // MARK:-   API FORGOTPASSWORD
//
//    func forgotPassword(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        RemoAPI.shared.forgotpassword(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }

    // MARK:-   API GETPROFILE

//    func getprofile(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.getprofile(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API EDITPROFILE
//
//    func editprofile(user_id:String?,username:String?,userToken:String?,userImage:UIImage?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.editprofile(user_id: user_id, username: username, userToken: userToken,userImage: userImage){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API CHANGE PASSWORD
//
//    func changepassword(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.changepassword(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API LOGOUT
//
//    func logout(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.logout(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API STATIC PAGE
//
//    func staticPage(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<StaticPageData>?)->()) {
//
//        URBAPI.shared.staticPage(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<StaticPageData>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API VERIFY EMAIL OTP
//
//    func verifyEmailOtp(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.verifyEmailOtp(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API RESEND OTP
//
//    func reSendOtp(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.reSendOtp(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API HOME LIST
//
//    func Home(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseArrayWithData<HomeModel>?)->()) {
//
//        URBAPI.shared.Home(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseArrayWithData<HomeModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API GET TEMPRATURE
//
//    func getTemprature(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseArrayWithData<TempratureModel>?)->()) {
//
//        URBAPI.shared.getTemprature(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseArrayWithData<TempratureModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API GET MEAT
//
//    func getMeat(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseArrayWithData<MeatModel>?)->()) {
//
//        URBAPI.shared.getMeat(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseArrayWithData<MeatModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
//
//    // MARK:-   API CHANGE TIMER NAME
//
//    func changeTimer(dict: [String: String]?,completion:@escaping (_ errors:[String:String]?, _ success:Bool, _ response:ResponseArrayWithData<LoginModel>?)->()) {
//
//        URBAPI.shared.changeTimer(dict: dict){ (error, data, type) in
//            guard let data = data else {
//                if let error = error {
//                    completion([self.systemErrorKey:error.localizedDescription], false, nil)
//                } else {
//                    completion(nil, false, nil)
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(ResponseArrayWithData<LoginModel>.self, from: data)
//                completion(nil, true, response)
//            } catch {
//                completion([self.systemErrorKey:error.localizedDescription], false, nil)
//            }
//        }
//    }
}

