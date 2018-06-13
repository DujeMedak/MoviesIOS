//
//  DataCoreAPI.swift
//  Movies
//
//  Created by Duje Medak on 08/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import AERecord
import CoreData

class DataCoreAPI:RestAPI{
    
    func fetchMovieModel(movieID: String, completion: @escaping ((MovieModel?) -> Void)) -> Void{
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "id == %@", movieID)
        
        guard let movie = try? context.fetch(request).first else{
            print("Error while fetching movie with id",movieID)
            completion(nil)
            return
        }
        completion(movie)
    }
    
    func fetchMovieModelList(search: String, completion: @escaping (([MovieModel]?) -> Void)){
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "title contains[c] %@", search)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        guard let movies = try? context.fetch(request) else{
            print("Error while fetching movies with title", search)
            completion(nil)
            return
        }
        
        if movies.count > 1 {
            completion(movies)
        }
        else{
            completion(nil)
        }
        
    }
}
