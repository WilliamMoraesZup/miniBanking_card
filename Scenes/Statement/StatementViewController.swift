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
    
    //      MARK: Variables
    var months : [Months] = []
    var pickers : ViewPickers = ViewPickers()
    
    // MARK: Injectables
    var statementVM : StatementListViewModel!
    var userVM : UserViewModel!
    var selectedCardVM : CardViewModel?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbUsedLimit: UILabel!
    @IBOutlet weak var lbTotalLimit: UILabel!
    @IBOutlet weak var pvBalance: UIProgressView!
    @IBOutlet weak var btSelectCard: UIButton!
    @IBOutlet weak var lbTypeOfCard: UILabel!
    @IBOutlet weak var scMonthSwitch: UISegmentedControl!
    @IBOutlet weak var lbFinalCard: UILabel!
     
    @IBOutlet weak var btPayBill: UIButton!
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scMonthSwitch.removeAllSegments()
        scMonthSwitch.isEnabled =  false
        btPayBill.isEnabled  = false
        loadItems();
        fetchData()
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "payBillSegue"{
            let view = segue.destination as! PayBillViewController
            view.cardId = selectedCardVM?.cardId
             
             
        }
    }
 
    func loadItems(){
        pickers.delegate(delegate: self)
        self.pickers.cardPickerView.dataSource = self
        self.pickers.cardPickerView.delegate = self
         }
   
    
    // MARK: Actions
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func btChangeCard(_ sender: UIButton) {
        onCancelButtonTapped()
        self.view.addSubview(self.pickers.cardPickerView)
        self.view.addSubview(pickers.cardToolBar)
     }
 
     @IBAction func monthSwitched(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let selectedMonth = months[index]
          
        guard let cardVM = selectedCardVM else {
            return
        }
        loadStatementTable(cardId: cardVM.cardId, month: selectedMonth.query)
         DispatchQueue.main.async {
          
        
         }
         self.tableView.reloadData()
         
         
         }
      
    
    // MARK: Funcs
    private func loadStatementTable(cardId : String, month: String ){
        REST.loadStatement(cardId: cardId, query: month) { (statements) in
            self.statementVM = StatementListViewModel(statement: statements)
            guard let selected = self.selectedCardVM else {
                return
            }

            DispatchQueue.main.async {
                self.lbUsedLimit.text =  selected.formattedUsed
                self.lbTotalLimit.text =  selected.formattedTotal
                let currentProgress =  selected.balance
                
                self.pvBalance.setProgress(Float(currentProgress), animated: true)
                self.tableView.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow (at: indexPath, at: .top, animated: true)
                self.lbFinalCard.text = "Final \(self.selectedCardVM!.lastDigits)"
            }
        }
    onError: { (erro) in print(erro)
    }
    }
    
    private func fetchData(){
        REST.loadMonths(){
            (months) in
            self.months = months
            var indexForSegment = 0
            
            DispatchQueue.main.async {
                months.forEach { month in
                    self.scMonthSwitch.insertSegment(withTitle: month.monthName, at: indexForSegment, animated: true)
                    indexForSegment += 1
                }
            }
        }
        
       REST.loadUser { (user) in
            self.userVM = UserViewModel(user)
           DispatchQueue.main.async {
               self.btSelectCard.isEnabled = true
               self.selectedCardVM = CardViewModel(user.cards[0])
               
               guard let cardVM = self.selectedCardVM else {
                   return
               }

               self.loadStatementTable(cardId: cardVM.cardId, month: "default")
               
               self.scMonthSwitch.isEnabled = true
               self.btPayBill.isEnabled = true
               
               self.lbFinalCard.text = "Final \(cardVM.lastDigits)"
               self.tableView.reloadData()
           }
        }
    }
}




extension StatementViewController :  StatementScreenProtocol {
    func onCancelButtonTapped() {
        pickers.cardToolBar.removeFromSuperview()
        pickers.cardPickerView.removeFromSuperview()
    }
    
    func onDoneCardButtonTapped(){
        selectedCardVM = CardViewModel(userVM.cards[pickers.cardPickerView.selectedRow(inComponent: 0)])
    
        guard let selectedCardVM = self.selectedCardVM else {
             return
        }
       let lastDigits = selectedCardVM.lastDigits
        let cardId = selectedCardVM.cardId
        
        btSelectCard.titleLabel?.text  = lastDigits
        loadStatementTable(cardId: cardId, month: "default")
 
        
        onCancelButtonTapped()
        
    }
    
    
    
}


