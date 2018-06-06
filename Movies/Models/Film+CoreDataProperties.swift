//
//  Film+CoreDataProperties.swift
//  
//
//  Created by Duje Medak on 06/06/2018.
//
//

import Foundation
import CoreData


extension Film {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Film> {
        return NSFetchRequest<Film>(entityName: "Film")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var imdbID: String?
    @NSManaged public var type: String?
    @NSManaged public var posterUrl: String?

}
