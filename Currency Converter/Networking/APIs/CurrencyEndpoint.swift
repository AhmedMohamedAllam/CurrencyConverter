//
//  ScheduleEndpoint.swift
//  Refd Specialist
//
//  Created by Ahmed Allam on 6/23/20.
//  Copyright © 2020 Refd. All rights reserved.
//

import Foundation

enum CurrencyEndpoint{
    case getCurrencies(_ base: String)
}

extension CurrencyEndpoint: EndpointType{
    
    var path: String {
        switch self {
        case .getCurrencies:
            return "/latest"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCurrencies:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getCurrencies(let base):
            return .requestParameters(urlParameters: ["base":base])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
