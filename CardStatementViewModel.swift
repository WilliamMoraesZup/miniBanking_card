//
//  CardStatementViewModel.swift
//  miniBanking_card
//
//  Created by Giovanni Vicentin Moratto on 26/10/21.
//

import Foundation

protocol CardStatementBusinessHandlerProtocol: AnyObject {
    
}

final class CardStatementViewModel: CardStatementBusinessHandlerProtocol {
    
    private weak var displayer: CardStatementDisplayerProtocol?
    
    func setup(displayer: CardStatementDisplayerProtocol) {
        self.displayer = displayer
    }
    
}
