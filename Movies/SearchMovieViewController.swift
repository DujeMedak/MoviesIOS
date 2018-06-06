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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSearchButtonTapped(_: Any) {
        searchAndLoadMovie()
    }
    
    func searchAndLoadMovie(){
        //TODO add fail message
        let REST:RestAPI = RestMock()
        if let search = searchText.text, let model = REST.getMovie(title: search){
            let vc = MovieDetailsViewController()
            vc.model = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            //print "no results"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        searchAndLoadMovie()
    }
    
}
