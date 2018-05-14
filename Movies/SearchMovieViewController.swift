//
//  SearchMovieViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var button_search: UIButton!
    
    @IBOutlet weak var searchText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSearchButtonTapped(_: Any) {
        //TODO exceptions handling
        
        let search = searchText.text
        let REST = RestMock() as RestAPI
        let model = REST.getMovie(title: search!)
        
    
        let vc = MovieDetailsViewController(model:model)
        self.navigationController?.pushViewController(vc, animated: true)
 
 }
    
}
