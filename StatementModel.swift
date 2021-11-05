//
//  Statement.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 27/10/21.
//

import Foundation


struct Statement : Codable   {
    let date : String
    let dayStatements : [Store]
    
}

struct UserFinancial : Codable  {
    let accountId : String
    let cards : [Card]
}


struct Card : Codable{
    let cardId : String
    let lastDigits : String
    let totalLimit : Double
    let usedLimit : Double
    
}
 
struct Store : Codable {
    let commerceName: String
    let commerceIcon : String
    let amountSpent : Double
    
    var setIcon : UIImage {
        switch  commerceIcon {
        case "Study": return UIImage(systemName:  "books.vertical")!
        case "Work" : return UIImage(systemName:  "car")!
        case "Health" : return UIImage(systemName:  "bolt.heart")!
        case "Food" : return  UIImage(systemName:  "cart")!
        default: return UIImage(systemName:  "dollarsign.circle")!
        }
    }
}


struct Months : Codable {
    let monthName: String
    var query : String  {
        
        switch monthName {
        case "October"  : return "oct"
        case "November" : return "nov"
        case "September" : return "sep"
        case "Three Lasts" : return "default"
        default:
            return "default"
        }
        
    }
    
    
}

