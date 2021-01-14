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
    func didTapBaseCurrency(currencies: [Currency])
}

class CurrenciesPresenter: CurrenciesPresenterProtocol{
    var view: CurrenciesView?
    private let api = CurrencyAPI()
    
    init(view: CurrenciesView) {
        self.view = view
    }
    
    func fetchCurrencies(base: String) {
        view?.startLoading()
        api.getLatestCurrencies(base: base) {[weak self] (result) in
            guard let self = self else {return}
            self.view?.stopLoading()
            switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    self.view?.updateUI(currencies: data.currencies)
            }
        }
    }
    
    func didTapBaseCurrency(currencies: [Currency]) {
        let names = currencies.compactMap{$0.name}
        view?.showCurrenciesPickerView(data: names)
    }
    
}
