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
    var selectedCard : Card?
    
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()
    
    
    
    @IBOutlet weak var tbStatements: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbUsedLimit: UILabel!
    @IBOutlet weak var lbTotalLimit: UILabel!
    @IBOutlet weak var pvBalance: UIProgressView!
    
    @IBOutlet weak var teste: UITextField!
    @IBOutlet weak var btSelectCard: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
      //  loadStatement(cardId: "")
        
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btChangeCard(_ sender: UIButton) {
         
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        toolBar.frame =   CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50)
        
        let btDone =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (onDoneButtonTapped))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonTapped))
        toolBar.items = [  btCancel,btSpace, btDone ]
        
        self.view.addSubview(pickerView)
        self.view.addSubview(toolBar)
        
    }
    
    @objc func onDoneButtonTapped(){
        
        guard let card = user?.cards else { return print(" erro card")}
        
        selectedCard = card[pickerView.selectedRow(inComponent: 0)]
        
        guard let lastDigits = selectedCard?.lastDigits else { return print(" erro last digits")}
        guard let cardId = selectedCard?.cardId else { return print(" erro last cardId")}
        
        btSelectCard.titleLabel?.text =  "final ...\( lastDigits)"
        loadStatement(cardId: cardId)
        
        
        onCancelButtonTapped()
    }
    
    @objc func onCancelButtonTapped(){
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onCancelButtonTapped()
    }
    
    
    
    
    private func loadStatement(cardId : String){
        
        REST.loadStatement(cardId: cardId) { (statements) in
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



