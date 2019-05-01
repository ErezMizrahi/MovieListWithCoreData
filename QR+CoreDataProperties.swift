//
//  QR+CoreDataProperties.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 01/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//
//

import Foundation
import CoreData


extension QR {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QR> {
        return NSFetchRequest<QR>(entityName: "QR")
    }

    @NSManaged public var string: String?

}
