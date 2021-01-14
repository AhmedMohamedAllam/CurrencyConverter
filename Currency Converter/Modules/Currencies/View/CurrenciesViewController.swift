//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 13/01/2021.
//

import UIKit
protocol CurrenciesView: class{
    func startLoading()
    func stopLoading()
    func updateUI(currencies: [Currency])
}


class CurrenciesViewController: UIViewController {
    
    @IBOutlet weak var topCurrencyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var currencies: [Currency] = []
    var presenter: CurrenciesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPresenter()
    }
    
    //MARK:- private helper methods
    private func configPresenter(){
        presenter = CurrenciesPresenter(view: self)
    }
    
    //Button Actions
    @IBAction func selectCurrencyDidPressed(_ sender: Any) {
        if let baseCurrency = topCurrencyButton.titleLabel?.text {
            presenter?.fetchCurrencies(base: baseCurrency)
        }
    }
    
}

//View protocol to be called from presenter
extension CurrenciesViewController: CurrenciesView{
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateUI(currencies: [Currency]) {
        self.currencies = currencies
        tableView.reloadData()
    }
}

extension CurrenciesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as? CurrencyTableViewCell else {
            return UITableViewCell()
        }
        let currency = currencies[indexPath.row]
        cell.updateUI(currency: currency)
        return cell
    }
    
}

extension CurrenciesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseCurrency = Currency(name: topCurrencyButton.titleLabel?.text ?? "", value: 1.0)
        let selectedCurrency = currencies[indexPath.row]
        openConverterViewController(baseCurrency, selectedCurrency)
    }
    
    private func openConverterViewController(_ baseCurrency: Currency, _ selectedCurrency: Currency){
        if let converterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConverterViewController") as? ConverterViewController{
            converterVC.fromCurrency = baseCurrency
            converterVC.toCurrency = selectedCurrency
            navigationController?.pushViewController(converterVC, animated: true)
        }
    }
}
