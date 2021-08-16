//
//  RealmManagerError.swift
//  Weather
//
//  Created by Ted on 2021/08/16.
//

import Foundation

enum RealmManagerError: Error, LocalizedError {
    
    case encodeError
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .encodeError:
            return "Hey, this is a encode Error!"
        case .decodeError:
            return "Hey, this is a decode Error!"
        }
    }
}
