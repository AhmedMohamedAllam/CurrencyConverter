//
//  CurrenciesPresenter.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import Foundation
import Combine

protocol CurrenciesPresenterProtocol {
    var view: CurrenciesView? {get set}
    func fetchCurrencies(base: String)
}

class CurrenciesPresenter: CurrenciesPresenterProtocol{
    var view: CurrenciesView?
    
    init(view: CurrenciesView) {
        self.view = view
    }
    
    func fetchCurrencies(base: String) {
        
    }
    
}
