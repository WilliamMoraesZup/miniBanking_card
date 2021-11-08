//
//  MonthViewModel.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 06/11/21.
//

import Foundation
struct MonthViewModel {
    var month : [Months]
    var selectedMonth : String?
    
}

extension MonthViewModel {
    init(_ months : [Months]){
        self.month = months    }
}
