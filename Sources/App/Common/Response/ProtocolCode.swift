//
//  File.swift
//  
//
//  Created by Guilherme Deconto on 2/24/21.
//

enum ProtocolCode: Int, Codable {
    case unknown = 0
    
    case success = 200
    
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    
    case internalServerError = 500
    
    func getMsg() -> String {
        return "\(self)"
    }
    
    func getCode() -> Int {
        return self.rawValue
    }
    
}
