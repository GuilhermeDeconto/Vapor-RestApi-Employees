//
//  File.swift
//  
//
//  Created by Guilherme Deconto on 2/24/21.
//

import Vapor

public final class MyMiddleware: Middleware {
    
    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        
        // Handle request before
        // ......
        
        // Handle request
        let resposneFuture = next.respond(to: request)
        
        // Handle request after
        return resposneFuture.flatMap { response in
            response.headers.add(name: "Content-Type", value: "application/json")
            
            return request.eventLoop.makeSucceededFuture(response)
        }
    }
}
