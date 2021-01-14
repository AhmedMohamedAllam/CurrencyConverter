//
//  NetworkError.swift
//  
//
//  Created by Ahmed Allam on 7/29/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

struct CustomError: Error, LocalizedError {
    var errorDescription: String?
    
    init(message: String) {
        errorDescription = message
    }
}

enum NetworkError: Error {
    case parametersNil
    case encodingFailed
    case missingUrl
    case networkConnectionError
    case authenticationError
    case badRequest
    case outDated
    case failed
    case noData
    case unableToDecode
}

extension NetworkError: LocalizedError{
    var errorDescription: String?{
        switch self {
            
        case .parametersNil:
            return "Prameters were nil"
        case .encodingFailed:
            return "Parameters encoding failed"
        case .missingUrl:
            return "Url is nil"
        case .networkConnectionError:
            return "Please check your network connection"
        case .authenticationError:
            return "you need to be authenticated first"
        case .badRequest:
            return "Bad Request"
        case .outDated:
            return "The url requested is outdated"
        case .failed:
            return "Network request failed"
        case .noData:
            return "Response returned with no data"
        case .unableToDecode:
            return "Something went wrong, please try again later!"
        }
    }
}

