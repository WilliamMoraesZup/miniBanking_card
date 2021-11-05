//
//  StatementViewCellTableViewCell.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 27/10/21.
//

import UIKit

class StatementViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCommerceIcon: UIImageView!
    @IBOutlet weak var lbCommerceName: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
// 
}
