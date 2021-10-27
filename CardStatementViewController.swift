//
//  CardStatementViewController.swift
//  miniBanking_card
//
//  Created by Giovanni Vicentin Moratto on 26/10/21.
//

import UIKit
import miniBanking_core

protocol CardStatementDisplayerProtocol: AnyObject {
    
}

final class CardStatementViewController: ViewController,
                                    CardStatementDisplayerProtocol {
    
    private var businessHandler: CardStatementBusinessHandlerProtocol?

    func setup(businessHandler: CardStatementBusinessHandlerProtocol) {
        self.businessHandler = businessHandler
    }
    
}
