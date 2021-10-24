//
//  CardHomeViewModel.swift
//  miniBanking_card
//
//  Created by Bruno Vieira on 23/10/21.
//

import Foundation

protocol CardHomeBusinessHandlerProtocol: AnyObject {
    
}

final class CardHomeViewModel: CardHomeBusinessHandlerProtocol {
    
    private weak var displayer: CardHomeDisplayerProtocol?
    
    func setup(displayer: CardHomeDisplayerProtocol) {
        self.displayer = displayer
    }
    
}
