//
//  MovieListViewController.swift
//  Movies
//
//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var tableFooterView: MoviesTableViewFooter!
    var viewModel: MoviesViewModel!
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    convenience init(viewModel: MoviesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MovieListViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupData() {
        /*viewModel.fetchMovies{ [weak self] (movies) in
         self?.refresh()
         }*/
        self.refresh()
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MoviesTableSectionHeader()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func fetchAndLoadNewView(movieID: String) {
        let sv = MovieDetailsViewController.displaySpinner(onView: self.view)
        self.viewModel.fetchMovieDetails(movieID: movieID, completion: { [weak self] (movie) in
            if let fetchedMovie = movie{
                let smvm = SingleMovieViewModel(movie:fetchedMovie)
                let vc = MovieDetailsViewController(viewModel: smvm)
                MovieDetailsViewController.removeSpinner(spinner: sv)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = viewModel.getMovieAtIndex(atIndex: indexPath.row){
            fetchAndLoadNewView(movieID: movie.id)
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MovieTableViewCell
        
        if let movie = viewModel.getMovieAtIndex(atIndex: indexPath.row) {
            cell.setup(withMovie: movie)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
}

extension MovieDetailsViewController {
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

