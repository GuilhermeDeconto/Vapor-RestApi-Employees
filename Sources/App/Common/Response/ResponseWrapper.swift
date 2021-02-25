//
//  File.swift
//  
//
//  Created by Guilherme Deconto on 2/24/21.
//

import Foundation
import Vapor

class ResponseWrapper<T: Codable>: Codable {
    private var status: ProtocolCode!
    private var message: String = ""
    private var data: T?
    
    init(protocolCode: ProtocolCode) {
        self.status = protocolCode
        self.message = protocolCode.getMsg().uppercased()
    }
    
    init(obj: T) {
        self.status = ProtocolCode.success
        self.data = obj
        self.message = ProtocolCode.success.getMsg().uppercased()
    }
    
    init(protocolCode: ProtocolCode, data: T) {
        self.status = protocolCode
        self.data = data
        self.message = protocolCode.getMsg().uppercased()
    }
    
    init(protocolCode: ProtocolCode, message: String) {
        self.status = protocolCode
        self.message = message.uppercased()
    }
    
    func makeResponse() -> String {
        var result = ""
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            result = String(data: data, encoding: .utf8)!
            print("result = \(String(describing: result))")
        } catch {
            print("Encode error")
        }
        
        return result
    }
    
    func makeFutureResponse(req: Request) -> EventLoopFuture<String> {
        let promise = req.eventLoop.makePromise(of: String.self)
        
        var result = ""
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            result = String(data: data, encoding: .utf8)!
            print("result = \(String(describing: result))")
        } catch {
            print("Encode error")
        }
        
        promise.succeed(result)
        
        return promise.futureResult
    }
    
}
