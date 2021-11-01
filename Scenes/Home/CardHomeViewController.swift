//
//  CardHomeViewController.swift
//  miniBanking_card
//
//  Created by Bruno Vieira on 23/10/21.
//

import UIKit
import miniBanking_core

protocol CardHomeDisplayerProtocol: AnyObject {
    
}

final class CardHomeViewController: ViewController,
                                    CardHomeDisplayerProtocol {
    
    private var businessHandler: CardHomeBusinessHandlerProtocol?

    func setup(businessHandler: CardHomeBusinessHandlerProtocol) {
        self.businessHandler = businessHandler
    }
    
    @IBAction func didTapStatementButton(_ sender: UIButton) {
        
        guard let navigationController =
        navigationController else { return}
        
        CardRouter.routeToStatement(on: navigationController)
        
    }
    
    
}
