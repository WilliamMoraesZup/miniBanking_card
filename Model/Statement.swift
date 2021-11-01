//
//  Statement.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 27/10/21.
//

import Foundation


struct Statement : Codable {
    let date : String
    let dayStatements : [Commerce]
    
}

struct Commerce : Codable {
    let commerceName: String
    let commerceIcon : String
    let amountSpent : Double
}


