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
    
    let apiKey = "bf90cf2e"
    let baseUrl = "http://www.omdbapi.com"
    
    func fetchMovieModel(movieID: String, completion: @escaping ((MovieModel?) -> Void)) -> Void{
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: ["i":movieID,"apikey":apiKey])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("ERROR:",response)
                    completion(nil)
                    return
                }
                if  let value = response.result.value as? [String: Any],
                    let movie = MovieModel.createFrom(json: value){
                    try? AERecord.Context.main.save()
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
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: ["s":search,"apikey":apiKey] )
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("ERROR:",response)
                    completion(nil)
                    return
                }
                //print("Response:",response)
                if  let value = response.result.value as? [String: Any],
                    let results = value["Search"] as? [[String: Any]] {
                    let movies = results.map({ json -> MovieModel? in
                        let movie = MovieModel.createFrom(json: json)
                        return movie
                    }).filter { $0 != nil } .map { $0! }
                    
                    try? AERecord.Context.main.save()
                    completion(movies)
                    return
                }
                else {
                    completion(nil)
                    return
                }
        }
    }
    
}
