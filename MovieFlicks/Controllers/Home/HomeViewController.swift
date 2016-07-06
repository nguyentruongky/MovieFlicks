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
    @IBOutlet weak var tableView: UITableView!
    
    lazy var data : [(movies: [Movie], title: String)] = [(movies: [Movie], title: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNowPlayingMovies()
        fetchTopRatedMovies()
        navigationController?.navigationBarHidden = true
    }
    
    func fetchNowPlayingMovies() {
        HomeViewCommunicator.fetchNowPlayingMovieAtPage(1, successCompletion: { [unowned self] (movies, totalPage) in
            
            if movies.count > 0 {
                let movie = movies[0]
                self.setupHeaderView(movie)
            }
            
            var nowPlaying = movies
            nowPlaying.removeAtIndex(0)
            self.data.append((nowPlaying, "Now Playing"))
            self.tableView.reloadData()
        }) { (message) in
            print(message)
        }
    }
    
    func setupHeaderView(movie: Movie) {
        
        tableView.tableHeaderView = self.headerView
        headerImageView.downloadImageWithUrlString("\(largePoster)\(movie.poster!)")
    }
    
    func fetchTopRatedMovies() {
        HomeViewCommunicator.fetchTopRatedMovieAtPage(1, successCompletion: { [unowned self] (movies, totalPage) in
            
            self.data.append((movies, "Top Rated"))
            self.tableView.reloadData()
        }) { (message) in
            print(message)
        }
    }

    
    

}
