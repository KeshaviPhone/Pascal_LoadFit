//
//  UserModel.swift
//  PASCAL
//
//  Created by My Mac on 15/10/21.
//

import Foundation
import UIKit

//class UserModel: NSObject, NSCoding {
//
//    var userId: Int?
//    var userName: String?
//    var userToken: String?
//    var email: String?
//    var image: String?
//
//    static var userModel: UserModel?
//    static func sharedInstance() -> UserModel {
//        if UserModel.userModel == nil {
//            if let data = UserDefaults.standard.value(forKey: "UserModel") as? Data {
//                let retrievedObject = NSKeyedUnarchiver.unarchiveObject(with: data)
//                if let objUserModel = retrievedObject as? UserModel {
//                    UserModel.userModel = objUserModel
//                    return objUserModel
//                }
//            }
//            if UserModel.userModel == nil {
//                UserModel.userModel = UserModel.init()
//            }
//            return UserModel.userModel!
//        }
//        return UserModel.userModel!
//    }
//
//    override init() {
//
//    }
//
//    func synchroniseData(){
//        let data : Data = NSKeyedArchiver.archivedData(withRootObject: self)
//        UserDefaults.standard.set(data, forKey: "UserModel")
//        UserDefaults.standard.synchronize()
//    }
//
//    func removeData() {
//        UserModel.userModel = nil
//        UserDefaults.standard.removeObject(forKey: "UserModel")
//        UserDefaults.standard.synchronize()
//    }
//
//    required init(coder aDecoder: NSCoder) {
//
//        super.init()
//        self.userId = aDecoder.decodeObject(forKey: "id") as? Int
//        self.userName = aDecoder.decodeObject(forKey: "username") as? String
//        self.userToken = aDecoder.decodeObject(forKey: "usertoken") as? String
//        self.email = aDecoder.decodeObject(forKey: "email") as? String
//        self.image = aDecoder.decodeObject(forKey: "image") as? String
//
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.userId, forKey: "id")
//        aCoder.encode(self.userName, forKey: "username")
//        aCoder.encode(self.userToken, forKey: "usertoken")
//        aCoder.encode(self.email, forKey: "email")
//        aCoder.encode(self.image, forKey: "image")
//    }
//}
