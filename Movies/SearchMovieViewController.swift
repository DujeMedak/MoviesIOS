//
//  SearchMovieViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import PureLayout

class SearchMovieViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var button_search: UIButton!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.autoAlignAxis(toSuperviewAxis: .vertical)
        searchText.autoSetDimensions(to: CGSize(width: 150, height: 30))
        searchText.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        button_search.autoAlignAxis(toSuperviewAxis: .vertical)
        button_search.autoPinEdge(.top, to:ALEdge.bottom, of: searchText, withOffset: 20)
        
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
        let REST = RestMock() as RestAPI
        if let search = searchText.text {
            if let model = REST.getMovie(title: search){
                let vc = MovieDetailsViewController(model:model)
                self.navigationController?.pushViewController(vc, animated: true)
            }
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
