//
//  CardViewModel.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 06/11/21.
//

import Foundation



class UserViewModel {
    var accountId : String
    var cards : [Card]
    var selectedCard : CardViewModel?
  
    init(_ user : UserFinancial){
       self.accountId = user.accountId
       self.cards = user.cards
      
    
   }
}
   

struct CardViewModel {
    var lastDigits : String
    var cardId: String
    let totalLimit : Double
    let usedLimit : Double
    var formattedTotal : String { return totalLimit.formatedNumberValue() }
    var formattedUsed : String {   return usedLimit.formatedNumberValue() }
    var balance : Float {  return Float(usedLimit/totalLimit)   }
         

    init(_ card : Card){
        self.lastDigits = card.lastDigits
        self.cardId = card.cardId
        self.totalLimit = card.totalLimit
        self.usedLimit = card.usedLimit
        
    }
}
