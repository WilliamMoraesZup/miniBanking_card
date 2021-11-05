//
//  StatementModule.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 26/10/21.
//

import UIKit
// import miniBanking_account

  public final class StatementModule {
      
      
      public static func start(on navigationController: UINavigationController) {
          let storyboard = UIStoryboard(
              name: "Statement",
              bundle: Bundle.init(for: self)
              
            
          )
           
        guard let statementViewController = storyboard.instantiateInitialViewController() as? StatementViewController else { exit(0)}
           
//        let businessHandler = StatementViewModel()
        
        
        navigationController.pushViewController(statementViewController, animated: true)
        
    }
    
    
    
}
