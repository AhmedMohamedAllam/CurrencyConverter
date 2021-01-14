//
//  HTTPTask.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]
enum HTTPTask {
    case request
    case requestParameters(urlParameters: Parameters?)
}
