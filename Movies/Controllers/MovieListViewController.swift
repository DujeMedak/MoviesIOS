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
    let apiKey = bf90cf2e
    let requestTemplate = "http://www.omdbapi.com/?apikey=[yourkey]&"
    let temp = "http://www.omdbapi.com/?t=inception&y=&plot=short&r=json&apikey=bf90cf2e"
    let temp = "http://www.omdbapi.com/?s=batman&apikey=bf90cf2e"
    
    var refreshControl: UIRefreshControl!
    //var tableFooterView: ReviewsTableViewFooterView!
    
    //var viewModel: ReviewsViewModel!
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    convenience init(viewModel: ReviewsViewModel) {
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
        refreshControl.addTarget(self, action: #selector(ReviewsListViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        tableFooterView = ReviewsTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
        tableFooterView.delegate = self
        tableView.tableFooterView = tableFooterView
    }
    
    func setupData() {
        viewModel.fetchReviews { [weak self] (reviews) in
            self?.refresh()
        }
    }
    
    func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ReviewsTableSectionHeader()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let review = viewModel.review(atIndex: indexPath.row) {
            let singleReviewViewModel = SingleReviewViewModel(review: review)
            let singleReviewViewController = SingleReviewViewController(viewModel: singleReviewViewModel)
            navigationController?.pushViewController(singleReviewViewController, animated: true)
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ReviewsTableViewCell
        
        if let review = viewModel.review(atIndex: indexPath.row) {
            cell.setup(withReview: review)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfReviews()
    }
}

extension MovieListViewController: TableViewFooterViewDelegate {
    func reviewCreated(withText title: String, date: String, summary: String) {
        viewModel.createReview(withText: title, date: date, summary: summary)
        refresh()
    }
}

