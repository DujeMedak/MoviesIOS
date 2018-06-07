//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import Kingfisher

protocol EditViewControllerDelegate:NSObjectProtocol{
    func plotEdited(withText text: String)
    
}

class MovieDetailsViewController: UIViewController , EditViewControllerDelegate{

    var model:Movie?
    var img: UIImage?
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var yearTxt: UILabel!
    @IBOutlet weak var genreTxt: UILabel!
    @IBOutlet weak var directorTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(onEditButtonTap))
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.onImageViewTap(_:))))
        
        guard let unwrappedModel = model else {
            //TODO print some message or set some default model with placeholders
            return
        }
        
        let url = URL(string: unwrappedModel.imageURI)
        
        movieImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.img = image
         })
        
        movieTitle.text = unwrappedModel.title
        year.text = String(unwrappedModel.year)
        genre.text = unwrappedModel.genre.rawValue
        director.text = unwrappedModel.director.name + " " + unwrappedModel.director.surname
        movieDescription.text = unwrappedModel.description
        movieDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        movieDescription.numberOfLines = 0
        movieDescription.preferredMaxLayoutWidth = 500
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let unwrapedModel = model{
            movieDescription.text = unwrapedModel.description
        }
        else{
            movieDescription.text = "Some default description..."
        }
        //deselecting the edit button from the navigation bar (just color)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @objc func onEditButtonTap(sender: AnyObject) {
        guard let unwrappedModel = model else{
            let vc = EditViewController()
            vc.editDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        let vc = EditViewController()
        vc.editDelegate = self
        vc.movieDescription = unwrappedModel.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onImageViewTap(_ sender:AnyObject){
        let vc = ImageDetailViewController(movieImg: self.img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func plotEdited(withText text: String){
        if let unwrappedModel = model{
            unwrappedModel.description = text
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

