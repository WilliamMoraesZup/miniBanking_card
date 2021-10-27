//
//  CardRouter.swift
//  miniBanking_card
//
//  Created by Bruno Vieira on 23/10/21.
//

import UIKit

struct CardRouter {
    
    static func routeToCardStatement(on navigationController: UINavigationController) {
        CardStatementModule.start(on: navigationController)
        }
    
}
