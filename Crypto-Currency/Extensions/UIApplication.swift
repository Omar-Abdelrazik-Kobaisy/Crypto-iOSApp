//
//  UIApplication.swift
//  Crypto-Currency
//
//  Created by Omar on 05/02/2024.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func dismissKeyBoard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
