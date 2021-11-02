//
//  StatementViewControllerExtensions.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 02/11/21.
//


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
        cell.lbValue.text =  toShow.amountSpent.formatedNumberValue()
        cell.ivCommerceIcon.image = toShow.setIcon
        
        return cell
     }
     
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = statements[section]
         return title.date
    }
 

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") as!
        FooterTableCell

        let total = statements[section].dayStatements .reduce(0, { runningSum,
            value in
            runningSum + value.amountSpent
        })
        cell.lbSum .text = total.formatedNumberValue()
 
         
        return cell
    }

}


extension StatementViewController : UIPickerViewDelegate {}

extension StatementViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let cardsCount = user?.cards.count else { exit(0) }
        return cardsCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let digits =    user?.cards[row].lastDigits  else { exit(0) }
         
        return "...\(digits)"
        
    }
}
