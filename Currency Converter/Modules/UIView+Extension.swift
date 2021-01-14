//
//  UIView+Extension.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 14/01/2021.
//

import UIKit

extension UIView{
    
    @IBInspectable
    var cornerRadius: CGFloat{
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
}
