//
//  SwiftDataError.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 19/03/2024.
//

import Foundation

enum SwiftDataError: Error, CustomStringConvertible {
    case dataNotFound
    case dataCorrupted
    case dataProcessingFailed
    case dataValidationFailed
    case custom(String)
    case unknown
    
    var description: String {
        switch self {
        case .dataNotFound:
            return "Data not found"
        case .dataCorrupted:
            return "Data corrupted"
        case .dataProcessingFailed:
            return "Data processing failed"
        case .dataValidationFailed:
            return "Data validation failed"
        case .custom(let error):
            return error
        case .unknown:
            return "Unknwon error occurred"
        }
    }
}

extension SwiftDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataNotFound, .dataCorrupted, .dataProcessingFailed, .dataValidationFailed, .unknown:
            return "Something went wrong with SwiftData"
        case .custom(let customError):
            return customError
        }

    }
}
