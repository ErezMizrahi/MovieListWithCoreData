//
//  DetailsViewController.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit



class DetailsViewController: UIViewController {

    @IBOutlet var genres: [UILabel]!
    @IBOutlet var details: [UILabel]!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  

}

extension DetailsViewController : MovieSelectionProtocol {
    func didSelectMovie(movieSelected movie: Movie) {
        print(movie)
        DispatchQueue.main.async {
            guard let url = URL(string: movie.image!) else {fatalError()}
            if let data = try? Data( contentsOf:url){
                self.movieImageView.image = UIImage(data: data)
            }

                    self.details[0].text = movie.title
                    self.details[1].text = String(movie.releaseYear)
                    self.details[2].text = "\(movie.title ?? "") avarage rating is: \(movie.rating)"
            
                    let genreArray = movie.genre as! [String]
            
                    for (index, genre) in genreArray.enumerated() {
                        self.genres[index].text = genre
                    }
        }
        

    }
}
