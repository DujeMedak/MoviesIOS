//
//  MovieModel+CoreDataClass.swift
//  
//
//  Created by Duje Medak on 07/06/2018.
//
//

import Foundation
import CoreData

@objc(MovieModel)
public class MovieModel: NSManagedObject {
    class func createFrom(json: [String: Any]) -> MovieModel? {
        if  let title = json["Title"] as? String,
            let year = json["Year"] as? String,
            let poster = json["Poster"] as? String,
            let id = json["imdbID"] as? String{
            
            let movie = MovieModel.firstOrCreate(with: ["title": title])
            movie.title = title
            movie.id = id
            movie.year = year
            movie.poster = poster
            if let plot = json["Plot"] as? String{
                    movie.plot = plot
            }
            return movie
        }
        return nil
    }
}

