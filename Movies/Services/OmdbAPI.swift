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
    
    //TODO change to a call with parameters
    let beggining = "http://www.omdbapi.com/?s="
    let ending = "&apikey=bf90cf2e"
    
    //let apiKey = "bf90cf2e"
    //let requestTemplate = "http://www.omdbapi.com/?apikey=[yourkey]&"
    let begginingIDUrl = "http://www.omdbapi.com/?i="
    let endingIDUrl = "&y=&plot=short&r=json&apikey=bf90cf2e"
    //let temp2 = "http://www.omdbapi.com/?s=batman&apikey=bf90cf2e"
    
    func fetchMovieModel(movieID: String, completion: @escaping ((MovieModel?) -> Void)) -> Void{
        let searchUrl = begginingIDUrl + movieID + endingIDUrl
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
                print("Result of fetching movie details:",response)
                
                if  let value = response.result.value as? [String: Any],
                    let movie = MovieModel.createFrom(json: value){
                    print("Created movie:", movie)
                    //try? AERecord.Context.main.save()
                    completion(movie)
                    return
                }
                else {
                    completion(nil)
                    return
                }
        }
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
                        // create new one
                        let movie = MovieModel.createFrom(json: json)
                        // TODO check if it already exist and fetch it from database
                        // if db.contains(movie.title) {
                        // return db.get(key=title)
                        //
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
