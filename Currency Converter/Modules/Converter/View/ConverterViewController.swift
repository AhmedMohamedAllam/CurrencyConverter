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
    func didConvertCurrency(value: String)
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
        updateUI()
    }
    
    //MARK:- private helper methods
    private func configPresenter(){
        presenter = ConverterPresenter(view: self)
    }
    
    private func updateUI(){
        baseCurrencyLabel.text = fromCurrency?.name
        convertedCurrencyLabel.text = toCurrency?.name
    }
}

extension ConverterViewController: ConverterView{
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func didConvertCurrency(value: String) {
        convertedCurrencyTextField.text = value
    }
}

extension ConverterViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let amount = textFieldValue(text: textField.text ?? "", string: string)
        
        guard textField == baseCurrencyTextField else {
            return true
        }
        guard let baseCurrency = fromCurrency, let convertedCurrency = toCurrency else {
            return true
        }
        presenter?.convertCurrency(from: baseCurrency, to: convertedCurrency, amount: amount)
        
        return true
    }
    
    private func textFieldValue(text: String, string: String) -> String{
        var currentText = text
        if string == "" {
            currentText.removeLast()
        }else {
            currentText = text + string
        }
        return currentText
    }
    
}
