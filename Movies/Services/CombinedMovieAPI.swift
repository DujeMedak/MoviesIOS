//
//  CombinedMovieAPI.swift
//  Movies
//
//  Created by Duje Medak on 08/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import Reachability

class CombinedMovieAPI:RestAPI{
    
    var connectedToInternet: Bool = false
    let onlineAPI:RestAPI = OmdbAPI()
    let offlineAPI:RestAPI = DataCoreAPI()
    
    func checkForConnection(){
        let reachability = Reachability()!
        
        if reachability.connection == .none {
            connectedToInternet = false
            print("source: stored data")
        }
        else{
            connectedToInternet = true
            print("source: fetching online data")
        }
    }
    
    func fetchMovieModel(movieID: String, completion: @escaping ((MovieModel?) -> Void)) -> Void{
        checkForConnection()
        if connectedToInternet{
            self.onlineAPI.fetchMovieModel(movieID: movieID, completion: completion)
        }
        else{
            self.offlineAPI.fetchMovieModel(movieID: movieID, completion: completion)
        }
    }
    
    func fetchMovieModelList(search: String, completion: @escaping (([MovieModel]?) -> Void)){
        checkForConnection()
        if connectedToInternet{
            self.onlineAPI.fetchMovieModelList(search: search, completion: completion)
        }
        else{
            self.offlineAPI.fetchMovieModelList(search: search, completion: completion)
        }
        
    }
    
    func getMovie(title: String) -> Movie? {
        return nil
    }
    
}

