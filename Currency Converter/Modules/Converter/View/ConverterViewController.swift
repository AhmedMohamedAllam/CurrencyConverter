//
//  ConverterViewController.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import UIKit

protocol ConverterView: class {
    func startLoading()
    func stopLoading()
    func didConvertCurrency(value: Double)
}

class ConverterViewController: UIViewController {

    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    @IBOutlet weak var convertedCurrencyTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //public vars will be provided before call
    var fromCurrency: Currency?
    var toCurrency: Currency?
    
    var presenter: ConverterPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPresenter()
    }
    
    //MARK:- private helper methods
    private func configPresenter(){
        presenter = ConverterPresenter(view: self)
    }
    
}

extension ConverterViewController: ConverterView{
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func didConvertCurrency(value: Double) {
        convertedCurrencyTextField.text = "\(value)"
    }
}

extension ConverterViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField == baseCurrencyTextField else {
            return
        }
        guard let baseCurrencyName = fromCurrency?.name, let convertedCurrencyName = toCurrency?.name, let value = textField.text else {
            return
        }
        presenter?.convertCurrency(from: baseCurrencyName, to: convertedCurrencyName, value: value)
    }
}
