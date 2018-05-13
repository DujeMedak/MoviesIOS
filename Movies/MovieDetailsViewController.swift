//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var model:Movie?
    
    
     convenience init() {
     self.init(model: nil)
     }
     
     init(model: Movie?) {
     self.model = model
     super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         year.text = String(model!.year)
         genre.text = model!.genre.rawValue
         director.text = model!.director.name + " " + model!.director.surname
         */
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
