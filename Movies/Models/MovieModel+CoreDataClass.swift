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
public class MovieModel: NSManagedObject {class func createFrom(json: [String: Any]) -> MovieModel? {
    if let title = json["display_title"] as? String{
        let review = MovieModel.firstOrCreate(with: ["title": title])
        
        review.title = title
        return review
    }
    
    return nil
    }

}
