//
//  SingleMovieViewModel.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

protocol SingleMovieViewModelType {
    var movie: MovieModel {get}
    weak var viewDelegate: MovieDetailsDelegate? {get set}
}

class SingleMovieViewModel: SingleMovieViewModelType{
    var movie: MovieModel
    let restAPI: RestAPI
    
    weak var viewDelegate: MovieDetailsDelegate?
    
    init(service: RestAPI, movie: MovieModel) {
        self.restAPI = service
        self.movie = movie
    }
    
    var title: String {
        return movie.title.uppercased()
    }
    
    var year: String {
        return movie.year
    }
    
    var plot: String{
        if let plot = movie.plot{
            return plot + "\n"
        }
        return "Plot is not available for this movie...\n"
    }
    
    var genre: String? {
        return movie.genre?.uppercased()
    }
    
    var director: String? {
        return movie.director?.uppercased()
    }
    
    var imageUrl: URL? {
        return URL(string: movie.poster)
    }
    
    func fetchMovieDetails(){
        restAPI.fetchMovieModel(movieID: movie.id, completion:{ [weak self] (movie) in
            if let newMovie = movie{
                self?.movie = newMovie
                self?.viewDelegate?.searchResultsDidChanged()
            }
            //self?.viewDelegate?.searchResultsDidChanged()
        })
    }
    
    public func saveNewPlot(newPlot:String) -> MovieModel?{
        return MovieModel.updatePlot(movieID: movie.id, newPlot: newPlot)
    }
 
}

