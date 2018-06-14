//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import Kingfisher


protocol MovieDetailsDelegate:NSObjectProtocol {
    func searchResultsDidChanged()
    func moviePlotChanged()
}

class MovieDetailsViewController: UIViewController{
    
    var viewModel: SingleMovieViewModel!
    var img: UIImage?
    var spinnerView: UIView?
    
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
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(onEditButtonTap))
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.onImageViewTap(_:))))
        
        movieDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        movieDescription.numberOfLines = 0
        setupData()
    }
    
    func setupData(){
        spinnerView = MovieDetailsViewController.displaySpinner(onView: self.view)
        viewModel.fetchMovieDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //deselecting the edit button from the navigation bar (just color)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @objc func onEditButtonTap(sender: AnyObject) {
        if  let unwrappedModel = viewModel{
            let vc = EditViewController()
            vc.editDelegate = viewModel
            vc.movieDescription = unwrappedModel.plot
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func onImageViewTap(_ sender:AnyObject){
        let vc = ImageDetailViewController(movieImg: self.img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieDetailsViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.center = spinnerView.center
        ai.startAnimating()
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            spinnerView.center = onView.convert(onView.center, from:onView.superview)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension MovieDetailsViewController: MovieDetailsDelegate{
    func searchResultsDidChanged() {
        movieTitle.text = viewModel.title
        year.text = viewModel.year
        genre.text = viewModel.genre
        director.text = viewModel.director
        movieDescription.text = viewModel.plot
        if let sv = spinnerView {
            MovieListViewController.removeSpinner(spinner: sv)
        }
        
        spinnerView = MovieDetailsViewController.displaySpinner(onView: movieImage)
        let url = viewModel.imageUrl
        movieImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.img = image
            if let sv = self.spinnerView {
                MovieListViewController.removeSpinner(spinner: sv)
            }
        })
    }
    func moviePlotChanged(){
        movieDescription.text = viewModel.plot
        
    }
}
