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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSearchButtonTapped(_: Any) {
        //TODO kroz konstruktor posalji model kontroleru
      
        //let vc = EditViewController()
        //self.navigationController?.pushViewController(vc, animated: true)
        
        
        let REST = RestMock()
        let model = REST.getMovie(title: "Inception")
        
    
        let vc = MovieDetailsViewController(model:model)
        self.navigationController?.pushViewController(vc, animated: true)
 
 }
    
}
