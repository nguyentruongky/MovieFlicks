//
//  HomeViewController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var viewHeaderButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var theHottestMovie : Movie!
    
    lazy var data : [(movies: [Movie], title: String)] = [(movies: [Movie], title: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNowPlayingMovies()
        fetchTopRatedMovies()
        navigationController?.navigationBarHidden = true
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    func fetchNowPlayingMovies() {
        HomeViewCommunicator.fetchNowPlayingMovieAtPage(1, successCompletion: { [unowned self] (movies, totalPage) in
            
            if movies.count > 0 {
                self.theHottestMovie = movies[0]
                self.setupHeaderView(self.theHottestMovie)
            }
            
            var nowPlaying = movies
            nowPlaying.removeAtIndex(0)
            self.data.append((nowPlaying, "Now Playing"))
            self.tableView.reloadData()
        }) { (message) in
            print(message)
        }
    }
    
    func fetchTopRatedMovies() {
        HomeViewCommunicator.fetchTopRatedMovieAtPage(1, successCompletion: { [unowned self] (movies, totalPage) in
            
            self.data.append((movies, "Top Rated"))
            self.tableView.reloadData()
        }) { (message) in
            print(message)
        }
    }

    func setupHeaderView(movie: Movie) {
        
        tableView.tableHeaderView = self.headerView
        headerImageView.downloadImageWithUrlString("\(largePoster)\(movie.poster!)")
        viewHeaderButton.addTarget(self, action: #selector(viewHottestMovie), forControlEvents: .TouchUpInside)
    }
    
    func viewHottestMovie() {
        showMovieDetail(theHottestMovie)
    }
    
    
    

}
