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
    
    var viewModel: SingleMovieViewModel!
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
    
    convenience init(viewModel: SingleMovieViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(onEditButtonTap))
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.onImageViewTap(_:))))
        
        guard let unwrappedModel = viewModel else {
            //TODO print some message or set some default model with placeholders
            return
        }
        
        let url = unwrappedModel.imageUrl
        
        movieImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.img = image
        })
        
        movieTitle.text = unwrappedModel.title
        year.text = String(unwrappedModel.year)
        //genre.text = unwrappedModel.genre.rawValue
        //director.text = unwrappedModel.director.name + " " + unwrappedModel.director.surname
        movieDescription.text = unwrappedModel.plot
        movieDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        movieDescription.numberOfLines = 0
        movieDescription.preferredMaxLayoutWidth = 500
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let unwrapedModel = viewModel{
            movieDescription.text = unwrapedModel.plot
        }
        //deselecting the edit button from the navigation bar (just color)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @objc func onEditButtonTap(sender: AnyObject) {
        if  let unwrappedModel = viewModel{
            let vc = EditViewController()
            vc.editDelegate = self
            vc.movieDescription = unwrappedModel.plot
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @objc func onImageViewTap(_ sender:AnyObject){
        let vc = ImageDetailViewController(movieImg: self.img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func plotEdited(withText text: String){
        if let unwrappedModel = viewModel{
            unwrappedModel.movie.plot = text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

