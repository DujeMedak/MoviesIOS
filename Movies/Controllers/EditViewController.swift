//
//  EditViewController.swift
//  Movies
//
//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    weak var editDelegate:EditMoviePlotDelegate?
    @IBOutlet weak var movieDescriptionView: UITextView!
    var movieDescription:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDescriptionView.text = movieDescription
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        editDelegate?.saveEdited(plot: movieDescriptionView.text)
    }
}

