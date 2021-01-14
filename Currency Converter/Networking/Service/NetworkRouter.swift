//
//  NetworkRouter.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter {
    associatedtype EndPoint = EndpointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}

