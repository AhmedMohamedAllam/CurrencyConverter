//
//  Currency.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 13/01/2021.
//


import UIKit

struct Currencies: Codable {
    let base: String?
    private let rates: [String: Double]?
    
    var currencies: [Currency]{
        rates?.enumerated().map{Currency(name: $0.element.key, value: $0.element.value)} ?? []
    }
}

struct Currency {
    let name: String
    let value: Double
    
    var image: UIImage?{
        UIImage(named: name.lowercased())
    }
}
