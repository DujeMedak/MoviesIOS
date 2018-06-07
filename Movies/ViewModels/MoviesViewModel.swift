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

class MoviesViewModel {
    //let temp = "http://www.omdbapi.com/?t=inception&y=&plot=short&r=json&apikey=bf90cf2e"
    var search = "batman"
    
    let baseUrl2 = "http://www.omdbapi.com"
    let apiKey2 = "bf90cf2e"
    let restAPI: RestAPI
    
    var movies: [MovieModel]? {
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = AERecord.Context.main
        let movie = try? context.fetch(request)
        return movie
    }
    
    init() {
        restAPI = OmdbAPI()
    }
    
    func fetchMovies(completion: @escaping (([MovieModel]?) -> Void)) -> Void {
        restAPI.fetchMovieModelList(search: search, completion: completion)
    }
    
    func getMovieAtIndex(atIndex index: Int) -> MovieModel? {
        guard let movies = movies else {
            return nil
        }
        return movies[index]
    }
    
    func numberOfMovies() -> Int {
        return movies?.count ?? 0
    }
    
    func createMovie(withText title: String, year: String, poster: String) -> Void {
        let json: [String: Any] = [
            "Title": title,
            "Year": year,
            "Poster": poster
        ]
        
        if let _ = MovieModel.createFrom(json: json) {
            try? AERecord.Context.main.save()
        }
    }
}

