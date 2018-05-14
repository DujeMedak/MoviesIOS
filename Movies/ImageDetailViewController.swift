//
//  ImageDetailViewController.swift
//  Movies
//
//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        
        scrollView.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return movieImage
    }


}
/*
extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return movieImage
    }
}*/
