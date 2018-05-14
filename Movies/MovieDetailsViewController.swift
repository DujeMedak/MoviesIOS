//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController , EditViewControllerDelegate{

    var model:Movie?
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(onEditButtonTap))
        
        
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.onImageViewTap(_:))))
        
         year.text = String(model!.year)
         genre.text = model!.genre.rawValue
         director.text = model!.director.name + " " + model!.director.surname
         movieDescription.text = model!.description
         movieTitle.text = model!.title
         let mImage: UIImage = UIImage(named: model!.imageURI)!
         movieImage.image = mImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @objc func onEditButtonTap(sender: AnyObject) {
        
        let vc = EditDescriptionViewController(editDelegate: self as EditViewControllerDelegate)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onImageViewTap(_ sender:AnyObject){
        let vc = ImageDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func plotEdited(withText text: String){
        //TODO change text
    }
    
}

