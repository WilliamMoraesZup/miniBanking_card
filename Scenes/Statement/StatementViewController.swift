//
//  StatementViewController.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 26/10/21.
//

import Foundation 




import UIKit
import miniBanking_core 


protocol StatementDisplayerProtocol: AnyObject {
    
}


final class StatementViewController: ViewController,
                                     StatementDisplayerProtocol  {
    
    private var businessHandler: StatementDisplayerProtocol?
    
    func setup(businessHandler: StatementDisplayerProtocol) {
        self.businessHandler = businessHandler
    }
     
    var statements  : [Statement]  = []
    var user : UserFinancial?
    
    @IBOutlet weak var tbStatements: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbUsedLimit: UILabel!
    @IBOutlet weak var lbTotalLimit: UILabel!
    @IBOutlet weak var pvBalance: UIProgressView!
    
    @IBOutlet weak var teste: UITextField!
    @IBOutlet weak var btSelectCard: UIButton!
    
    @IBAction func btChangeCard(_ sender: UIButton) {
        
     guard   let cardPicker =  storyboard?.instantiateViewController(withIdentifier: "Picker") as? PickerViewController else { exit(0) }
        
        
        present(cardPicker, animated: true, completion: nil)
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        REST.loadUser { (user) in
                       self.user = user
            
            DispatchQueue.main.async {
                self.lbUsedLimit.text = user.usedLimit.formatedNumberValue()
                self.lbTotalLimit.text = user.totalLimit.formatedNumberValue()
                
                let currentProgress = user.usedLimit / user.totalLimit
                self.pvBalance.setProgress(Float(currentProgress), animated: true)
           }
        }
 
        REST.loadStatement { (statements) in
            self.statements = statements
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    onError: { (erro) in
        print(erro)
    }
    }
     
}



