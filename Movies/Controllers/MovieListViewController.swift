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
    
    //let apiKey = "bf90cf2e"
    let requestTemplate = "http://www.omdbapi.com/?apikey=[yourkey]&"
    let temp = "http://www.omdbapi.com/?t=inception&y=&plot=short&r=json&apikey=bf90cf2e"
    let temp2 = "http://www.omdbapi.com/?s=batman&apikey=bf90cf2e"
    
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
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MovieListViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        tableFooterView = MoviesTableViewFooter(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
        tableFooterView.delegate = self
        tableView.tableFooterView = tableFooterView
    }
    
    func setupData() {
        viewModel.fetchMovies{ [weak self] (movies) in
            self?.refresh()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /*//TODO change this part later
        if let review = viewModel.review(atIndex: indexPath.row) {
            let singleReviewViewModel = SingleMovieViewModel(movie: review)
         
            //let singleReviewViewController = MovieDetailsViewController(viewModel: singleReviewViewModel)
            //navigationController?.pushViewController(singleReviewViewController, animated: true)
        }
        */
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

extension MovieListViewController: TableViewFooterViewDelegate {

    func movieCreated(withText title: String) {
        viewModel.createMovie(withText: title)
        refresh()
    }
}

