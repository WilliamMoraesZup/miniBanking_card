//
//  PayBillViewModel.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 10/11/21.
//

import Foundation


struct CardSituationViewModel {
    private let lastDigits : String
    private let debtAmount : Double
    private let expireDate : String
    private let nextExpiration : String
    private let minimunPayment : Double
    private let expirationSituation : ExpirationSituation
    private let billSituation : BillSituation
     
    var debtAmountFormatted : String { self.debtAmount.formatedNumberValue()}
    
    var expireDateFormated : String {
        switch expirationSituation {
        case .EXPIRED:
            return "EXPIRED IN \(expireDate)"
        case .WILL_EXPIRE:
            return "WILL EXPIRES IN \(expireDate)"
        }
    }
    
    var billSituationFormatted : (name: String, color: UIColor) {
        switch billSituation {
        case .CLOSED_BILL:
            return ("CLOSED BILL", .red)
        case .OPEN_BILL:
            return ("OPEN BILL", .systemGreen)
        }
    }
    
    var nextExpirationFormated : String {
        return "next expiration date \(nextExpiration)"
    }
    
    var cardNumberFormated : String {
        return "xxxx-xxxx-xxxx-\(lastDigits)"
    }
    
    var cardFinalNumberFormatted  : String {
        return "Final \(lastDigits)"
    }
    
    var minimumPaymentFormatted : String {
        return "minimun payment \(self.minimunPayment.formatedNumberValue())"
    }
    
  
    
    init(cardSituationVM : CardSituation){
        self.lastDigits = cardSituationVM.lastDigits
        self.debtAmount = cardSituationVM.debtAmount
        self.billSituation = cardSituationVM.billSituation
        self.expireDate = cardSituationVM.expireDate
        self.nextExpiration = cardSituationVM.nextExpiration
        self.minimunPayment = cardSituationVM.minimunPayment
        self.expirationSituation  = cardSituationVM.expirationSituation
        
    }
}
