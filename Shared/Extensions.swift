//
//  Extensions.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 01/11/21.
//

import Foundation


extension Double {
    
    func formatedNumberValue() -> String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$ "
        formatter.usesGroupingSeparator = true
    
        // PODE USAR UNWRAP AQUI ??
        
        return formatter.string(for: self)!
    }
    
}
