//
//  WindowRegister.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 22/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit
protocol WindowRegisterDelegate {
    func closeRegisterView()
}
class WindowRegister: UIView {
    
    var delegate : WindowRegisterDelegate?
   
    @IBAction func closeBtn(_ sender: Any) {
        delegate?.closeRegisterView()
    }
}
