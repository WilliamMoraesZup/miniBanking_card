//
//  StatementViewControllerExtensions.swift
//  miniBanking_card
//
//  Created by William Moraes da Silva on 02/11/21.
//

import Foundation



extension StatementViewController : UITableViewDelegate {}
extension StatementViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return self.statementVM == nil ? 0 : self.statementVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "statementCell", for: indexPath)
        as! StatementViewCell
        
        let stat = self.statementVM.statement[indexPath.section]
        
        let statementVM = stat.dayStatements[indexPath.row]
         
        cell.lbCommerceName.text = statementVM.commerceName
        cell.lbValue.text =  statementVM.amountSpent.formatedNumberValue()
        cell.ivCommerceIcon.image = statementVM.setIcon
        
        return cell
     }
     
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return self.statementVM.statement[section].date
    }
 

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") as!
        StatementFooterViewCell
         
        
        let total = self.statementVM.statement[section].dayStatements .reduce(0, { runningSum,
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let vc = storyboard?.instantiateViewController(withIdentifier: "statementDetails") as! StatementDetailViewController
        
        let statVM = StoreViewModel(statementVM.statement[indexPath.section].dayStatements[indexPath.row])
     
        vc.storeVM = statVM
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     
        if pickerView == pickers.cardPickerView {
        guard let cardsCount = userVM?.cards.count else {
            print("erro picker view")
            exit(0) }
            return cardsCount
            
        }
        else{ 
            return months.count
         }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  
        if pickerView == pickers.cardPickerView  {
            guard let digits = userVM?.cards[row].lastDigits  else { print("erro last digits  picker view")
                exit(0)}
            return "...\(digits)" }
        else  {
             
           return  months[row].monthName
            }
            
        }
         
}
