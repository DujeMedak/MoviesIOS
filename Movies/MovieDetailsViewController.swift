//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import Kingfisher
import PureLayout


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
    
    func setConstrains(){
        //imageView Constrains done in interface builder
        movieTitle.autoPinEdge(.top, to: ALEdge.bottom, of: movieImage)
        movieTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        
        yearTxt.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        genreTxt.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        directorTxt.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        movieDescription.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        
        yearTxt.autoPinEdge(.top, to: ALEdge.bottom, of: movieTitle)
        genreTxt.autoPinEdge(.top, to: ALEdge.bottom, of: yearTxt)
        directorTxt.autoPinEdge(.top, to: ALEdge.bottom, of: genreTxt)
        movieDescription.autoPinEdge(.top, to: ALEdge.bottom, of: directorTxt)
        
        year.autoPinEdge(.top, to: ALEdge.bottom, of: movieTitle)
        genre.autoPinEdge(.top, to: ALEdge.bottom, of: year)
        director.autoPinEdge(.top, to: ALEdge.bottom, of: genre)
        movieDescription.autoPinEdge(.top, to: ALEdge.bottom, of: director)
        
        
        year.autoAlignAxis(.baseline, toSameAxisOf: yearTxt)
        genre.autoAlignAxis(.baseline, toSameAxisOf: genreTxt)
        director.autoAlignAxis(.baseline, toSameAxisOf: directorTxt)
        
        year.autoAlignAxis(toSuperviewAxis: .vertical)
        genre.autoAlignAxis(toSuperviewAxis: .vertical)
        director.autoAlignAxis(toSuperviewAxis: .vertical)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(onEditButtonTap))
        
         setConstrains()
        
        
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.onImageViewTap(_:))))
        
        let url = URL(string: model!.imageURI)
        
        movieImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            //is this part executed if the image is cached??
            self.img = image
         })
        
        movieTitle.text = model!.title
        
        year.text = String(model!.year)
        genre.text = model!.genre.rawValue
        director.text = model!.director.name + " " + model!.director.surname
        movieDescription.text = model!.description
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        movieDescription.text = model!.description
        //deselecting the edit button from the navigation bar (just color)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @objc func onEditButtonTap(sender: AnyObject) {
        
        let vc = EditViewController(editDelegate: self as EditViewControllerDelegate, textToEdit:model!.description)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onImageViewTap(_ sender:AnyObject){
        let vc = ImageDetailViewController(movieImg: self.img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func plotEdited(withText text: String){
        model?.description = text
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

