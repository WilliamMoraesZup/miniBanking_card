//
//  StatementDetailViewController.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 07/11/21.
//

import UIKit

class StatementDetailViewController: UIViewController {

    
    var storeVM : StoreViewModel!
    
    @IBOutlet weak var lbStoreName: UILabel!
    @IBOutlet weak var lbStoreID: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbHours: UILabel!
    @IBOutlet weak var lbPaymentMethod: UILabel!
    
    @IBOutlet weak var btContest: UIButton!
   
    
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbStoreName.text = storeVM.storeName
        lbAmount.text = storeVM.amountSpentFormatted
        
        
        
    }
    

}
