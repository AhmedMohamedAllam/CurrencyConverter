//
//  ResponseHandler.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

typealias ResponseCompletion<T: Codable> = (Result<T, Error>)->Void

protocol ResponseHandlerProtocol {
     func handleResponse<T: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?,completion: @escaping ResponseCompletion<T>)
    
    func handleSuccess<T: Codable>(_ data: Data?,  completion: @escaping ResponseCompletion<T>) throws
    
    func handleFailure<T: Codable>(_ data: Data,  completion: @escaping ResponseCompletion<T>) throws
}

