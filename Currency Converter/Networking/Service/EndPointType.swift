//
//  EndPointType.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

protocol EndpointType {
    var baseUrl: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
}


extension EndpointType{
    var baseUrl: URL {
        guard let url = URL(string: "https://api.exchangeratesapi.io") else{
            fatalError("baseURL could not be configured.")
        }
        return url
    }
}
