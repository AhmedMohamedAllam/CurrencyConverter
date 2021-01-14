//
//  ParameterEncoding.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest,with parameters: Parameters) throws
}

extension ParameterEncoder{
    static func encode(urlRequest: inout URLRequest,with parameters: Parameters) throws {}
}

