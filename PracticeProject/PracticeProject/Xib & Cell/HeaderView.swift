//
//  HeaderView.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 20/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

protocol PopToPreviousDelegate {
    func popUsingDelegate()
    func showMenu()
    func closeMenu()
}

protocol HeaderViewDelegate {
    func sample()
    //func closeMenu()
}

protocol HeaderLoginBtnDelegate {
    func openLoginView()
    func closeLoginView()
    func openRegisterView()
    func closeRegisterView()
}

class HeaderView: UIView {
    
    var  delegate : PopToPreviousDelegate?
    var headerViewDelegate : HeaderViewDelegate?
    var headerLoginViewDelegate : HeaderLoginBtnDelegate?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mylabel: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(headerView)
        headerView.frame = self.bounds
        headerView.autoresizingMask = [.flexibleHeight, .flexibleWidth ]
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        delegate?.popUsingDelegate()
        print("back btn pressed")
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        headerLoginViewDelegate?.openLoginView()
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        headerLoginViewDelegate?.openRegisterView()
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        if AppDelegate.menu_bool{ delegate?.showMenu() } else { delegate?.closeMenu() }
    }
}
