//
//  CardStatementModule.swift
//  miniBanking_card
//
//  Created by Giovanni Vicentin Moratto on 26/10/21.
//

import UIKit

public final class CardStatementModule {
    
    public static func start(on navigationController: UINavigationController) {
        let storyboard = UIStoryboard(
            name: "Card",
            bundle: Bundle.init(for: self)
        )
        guard let initialViewController = storyboard.instantiateInitialViewController() as? CardStatementViewController else { exit(0) }
        let businessHandler = CardStatementViewModel()
        businessHandler.setup(displayer: initialViewController)
        initialViewController.setup(businessHandler: businessHandler)
        navigationController.pushViewController(
            initialViewController,
            animated: true
        )
    }
    
}
