//
//  SwiftDataError.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 19/03/2024.
//

import Foundation

enum SwiftDataError: Error, CustomStringConvertible {
    case dataNotFound
    case fileNotFound(String)
    case dataCorrupted
    case dataProcessingFailed
    case dataValidationFailed
    case parsingError(Error?)
    case encodingError(Error?)
    case custom(String)
    case unknown
    
    var description: String {
        switch self {
        case .dataNotFound:
            return "Data not found"
        case .dataCorrupted:
            return "Data corrupted or Invalid"
        case .dataProcessingFailed:
            return "Data processing failed"
        case .dataValidationFailed:
            return "Data validation failed"
        case .custom(let error):
            return error
        case .unknown:
            return "Unknwon error occurred"
        case .fileNotFound(let path):
            return "file not found at path: \(path)"
        case .parsingError(let error):
            return "error parsing data: \(error?.localizedDescription ?? "unknown error")"
        case .encodingError(let error):
            return "error encoding data: \(error?.localizedDescription ?? "unknown error")"
        }
    }
}

extension SwiftDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataNotFound, .dataCorrupted, .dataProcessingFailed, .dataValidationFailed, .unknown,.parsingError, .encodingError:
            return "Something went wrong with SwiftData"
        case .custom(let customError):
            return customError
        case .fileNotFound(_):
            return "the requested file could not be found"
        }

    }
}
