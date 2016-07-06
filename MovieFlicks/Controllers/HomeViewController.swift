//
//  HomeViewController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    @IBOutlet weak var movieGridView: MovieGrid!
    var currentPage = 1
    var totalPage = 1
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("start")
        HomeViewCommunicator.fetchNowPlayingMovieAtPage(currentPage, successCompletion: { [unowned self] (movies, totalPage) in
            
            self.movies.appendContentsOf(movies)
            self.movieGridView.setup(self.movies)
            }) { (message) in
                print(message)
        }
    }


}
