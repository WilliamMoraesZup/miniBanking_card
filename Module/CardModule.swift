//
//  CardModule.swift
//  miniBanking_card
//
//  Created by Bruno Vieira on 23/10/21.
//

import UIKit

public final class CardModule {
    
    public static func start(on navigationController: UINavigationController) {
        let storyboard = UIStoryboard(
            name: "Card",
            bundle: Bundle.init(for: self)
        )
        
        
        
        guard let initialViewController = storyboard.instantiateInitialViewController() as? CardHomeViewController else { exit(0) }
        let businessHandler = CardHomeViewModel()
        businessHandler.setup(displayer: initialViewController)
        initialViewController.setup(businessHandler: businessHandler)
        navigationController.pushViewController(
            initialViewController,
            animated: true
        )
    }
    
}
