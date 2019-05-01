//
//  Movie+CoreDataProperties.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie  {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseYear: Int16
    @NSManaged public var genre: NSObject?

}
