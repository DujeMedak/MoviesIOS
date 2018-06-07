//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import Alamofire
import CoreData
import AERecord

class MoviesViewModel {
    
    let baseUrl = "https://api.nytimes.com/svc/movies/v2/reviews/search.json"
    let apiKey = "677da7a230e64c11bdd9c25072e1b0d1"
    
    let temp = "http://www.omdbapi.com/?t=inception&y=&plot=short&r=json&apikey=bf90cf2e"
    
    let beggining = "http://www.omdbapi.com/?s="
    var search = "batman"
    let ending = "&apikey=bf90cf2e"
    var searchUrl = ""
    
    let baseUrl2 = "http://www.omdbapi.com"
    let apiKey2 = "bf90cf2e"
    
    var movies: [MovieModel]? {
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = AERecord.Context.main
        let movie = try? context.fetch(request)
        return movie
    }
    
    init() {
        searchUrl = beggining + search + ending
    }
    
    func fetchMovies(completion: @escaping (([MovieModel]?) -> Void)) -> Void {
        guard let url = URL(string: searchUrl) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("ERROR:",response)
                    completion(nil)
                    return
                }
                print("result of querry:",response)
                
                if
                    let value = response.result.value as? [String: Any],
                    let results = value["Search"] as? [[String: Any]] {
                    let movies = results.map({ json -> MovieModel? in
                        let movie = MovieModel.createFrom(json: json)
                        return movie
                    }).filter { $0 != nil } .map { $0! }
                    
                    try? AERecord.Context.main.save()
                    
                    completion(movies)
                    return
                } else {
                    completion(nil)
                    return
                }
        }
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
    
    func createMovie(withText title: String) -> Void {
        let json: [String: Any] = [
            "display_title": title
        ]
        
        if let _ = MovieModel.createFrom(json: json) {
            try? AERecord.Context.main.save()
        }
    }
}

