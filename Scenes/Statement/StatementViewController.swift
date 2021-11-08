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
    @IBOutlet weak var tbStatements: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbUsedLimit: UILabel!
    @IBOutlet weak var lbTotalLimit: UILabel!
    @IBOutlet weak var pvBalance: UIProgressView!
    @IBOutlet weak var btSelectCard: UIButton!
    @IBOutlet weak var btMonth: UIButton!
    @IBOutlet weak var scMonthSwitch: UISegmentedControl!
    
    
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scMonthSwitch.removeAllSegments()
        loadItems(); fetchData()
      
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onCancelButtonTapped()
    }
    
    func loadItems(){
        pickers.delegate(delegate: self)
      
        self.pickers.cardPickerView.dataSource = self
        self.pickers.cardPickerView.delegate = self
        self.pickers.monthPickerView.delegate = self
        self.pickers.monthPickerView.dataSource = self
        
        
        
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
    
//    @IBAction func btChangeMonth(_ sender: UIButton) {
//        onCancelButtonTapped()
//        self.view.addSubview(self.pickers.monthPickerView)
//        self.view.addSubview(self.pickers.monthToolBar)
//    }
//
    
    @IBAction func monthSwitched(_ sender: UISegmentedControl) {
        print("asdas")
        let index = sender.selectedSegmentIndex
        
        let selectedMonth = months[index]
         
//        switch index {
//        case 0: month = "sep"
//        case 1: month = "oct"
//        case 2: month = "nov"
//        default: month = "default"
//        }
        guard let cardVM = selectedCardVM else {
            return
        }
      
 
        loadStatementTable(cardId: cardVM.cardId, month: selectedMonth.query)
       
        print(selectedMonth)
        tableView.reloadData()
        
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
           }
        }
    }
}

extension StatementViewController :  StatementScreenProtocol {
    func onCancelButtonTapped() {
        pickers.monthToolBar.removeFromSuperview()
        pickers.cardToolBar.removeFromSuperview()
        pickers.monthPickerView.removeFromSuperview()
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
    
    
    func onMonthDoneButtonTapped(){
        
        let selectedMonth = months[self.pickers.monthPickerView.selectedRow(inComponent: 0)]
        
        guard let selectedCardVM = self.selectedCardVM else {
             return
        }
        
        let cardId = selectedCardVM.cardId
        btMonth.titleLabel?.text = selectedMonth.monthName
        loadStatementTable(cardId: cardId, month: selectedMonth.query)
        onCancelButtonTapped()
        
    }
    
    
}


