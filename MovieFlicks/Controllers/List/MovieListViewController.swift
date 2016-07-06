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
    var api: String!
    internal var currentPage = 1
    internal var totalPage = 2
    internal var viewMode = ViewMode.ListView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false 
        movieList.setup(movies)
        movieGrid.hidden = true
    }
    
    @IBAction func changeViewMode() {
        
        viewMode = viewMode == .ListView ? .GridView : .ListView
        viewMode == .ListView ? showListView() : showGridView()
        viewModeButton.image = viewMode == .ListView ? UIImage(named: "listview") : UIImage(named: "gridview")
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
