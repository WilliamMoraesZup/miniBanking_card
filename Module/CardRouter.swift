//
//  CardRouter.swift
//  miniBanking_card
//
//  Created by Bruno Vieira on 23/10/21.
//

import UIKit 

struct CardRouter {
    
    
    static func routeToStatement(on navigationController: UINavigationController) {
        StatementModule.start(on: navigationController)
    }
    
    
}
