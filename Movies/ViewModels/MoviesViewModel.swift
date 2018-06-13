//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import CoreData
import AERecord


protocol MoviesViewModelType {
    var movies: [MovieModel]? {get}
    weak var viewDelegate: MovieListDelegate? {get set }
}

class MoviesViewModel: MoviesViewModelType {
    let baseUrl2 = "http://www.omdbapi.com"
    let apiKey2 = "bf90cf2e"
    let restAPI: RestAPI
    let search: String
    
    weak var viewDelegate: MovieListDelegate?
    
    var movies : [MovieModel]? = nil {
        didSet{
            if movies != nil{
                viewDelegate?.movieListDidChanged(success: true)
            }
            else {
                viewDelegate?.movieListDidChanged(success: false)
            }
        }
    }
    
    init(service: RestAPI, title:String) {
        self.restAPI = service
        self.search = title
    }
    
    func fetchMovies(){
        restAPI.fetchMovieModelList(search:self.search, completion:{ [weak self] (movies) in
            self?.movies = movies
        })
    }
    
    func getMovie(at index: Int) -> MovieModel? {
        return movies?[index]
    }
    
    func numberOfMovies() -> Int {
        return movies?.count ?? 0
    }
    
    func didSelectRow(at index: Int) {
        if let movie = movies?[index]{
            self.viewDelegate?.loadMovieDetails(movie:movie)
        }
    }
}

