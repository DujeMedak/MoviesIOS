//
//  MovieModel+CoreDataClass.swift
//  
//
//  Created by Duje Medak on 07/06/2018.
//
//

import Foundation
import CoreData
import AERecord

@objc(MovieModel)
public class MovieModel: NSManagedObject {
    
    class func createFrom(json: [String: Any]) -> MovieModel? {
        if  let title = json["Title"] as? String,
            let year = json["Year"] as? String,
            let poster = json["Poster"] as? String,
            let id = json["imdbID"] as? String{
            
            // TODO this part needs to be changed if the attributes in the class movie are changing through time
            if let movie = movieExists(movieID: id),
                movie.plot == nil{
                if let plot = json["Plot"] as? String{
                    movie.plot = plot
                }
                
                if let genre = json["Genre"] as? String,
                    let director = json["Director"] as? String{
                    movie.genre = genre
                    movie.director = director
                }
                return movie
            }
            else{
                let movie = MovieModel.firstOrCreate(with: ["id": id])
                movie.title = title
                movie.id = id
                movie.year = year
                movie.poster = poster
                return movie
            }
            
        }
        return nil
    }
    
    class func updatePlot(movieID:String, newPlot: String) -> MovieModel? {
        if  let movie = movieExists(movieID: movieID){
            movie.plot = newPlot
            try? AERecord.Context.main.save()
            return movie
        }
        return nil
    }
    
    class func movieExists(movieID: String) -> MovieModel? {
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "id == %@", movieID)
        request.fetchLimit = 1
        if let movie = try? context.fetch(request).first{
            return movie
        }
        return nil
    }
}

