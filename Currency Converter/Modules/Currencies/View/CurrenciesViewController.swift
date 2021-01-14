//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 13/01/2021.
//

import UIKit
import  McPicker

protocol CurrenciesView: class{
    func startLoading()
    func stopLoading()
    func updateUI(currencies: [Currency])
    func showCurrenciesPickerView(data: [String])
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
        presenter?.fetchCurrencies(base: topCurrencyButton.titleLabel?.text ?? "USD")
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK:- private helper methods
    private func configPresenter(){
        presenter = CurrenciesPresenter(view: self)
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CurrencyTableViewCell")
    }
    
    //Button Actions
    @IBAction func selectCurrencyDidPressed(_ sender: Any) {
        presenter?.didTapBaseCurrency(currencies: currencies)
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
    
    func showCurrenciesPickerView(data: [String]) {
        McPicker.showAsPopover(data: [data], fromViewController: self, sourceView: topCurrencyButton, sourceRect: nil, barButtonItem: nil) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self?.updateBaseCurrencyButton(selectedCurrency: name)
                self?.presenter?.fetchCurrencies(base: name)
            }
        }
    }
    
    private func updateBaseCurrencyButton(selectedCurrency name: String){
        topCurrencyButton.setTitle(name, for: .normal)
        let image = UIImage(named: name.lowercased())
        topCurrencyButton.setImage(image, for: .normal)
    }
}

extension CurrenciesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
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
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    private func openConverterViewController(_ baseCurrency: Currency, _ selectedCurrency: Currency){
        if let converterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConverterViewController") as? ConverterViewController{
            converterVC.fromCurrency = baseCurrency
            converterVC.toCurrency = selectedCurrency
            navigationController?.pushViewController(converterVC, animated: true)
        }
    }
}
