//
//  Response.swift
//  PASCAL
//
//  Created by My Mac on 15/10/21.
//

import Foundation

class Response: Decodable {
    
    var errorType: Int?
    var status: Int?
    var message: String?
    

    enum ResponseCodingKeys: String, CodingKey {
        case errorType = "error_type"
        case status = "status"
        case message = "message"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        do {
            
            if let errorType = try container.decodeIfPresent(String.self, forKey: .errorType) {
                self.errorType = Int(errorType)
            }
            
            if let status = try container.decodeIfPresent(Int.self, forKey: .status) {
                self.status = Int(status)
            }
            message = try container.decodeIfPresent(String.self, forKey: .message)
        
            
        } catch {
            print(error)
        }
    }
    
}

class ResponseWithData<DataType>: Response where DataType: Decodable {
    
    var data: DataType?
    
    enum ResponseWithDataCodingKeys: String, CodingKey {
        case data = "result"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: ResponseWithDataCodingKeys.self)
        
        do {
            data = try container.decodeIfPresent(DataType.self, forKey: .data)
        } catch {
            print(error)
        }
    }

}
class ResponseArrayWithData<DataType>: Response where DataType: Decodable {
    
    var data: [DataType]?
    
    enum ResponseWithDataCodingKeys: String, CodingKey {
        case data = "result"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: ResponseWithDataCodingKeys.self)
        
        do {
            data = try container.decodeIfPresent([DataType].self, forKey: .data)
        } catch {
            print(error)
        }
    }

}
