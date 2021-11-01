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
    
    @IBOutlet weak var tbStatements: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FooterTableCell", bundle: nil), forCellReuseIdentifier: "footerCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
       
 
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




extension StatementViewController : UITableViewDelegate {}
extension StatementViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return statements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          
        return statements[section].dayStatements.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statementCell", for: indexPath)
        as! StatementViewCell
        
        let stat = statements[indexPath.section]
         
        let toShow = stat.dayStatements[indexPath.row]
        
        cell.lbCommerceName.text = toShow.commerceName
        cell.lbValue.text = String(toShow.amountSpent)

        switch toShow.commerceIcon {
        case "Study":  cell.ivCommerceIcon.image = UIImage(systemName:  "books.vertical")
        case "Work" :  cell.ivCommerceIcon.image = UIImage(systemName:  "car")
        case "Health" :  cell.ivCommerceIcon.image = UIImage(systemName:  "bolt.heart")
        case "Food" :  cell.ivCommerceIcon.image = UIImage(systemName:  "cart")
        default:
            cell.ivCommerceIcon.image =  UIImage(systemName:  "dollarsign.circle")
        }

           return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = statements[section]
        
        return title.date
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        let sum = statements[section].dayStatements .reduce(0, { runningSum,
            value in
            runningSum + value.amountSpent
        }
        )
        return String(sum)
        }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") as!
        FooterTableCell

     //  cell.teste.text = "testando"

        return cell
    }

}

