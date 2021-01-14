//
//  APIData.swift
//  
//
//  Created by Ahmed Allam on 4/2/20.
//  Copyright © 2020 The D. GmbH. All rights reserved.
//

import Foundation

class APIData<T: Codable>: Codable{
    let data: T
    
    init(data: T) {
        self.data = data
    }
}

struct EmptyData: Codable {}

