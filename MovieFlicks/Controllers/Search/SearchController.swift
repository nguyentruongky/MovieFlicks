//
//  SearchController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieList: MovieList!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var searchParam: [String: AnyObject]!
    var isLoading = false
    var currentPage = 1
    var shouldLoadMore = true
    var api: String!
    lazy var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true
        movieList.delegate = self
        movieList.loadMoreDelegate = self
        movieList.searchDelegate = self
    }
    
    func getFilterData() -> (year: String, allowAdult: Bool) {
        
        let adult = NSUserDefaults.standardUserDefaults().boolForKey("allowAdult")
        let year = NSUserDefaults.standardUserDefaults().stringForKey("year")
        return (year: year == "" || year == nil  ? "2016" : year!, allowAdult: adult)
    }
}
