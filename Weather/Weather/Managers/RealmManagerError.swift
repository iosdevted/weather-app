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
            return "Hey, This is a Encode Error!"
        case .decodeError:
            return "Hey, This is a Decode Error!"
        }
    }
}
