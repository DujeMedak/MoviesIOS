//
//  EditViewController.swift
//  Movies
//
//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var editDelegate:EditViewControllerDelegate?
    
    @IBOutlet weak var movieDescriptionView: UITextView!
    
    var movieDescription:String? = ""
    
    
    convenience init() {
        self.init(editDelegate: nil,textToEdit:nil)
    }
    
    init(editDelegate: EditViewControllerDelegate?, textToEdit:String?) {
        self.editDelegate = editDelegate
        self.movieDescription = textToEdit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDescriptionView.text = movieDescription
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        editDelegate?.plotEdited(withText: movieDescriptionView.text)
    }
    
}

