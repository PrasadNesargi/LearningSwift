//
//  RegisterView.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 22/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit
protocol LoginViewDelegate {
    func closeLoginView()
}

class LoginView: UIView {

   var delegate : LoginViewDelegate?

    @IBAction func viewButtonClose(_ sender: Any) {
        delegate?.closeLoginView()
    }
}
