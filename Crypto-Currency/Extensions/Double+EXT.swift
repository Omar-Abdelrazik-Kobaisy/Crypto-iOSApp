//
//  Double+EXT.swift
//  Crypto-Currency
//
//  Created by Omar on 09/01/2024.
//

import Foundation

extension Double{
    
    ///Convert Double into Currency Formate
    ///```
    ///Convert 1234.56 to $1,234.56
    ///Convert 1.23456789 to $1.234567
    ///```
    private var currencyFormatter6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func toCurrencyFormate6() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.00"
    }
}
