//
//  SearchMovieViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var button_search: UIButton!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchText.delegate = self as UITextFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchText.text = ""
    }
    
    @IBAction func onSearchButtonTapped(_: Any) {
        loadNewView()
    }
    
    func loadNewView(){
        if let search = searchText.text{
            let vm = MoviesViewModel(service: CombinedMovieAPI(), title: search)
            let vc = MovieListViewController(viewModel: vm)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        loadNewView()
        return true
    }
}

