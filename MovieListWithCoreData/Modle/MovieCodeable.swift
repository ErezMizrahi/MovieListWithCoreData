//
//  MovieCodable.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation

struct MovieCodeable : Codable {
    let title : String
    let image : String
    let rating : Double
    let releaseYear : Int
    let genre : [String]
}
