//
//  AuthResponseHandler.swift
//  Refd
//
//  Created by Ahmed Allam on 6/27/19.
//  Copyright © 2019 Refd. All rights reserved.
//

import Foundation

struct ResponseHandler: ResponseHandlerProtocol {
    
    func handleResponse<T: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping ResponseCompletion<T>){
        
        guard error == nil else {
            DispatchQueue.main.async {
                completion(.failure(error!))
            }
            return
        }
        if let httpResponse = response as? HTTPURLResponse{
            let result = handleNetworkRespnses(httpResponse)
            do{
                switch result{
                case .success:
                    handleSuccess(data ,completion: completion)
                case .failure(let failureError):
                    //no response data from server
                    if data == nil {
                        DispatchQueue.main.async {
                            completion(.failure(failureError))
                        }
                        return
                    }
                    //response from server, decode and get the message
                    try handleFailure(data!, completion: completion)
                }
            }catch{
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unableToDecode))
                }
            }
        }
    }
    
    func handleSuccess<T: Codable>(_ data: Data?, completion: @escaping (Result<T, Error>)->Void){
        guard let data = data else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.noData))
            }
            return
        }
        
        do{
            let successResponse = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(successResponse))
            }
        }catch{
            print(error)
            DispatchQueue.main.async {
                completion(.failure(NetworkError.unableToDecode))
            }
        }
    }
    
    func handleFailure<T: Codable>(_ data: Data,  completion: @escaping ResponseCompletion<T>) throws{
        let serverFailResponse = try JSONDecoder().decode(FailResponse.self, from: data)
        DispatchQueue.main.async {
            let error = CustomError(message: serverFailResponse.error)
            completion(.failure(error))
        }
    }
    
    func handleNetworkRespnses(_ response: HTTPURLResponse) -> Result<String,Error>{
        switch response.statusCode {
        case 200...299:
            return .success("")
        case 401...500:
            return .failure(NetworkError.authenticationError)
        case 501...599:
            return .failure(NetworkError.badRequest)
        case 600:
            return .failure(NetworkError.outDated)
        default:
            return .failure(NetworkError.failed)
        }
    }
    
    
}


