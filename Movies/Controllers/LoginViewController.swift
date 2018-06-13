//
//  LoginViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextFieldConstraintX: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldConstraintX: NSLayoutConstraint!
    @IBOutlet weak var loginButtonConstraintX: NSLayoutConstraint!
    
    var offsetX = CGFloat(200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offsetX = view.bounds.width
        usernameTextFieldConstraintX.constant -= offsetX
        passwordTextFieldConstraintX.constant -= offsetX
        loginButtonConstraintX.constant -= offsetX
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntry()
    }
    
    func animateEntry(){
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
            self.usernameTextFieldConstraintX.constant += self.offsetX
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseOut, animations: {
            self.passwordTextFieldConstraintX.constant += self.offsetX
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.35, options: .curveEaseOut, animations: {
            self.loginButtonConstraintX.constant += self.offsetX
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func animateExit(){}
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        //TODO pokreni animacije i na kraju pozovi
        animateExit()
        let vc = SearchMovieViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
