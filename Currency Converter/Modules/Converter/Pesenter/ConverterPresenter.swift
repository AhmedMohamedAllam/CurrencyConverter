//
//  ConverterPresenter.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import Foundation
protocol ConverterPresenterProtocol {
    var view: ConverterView? {get set}
    func convertCurrency(from: Currency, to: Currency, amount: String)
}

class ConverterPresenter: ConverterPresenterProtocol {
    var view: ConverterView?
    
    init(view: ConverterView) {
        self.view = view
    }
    
    func convertCurrency(from: Currency, to: Currency, amount: String) {
        let convertedCur = valideCurrency(from: amount) * to.value
        view?.didConvertCurrency(value: String(format: "%.2f", convertedCur))
    }
    
    private func valideCurrency(from value: String) -> Double {
        guard let doubleValue = Double(value), doubleValue >= 0 else {
            return 0
        }
        return doubleValue
    }
    
}
