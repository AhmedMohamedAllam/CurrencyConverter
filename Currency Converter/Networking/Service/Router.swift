//
//  Router.swift
//  
//
//  Created by Ahmed Allam on 6/26/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

class Router<EndPoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do{
            let request = try buildRequest(route)
            task = session.dataTask(with: request, completionHandler: completion)
        }catch{
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(_ route: EndpointType) throws ->  URLRequest{
        let url = route.baseUrl.appendingPathComponent(route.path)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0)
        request.httpMethod = route.httpMethod.rawValue
        
        switch route.task {
        //request without params
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        //request with parameters
        case .requestParameters(let urlParameters):
            try configureParameters(urlParameters: urlParameters, request: &request
            )
        }
        return request
    }
    
    private func configureParameters(urlParameters: Parameters?, request: inout URLRequest) throws {
        if urlParameters != nil{
            try URLParameterEncoding.encode(urlRequest: &request, with: urlParameters!)
        }
    }
    
}

