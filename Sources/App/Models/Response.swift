//
//  File.swift
//  
//
//  Created by Guilherme Deconto on 2/24/21.
//

import Foundation

struct Response<T> : Content where T: Content {
    var message: String?
    var status: UInt?
    var data: T?
    
    init(message: String, status: UInt, data: T) {
        self.message = message
        self.status = status
        self.data = data
    }
}
