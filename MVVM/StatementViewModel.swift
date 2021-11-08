//
//  StatementViewModel.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 05/11/21.
//

import Foundation


struct StoreViewModel{
    let storeName: String
    let storeIcon : UIImage
    let amountSpent : Double
    
    var amountSpentFormatted: String {
        return amountSpent.formatedNumberValue()
    }

    init(_ store : Store){
        self.storeName = store.commerceName
        self.amountSpent = store.amountSpent
      
        // Aqui posso desembrulhar pois se trata de um arquivo do sistema e teoricamente é certeza de estar lá ??
          switch  store.commerceIcon {
            case "Study": self.storeIcon = UIImage(systemName:  "books.vertical")!
            case "Work" : self.storeIcon = UIImage(systemName:  "car")!
            case "Health" : self.storeIcon = UIImage(systemName:  "bolt.heart")!
            case "Food" : self.storeIcon = UIImage(systemName:  "cart")!
            default: self.storeIcon = UIImage(systemName:  "dollarsign.circle")!
                } 
        }
    }


struct StatementListViewModel{
    var statement : [Statement]
    
    
    var numberOfSections: Int {
        return statement.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
           return statement[section].dayStatements.count
        
    }
    
    func statementAtIndex(_ index : Int) -> StatementViewModel {
        let stat = self.statement[index]
        return StatementViewModel(stat)
        
    }
}



struct StatementViewModel {
    private let statement : Statement
    
}

extension StatementViewModel {
      init(_ statement : Statement) {
        self.statement = statement
    }
}


extension StatementViewModel {
     
    var date : String {
        return   self.statement.date
    }
     
    var dayStatements : [Store] {
        return statement.dayStatements
    }
    
    
}

