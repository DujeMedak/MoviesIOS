//
//  LoginViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func animateEntry(){}
    func animateExit(){}
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        //TODO pokreni animacije i na kraju pozovi
        animateExit()
        let vc = SearchMovieViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
