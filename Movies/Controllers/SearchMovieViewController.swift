//
//  SearchMovieViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var button_search: UIButton!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchText.delegate = self as UITextFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchText.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSearchButtonTapped(_: Any) {
        fetchAndLoadNewView()
    }
    
    func fetchAndLoadNewView(){
        if let search = searchText.text{
            let vm = MoviesViewModel()
            let sv = SearchMovieViewController.displaySpinner(onView: self.view)
            vm.fetchMovies(search:search, completion: { [weak self] (movies) in
                vm.movies = movies
                let vc = MovieListViewController(viewModel: vm)
                SearchMovieViewController.removeSpinner(spinner: sv)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        fetchAndLoadNewView()
    }
    
}

extension SearchMovieViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
