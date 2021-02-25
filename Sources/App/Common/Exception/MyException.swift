//
//  File.swift
//  
//
//  Created by Guilherme Deconto on 2/24/21.
//

import Foundation

enum MyException: Error {
    case requestParamError
}

extension MyException: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .requestParamError:
            return NSLocalizedString("Request param error", comment: "")
        }
    }
    
}
