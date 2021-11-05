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
    
    // MARK: Variables
    var statements  : [Statement]  = []
    var user : UserFinancial?
    var selectedCard : Card?
    var months : [Months] = []
    var pickers : ViewPickers = ViewPickers()
    
    var resourceStatement : [Statement] = []
    
    // MARK: Outlets
    @IBOutlet weak var tbStatements: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbUsedLimit: UILabel!
    @IBOutlet weak var lbTotalLimit: UILabel!
    @IBOutlet weak var pvBalance: UIProgressView!
    @IBOutlet weak var teste: UITextField!
    @IBOutlet weak var btSelectCard: UIButton!
    
    @IBOutlet weak var btMonth: UIButton!
    
    // MARK: MVVM
    var viewModel = StatementsViewModel()
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems(); loadUsers(); loadMonths()
    }
    
    override func viewDidLoad() {
        configureView()
    }
   
    // MARK: MVVM
    func configureView(){
         viewModel.retrieveStatement(cardId: "1212221", month: "nov")
         viewModel.retrieveMonths()
         viewModel.retrieveUser()

         bind()
        btSelectCard.isEnabled = true
           btMonth.isEnabled = true
    }
   
    // MARK: MVVM
    func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
             
            }
            
        }
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
    
    @IBAction func btChangeMonth(_ sender: UIButton) {
        onCancelButtonTapped()
        self.view.addSubview(self.pickers.monthPickerView)
        self.view.addSubview(pickers.monthToolBar)
        
    }
     // MARK: Funcs
     private func loadMonths(){
        REST.loadMonths(){
            (months) in
            self.months = months
            
        }
    }
    
    private func loadStatement(cardId : String, month: String ){
        REST.loadStatement(cardId: cardId, query: month) { (statements) in
            self.statements = statements
            DispatchQueue.main.async {
                
                guard let unwrap = self.selectedCard else {
                    return
                }
                self.lbUsedLimit.text = unwrap.usedLimit.formatedNumberValue()
                self.lbTotalLimit.text = unwrap.totalLimit.formatedNumberValue()
                
                let currentProgress = Float(unwrap.usedLimit / unwrap.totalLimit)
                
                self.pvBalance.setProgress(Float(currentProgress), animated: true)
                self.tableView.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow (at: indexPath, at: .top, animated: true)
            }
        }
    onError: { (erro) in print(erro)
    }
    }
    
    private func loadUsers(){
        REST.loadUser { (user) in
            self.user = user
            DispatchQueue.main.async {
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
        
        guard let card = user?.cards else { return print(" erro card")}
        
        selectedCard = card[pickers.cardPickerView.selectedRow(inComponent: 0)]
        
        guard let lastDigits = selectedCard?.lastDigits else {  return print("erro last digits")}
        guard let cardId = selectedCard?.cardId else { return print("erro last cardId")}
        
        btSelectCard.titleLabel?.text =  "final ...\( lastDigits)"
        loadStatement(cardId: cardId, month: "default")
        loadMonths()
        
        onCancelButtonTapped()
    }
    
    
    func onMonthDoneButtonTapped(){
        
        let selectedMonth = months[self.pickers.monthPickerView.selectedRow(inComponent: 0)]
        
        guard let cardId = selectedCard?.cardId else {
            return
        }
        
        btMonth.titleLabel?.text = selectedMonth.monthName
        loadStatement(cardId: cardId, month: selectedMonth.query)
        
        onCancelButtonTapped()
        
    }
}
 
