//
//  ViewController.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var movieArr = [Movie]()
    var delegate : MovieSelectionProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    @IBAction func openQRAction(_ sender: Any) {
        let destVC = QReaderViewController()
        present(destVC, animated: true, completion: nil)

    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as! MovieDetailsTableViewCell
        
        let movie = movieArr[indexPath.row]
     
        cell.title = movie.title
        
        cell.date = String(movie.releaseYear)
        guard let url = URL(string: movie.image!) else {fatalError()}
        if let data = try? Data( contentsOf:url){
        cell.cellImage = UIImage(data: data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "DetailsViewController", sender: indexPath.row)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController"{
            let destVC = segue.destination as! DetailsViewController
        self.delegate = destVC
        let movie = movieArr[sender as! Int]
        delegate?.didSelectMovie(movieSelected: movie)
        }
    }
    
}
protocol MovieSelectionProtocol {
    func didSelectMovie(movieSelected movie : Movie)
}

