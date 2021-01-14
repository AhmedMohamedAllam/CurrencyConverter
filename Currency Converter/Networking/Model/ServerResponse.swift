//
//  ServerResponse.swift
//  Refd
//
//  Created by Ahmed Allam on 7/29/19.
//  Copyright © 2019 Refd. All rights reserved.
//

import Foundation

protocol APIResponse: class, Codable {
    var message: String {get}
}

class ServerResponse: APIResponse {
    let message: String
}

// MARK: - FailResponse
class FailResponse: Codable {
    let error: String
}
