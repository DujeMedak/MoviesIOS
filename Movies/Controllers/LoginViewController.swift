//
//  LoginViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // constraints for horizontal movement animations
    @IBOutlet weak var usernameTextFieldConstraintX: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldConstraintX: NSLayoutConstraint!
    @IBOutlet weak var loginButtonConstraintX: NSLayoutConstraint!
    
    // constraints for vertical movement animations
    var usernameTextFieldVerticalSpacing2, passwordTextFieldVerticalSpacing2, loginButtonVerticalSpacing2: NSLayoutConstraint?
    
    @IBOutlet weak var appTitleVerticalSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameTextFieldVerticalSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldVerticalSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonVerticalSpacing: NSLayoutConstraint!
    
    var offsetX = CGFloat(200)
    var offsetY = CGFloat(200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offsetX = view.bounds.width
        // remove views from screen (for entry animation)
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
    func animateExit(){
        usernameTextFieldVerticalSpacing2 = usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor)
        usernameTextFieldVerticalSpacing2?.constant = usernameTextField.frame.minY - view.safeAreaInsets.top
        
        passwordTextFieldVerticalSpacing2 = passwordTextField.topAnchor.constraint(equalTo: self.view.topAnchor)
        passwordTextFieldVerticalSpacing2?.constant = passwordTextField.frame.minY - view.safeAreaInsets.top
        
        loginButtonVerticalSpacing2 = loginButton.topAnchor.constraint(equalTo: self.view.topAnchor)
        loginButtonVerticalSpacing2?.constant = loginButton.frame.minY - view.safeAreaInsets.top
        
        self.usernameTextFieldVerticalSpacing.isActive = false
        self.usernameTextFieldVerticalSpacing2?.isActive = true
        self.passwordTextFieldVerticalSpacing.isActive = false
        self.passwordTextFieldVerticalSpacing2?.isActive = true
        self.loginButtonVerticalSpacing.isActive = false
        self.loginButtonVerticalSpacing2?.isActive = true
        
        UIView.animate(withDuration: 0.9, delay: 0, options: .curveEaseOut, animations: {
            self.appTitleVerticalSpacing.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.8, delay: 0.05, options: .curveEaseOut, animations: {
            self.usernameTextFieldVerticalSpacing2?.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations: {
            self.passwordTextFieldVerticalSpacing2?.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.15, options: .curveEaseOut, animations: {
            self.loginButtonVerticalSpacing2?.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            let vc = SearchMovieViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        })
    }
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        animateExit()
    }
}
