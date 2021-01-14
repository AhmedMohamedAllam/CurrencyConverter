//
//  URLParameterEncoding.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

struct URLParameterEncoding: ParameterEncoder{
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else{
            fatalError("No url found")
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty{
           urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters{
                
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil{
            urlRequest.setValue("application/x-www-form-urlencoded; charet=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
