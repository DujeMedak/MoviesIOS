//
//  OmdbAPI.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import Alamofire
import AERecord

class OmdbAPI:RestAPI{
    
    let beggining = "http://www.omdbapi.com/?s="
    let ending = "&apikey=bf90cf2e"
    
    func fetchMovieModel(title: String) -> MovieModel? {
        return nil
    }
    
    func fetchMovieModelList(search: String, completion: @escaping (([MovieModel]?) -> Void)){
        let searchUrl = beggining + search + ending
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
    init() {
    }
    
    func getMovie(title: String) -> Movie? {
        return nil
    }
    
}
