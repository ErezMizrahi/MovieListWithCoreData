//
//  SplashScreenViewController.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 30/04/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    var movieArr = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APILogic.instance.GetRequest {[weak self]  (movies,err)  in
            if err != nil {
                fatalError()
            }else{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
                    self?.performSegue(withIdentifier: "SplashScreenViewController", sender: movies)

                })
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SplashScreenViewController" {
            let destVC = (segue.destination as? UINavigationController)?.viewControllers.first as? ViewController
            destVC!.movieArr = sender as! [Movie]
        }
    }

  

}
