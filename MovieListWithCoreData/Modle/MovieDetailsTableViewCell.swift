//
//  MovieDetailsTableViewCell.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var title : String! {
        didSet {
            titleLabel.text = title
        }
    }
    var date : String! {
        didSet {
            dateLabel.text = "Release Year \(date ?? "")"
        }
    }
    var cellImage : UIImage! {
        didSet {
            imageview.image = cellImage
        }
    }
    
}
