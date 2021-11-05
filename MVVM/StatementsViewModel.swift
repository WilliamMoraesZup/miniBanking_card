//
//  ViewModel.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 04/11/21.
//

import UIKit

class StatementsViewModel : NSObject {

    var refreshData = { () -> () in  }
    
    
     var user : UserFinancial!{
        didSet {
            refreshData()
        }
    }
    
     var months : [Months] = [] {
        didSet {
            refreshData()
       }
    }
    var statements : [Statement] = [] {
        didSet {
            refreshData()
       }
    }
     
    func retrieveMonths(){
       REST.loadMonths(){
           (months) in
            
               self.months = months
               
     
        }
       
   }
    
    func retrieveUser(){
        REST.loadUser { (response) in
            self.user = response
         
        }
    }
    
     func retrieveStatement(cardId : String, month: String){
        REST.loadStatement(cardId: cardId, query: month) { (statements) in
            self.statements = statements
            DispatchQueue.main.async {
            }
        }
    onError: { (erro) in print(erro)
    }
    }
    
}
