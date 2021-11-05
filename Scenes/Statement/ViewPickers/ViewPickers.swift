//
//  CardPickerView.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 04/11/21.
//

import Foundation

protocol StatementScreenProtocol : AnyObject {
    func onCancelButtonTapped()
    func onMonthDoneButtonTapped()
    func onDoneCardButtonTapped()
}

class ViewPickers : UIView {
    
    
    weak private var delegate : StatementScreenProtocol?
    
    
    func delegate(delegate: StatementScreenProtocol){
 
        self.delegate = delegate
    }
    
    
    lazy var cardPickerView : UIPickerView = {
        var picker = UIPickerView()
        picker.backgroundColor = .white
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        picker.layer.cornerRadius = 10
        
        return picker
    }()
    
    
    lazy var monthPickerView : UIPickerView = {
        var picker = UIPickerView()
        picker.backgroundColor = .white
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        picker.layer.cornerRadius = 10
        
        return picker
    }()
    
    
    lazy var toolBar : UIToolbar = {
        var tool = UIToolbar()
        tool.layer.cornerRadius = 10
        tool.layer.masksToBounds = true
        tool.frame =   CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50)
        return tool
    }()
    
    lazy var monthToolBar : UIToolbar = {
        var tool = UIToolbar()
        tool.layer.cornerRadius = 10
        tool.layer.masksToBounds = true
        tool.frame =   CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(  self.onMonthDoneButtonTapped))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.onCancelButtonTapped ))
        tool.items = [  btCancel,btSpace ,  btDone]
        
        
        return tool
    }()
    lazy var cardToolBar : UIToolbar = {
        var tool = UIToolbar()
        tool.layer.cornerRadius = 10
        tool.layer.masksToBounds = true
        tool.frame =   CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50)
        
        let btDone =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (self.onDoneCardButtonTapped))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.onCancelButtonTapped))
        
        tool.items = [btCancel,btSpace, btDone ]
        return tool
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubview(){
        self.addSubview(cardPickerView)
        self.addSubview(monthPickerView)
    }
    
    @objc func onCancelButtonTapped(){
        delegate?.onCancelButtonTapped()
    }
    
    @objc func onDoneCardButtonTapped(){
        delegate?.onDoneCardButtonTapped()
    }
    @objc func onMonthDoneButtonTapped(){
        delegate?.onMonthDoneButtonTapped()
    }
    
}
 
