//
//  CurrenciesPresenter.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import Foundation
import Combine

protocol CurrenciesViewModelProtocol {
    var currencies: [Currency] {get set}
    var currenciesPuplisher: Published<[Currency]>.Publisher {get}
    var isFetchingDataPublisher: Published<Bool>.Publisher {get}
    func fetchCurrencies(base: String)
}

class CurrenciesViewModel: CurrenciesViewModelProtocol{
    
    
    @Published var currencies: [Currency] = []
    @Published var isFetchingData: Bool = false

    var currenciesPuplisher: Published<[Currency]>.Publisher{ $currencies }
    var isFetchingDataPublisher: Published<Bool>.Publisher{ $isFetchingData }

    private let api = CurrencyAPI()
    
    func fetchCurrencies(base: String) {
        isFetchingData = true
        api.getLatestCurrencies(base: base) {[weak self] (result) in
            guard let self = self else {return}
            self.isFetchingData = false
            switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    self.currencies = data.currencies
            }
        }
    }
    
}
