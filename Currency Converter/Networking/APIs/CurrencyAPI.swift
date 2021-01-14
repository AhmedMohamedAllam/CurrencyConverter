//
//  CurrencyAPI.swift
//  Refd Specialist
//
//  Created by Ahmed Allam on 6/23/20.
//  Copyright © 2020 Refd. All rights reserved.
//

import Foundation

class CurrencyAPI{
    private let router = Router<CurrencyEndpoint>()
    private let responseHandler: ResponseHandlerProtocol = ResponseHandler()
  
    func getLatestCurrencies(base: String, completion: @escaping ResponseCompletion<Currencies>){
        router.request(.getCurrencies(base)) { [weak self] (data, response, error) in
            self?.responseHandler.handleResponse(data, response, error, completion: completion)
        }
    }
}
