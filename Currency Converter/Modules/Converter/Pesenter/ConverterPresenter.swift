//
//  ConverterPresenter.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import Foundation
protocol ConverterPresenterProtocol {
    var view: ConverterView? {get set}
    func convertCurrency(from: String, to: String, value: String)
}

class ConverterPresenter: ConverterPresenterProtocol {
    var view: ConverterView?
    
    init(view: ConverterView) {
        self.view = view
    }
    
    func convertCurrency(from: String, to: String, value: String) {
        guard let doubleValue = validateCurrency(value: value) else {
            return
        }
        print(from, to, doubleValue)
    }
    
    private func validateCurrency(value: String) -> Double? {
        guard let doubleValue = Double(value), doubleValue >= 0 else {
            return nil
        }
        return doubleValue
    }
    
}
