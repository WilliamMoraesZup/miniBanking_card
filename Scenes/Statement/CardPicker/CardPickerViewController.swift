//
//  CardPickerViewController.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 02/11/21.
//

import UIKit
import miniBanking_core


class CardPickerViewController:  ViewController,
                                 StatementDisplayerProtocol  {

private var businessHandler: StatementDisplayerProtocol?

func setup(businessHandler: StatementDisplayerProtocol) {
    self.businessHandler = businessHandler
}
 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
