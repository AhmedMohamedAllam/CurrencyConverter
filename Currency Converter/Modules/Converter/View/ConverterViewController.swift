//
//  ConverterViewController.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import UIKit
import Combine

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
    
    var viewModel: ConverterViewModelProtocol!
    private var cancellables: Set<AnyCancellable> = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setConvertedCurrencPresenter()
        updateUI()
    }
    
    private func updateUI(){
        baseCurrencyLabel.text = viewModel.baseCurrency.name
        convertedCurrencyLabel.text = viewModel.convertedCurrency.name
    }
    
    private func setConvertedCurrencPresenter(){
        viewModel.convertedCurrencyPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (amount) in
                self?.didConvertCurrency(value: "\(amount)")
            }.store(in: &cancellables)
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
       
        viewModel.convertCurrency(amount: amount)
        
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
