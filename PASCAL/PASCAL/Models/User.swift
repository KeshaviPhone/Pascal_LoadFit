//
//  User.swift
//  PASCAL
//
//  Created by My Mac on 15/10/21.
//

import Foundation


//class LoginModel : Decodable {
//
//    var userId: Int?
//    var userName: String?
//    var email: String?
//    var userToken: String?
//    var image: String?
//    var email_verified_at: String?
//    var email_otp: Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case userId = "id"
//        case userName = "username"
//        case email = "email"
//        case userToken = "usertoken"
//        case image = "image"
//        case email_verified_at = "email_verified_at"
//        case email_otp = "email_otp"
//    }
//
//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        do
//        {
//            userId = try values.decode(Int.self, forKey: .userId)
//            userName = try values.decodeIfPresent(String.self, forKey: .userName)
//            email = try values.decodeIfPresent(String.self, forKey: .email)
//            userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
//            image = try values.decodeIfPresent(String.self, forKey: .image)
//            email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
//            email_otp = try values.decode(Int.self, forKey: .email_otp)
//        }
//        catch
//        {
//            print(error)
//        }
//    }
//}
