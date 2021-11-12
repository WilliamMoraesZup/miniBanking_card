//
//  PayBillViewController.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 10/11/21.
//

import UIKit

class PayBillViewController: UIViewController {

    @IBOutlet weak var lbCardNumber: UILabel!
    @IBOutlet weak var lbBillSituation: UILabel!
    @IBOutlet weak var lbDebtAmount: UILabel!
    @IBOutlet weak var lbCardFinalNumber: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    @IBOutlet weak var lbNextExpiration: UILabel!
    @IBOutlet weak var lbMinimumPayment: UILabel!
    @IBOutlet weak var btChargeInvoice: UIButton!
    @IBOutlet weak var btInstallments: UIButton!
    
    var cardId : String?
    var cardSituationVM : CardSituationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let cardId = cardId else {
            return
        }
        
        REST.loadCardSituation(cardId: cardId) { (cardSituation) in
            self.cardSituationVM = CardSituationViewModel(cardSituationVM: cardSituation)
            
            DispatchQueue.main.async {
                self.lbDebtAmount.text = self.cardSituationVM.debtAmountFormatted
                self.lbMinimumPayment.text = self.cardSituationVM.minimumPaymentFormatted
                self.lbCardNumber.text = self.cardSituationVM.cardNumberFormated
                self.lbCardFinalNumber.text = self.cardSituationVM.cardFinalNumberFormatted
                self.lbExpireDate.text = self.cardSituationVM.expireDateFormated
                self.lbNextExpiration.text = self.cardSituationVM.nextExpirationFormated
                self.lbBillSituation.text = self.cardSituationVM.billSituationFormatted.name
                self.lbBillSituation.textColor = self.cardSituationVM.billSituationFormatted.color
                
            }
        } onError: { (erro) in
            print(erro)
        }   }
    }
 


