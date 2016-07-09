//
//  MovieDetailViewController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieGrid: MovieGrid!
    @IBOutlet weak var movieList: MovieList!
    @IBOutlet weak var viewModeButton: UIBarButtonItem!

    lazy var movies = [Movie]()
    var currentPage = 1
    var shouldLoadMore = true
    var isLoading = false
    var api: String!
    var delegate: HomeSectionDelegate!
    
    internal var viewMode = ViewMode.ListView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false 
        movieList.setup(movies)
        movieList.delegate = self
        movieList.loadMoreDelegate = self
        
        movieGrid.delegate = self
        movieGrid.loadMoreDelegate = self
        movieGrid.hidden = true
    }
    
    @IBAction func changeViewMode() {
        
        viewMode = viewMode == .ListView ? .GridView : .ListView
        viewMode == .ListView ? showListView() : showGridView()
        viewModeButton.image = viewMode == .ListView ? UIImage(named: "gridview") : UIImage(named: "listview")
    }
    
    func showListView() {
        movieGrid.hidden = true
        movieList.hidden = false
        movieList.setup(movies)
    }
    
    func showGridView() {
        movieGrid.hidden = false
        movieList.hidden = true
        movieGrid.setup(movies)
    }



}
