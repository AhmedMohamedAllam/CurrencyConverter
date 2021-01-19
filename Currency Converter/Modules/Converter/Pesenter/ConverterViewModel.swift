//
//  ConverterPresenter.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import Foundation
protocol ConverterViewModelProtocol {
    var baseCurrency: Currency {get set}
    var convertedCurrency: Currency {get set}
    var convertedCurrencyPublisher: Published<Double>.Publisher {get}
    func convertCurrency(amount: String)
}

class ConverterViewModel: ConverterViewModelProtocol {
    var baseCurrency: Currency
    var convertedCurrency: Currency
    
    @Published var convertedAmount: Double = 0.0
    var convertedCurrencyPublisher: Published<Double>.Publisher {$convertedAmount}
    
    init(baseCurrency: Currency, convertedCurrency: Currency) {
        self.baseCurrency = baseCurrency
        self.convertedCurrency = convertedCurrency
    }
    
    func convertCurrency(amount: String) {
        convertedAmount = valideCurrency(from: amount) * convertedCurrency.value
    }
    
    private func valideCurrency(from value: String) -> Double {
        guard let doubleValue = Double(value), doubleValue >= 0 else {
            return 0
        }
        return doubleValue
    }
    
}
