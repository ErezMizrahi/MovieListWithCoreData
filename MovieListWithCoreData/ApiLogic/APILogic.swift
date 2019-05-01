//
//  APILogic.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import CoreData

class APILogic {
    private init() {}
    static let instance = APILogic()
    
    typealias callback = (_ movie : [Movie], _ error : Error?) -> Void
    
    var url : URL {
        get {
            guard let url = URL(string: "https://api.androidhive.info/json/movies.json") else { fatalError() }
            return url
        }
    }
    
    var movies = [Movie]()
    
    func GetRequest (_ callback : @escaping callback) {
        print(url)
        
        let fetchRequest : NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortByYear = NSSortDescriptor(key: "releaseYear", ascending: true)
        fetchRequest.sortDescriptors = [sortByYear]
        
        do {
            let movie = try PersistentService.context.fetch(fetchRequest)
            self.movies = movie
            
        } catch {
            self.movies = []
        }
  
        
        if self.movies.count > 1 {
            callback(self.movies,nil)
        }else{
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                callback([],err)
                print(err!)
            }
//            print(data!)
            self.parseData(with: data) { data in
                do {
                    let decoder = try JSONDecoder().decode([MovieCodeable].self, from: data)
                    
                    for result in decoder {
                        let movie = Movie(context: PersistentService.context)

                            movie.title = result.title
                            movie.genre = result.genre as NSObject
                            movie.image = result.image
                            movie.releaseYear = Int16(result.releaseYear)
                            movie.rating = result.rating
                            
                            PersistentService.saveContext()
                            self.movies.append(movie)
                        
                    }
                   let arr = self.movies.sorted {
                        $0.releaseYear < $1.releaseYear
                    }
                    callback(arr,nil)
                
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    }
        
        
    private func parseData(with data : Data?, complition : (Data)->Void){
        guard let data = data else {return}
        complition(data)
    }
        
}
