//
//  MovieDetailViewController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

struct MovieFilter {
    
    var releaseYear = ""
    var adult = true
}

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieGrid: MovieGrid!
    @IBOutlet weak var movieList: MovieList!
    @IBOutlet weak var viewModeButton: UIBarButtonItem!

    @IBOutlet weak var emptyView: UIView!
    lazy var movies = [Movie]()
    lazy var sourceMovies = [Movie]()
    var currentPage = 1
    var shouldLoadMore = true
    var isLoading = false
    var api: String!
    var delegate: HomeSectionDelegate!
    var filterData = MovieFilter()
    var searchParam: [String: AnyObject]!
    
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
    
    @IBAction func filter(sender: AnyObject) {
        let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        filterVC.filterDelegate = self
        navigationController?.pushViewController(filterVC, animated: true)
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
    
    func reloadMovie() {
        emptyView.hidden = true
        
        if viewMode == ViewMode.GridView {
            movieGrid.setup(movies)
            movieGrid.hidden = false
        }
        else {
            movieList.setup(movies)
            movieList.hidden = false
        }
    }



}
