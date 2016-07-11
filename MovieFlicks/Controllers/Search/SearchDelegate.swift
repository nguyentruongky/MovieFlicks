    //
//  SearchDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension SearchController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchWithKeyword(searchBar.text!)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        self.performSelector(#selector(searchWithKeyword), withObject: searchBar.text!, afterDelay: 1)
    }
}

extension SearchController : SearchDelegate {
    
    func searchWithKeyword(key: String) {
        
        loading.hidden = false
        loading.startAnimating()
        
        let filterData = getFilterData()
        searchParam = searchParam == nil ? [String: AnyObject]() : searchParam
        searchParam["query"] = key
        searchParam["page"] = "1"
        searchParam["include_adult"] = filterData.allowAdult ? "true" : "false"
        searchParam["primary_release_year"] = filterData.year
        
        ListCommunicator.filterWithParams(searchParam, complete: { [unowned self] (movies) in
            self.handleFilterComplete(movies, params: self.searchParam)
            }, fail: { [unowned self] (message) in
                self.handleFilterFail(message)
        }) { [unowned self] in // empty
            self.handleFilterEmptyState()
        }
    }
    
    func didFilterWithData(filterData: MovieFilter) {
    
        searchParam = searchParam == nil ? [String: AnyObject]() : searchParam
        searchParam["query"] = searchBar.text!
        searchParam["page"] = "1"
        searchParam["include_adult"] = filterData.adult
        searchParam["primary_release_year"] = filterData.releaseYear
        
        ListCommunicator.filterWithParams(searchParam, complete: { [unowned self] (movies) in
            self.handleFilterComplete(movies, params: self.searchParam)
            }, fail: { [unowned self] (message) in
                self.handleFilterFail(message)
        }) { [unowned self] in // empty
            self.handleFilterEmptyState()
        }
    }
    
    func handleFilterComplete(movies: [Movie], params: [String: AnyObject]) {
        
        loading.stopAnimating()
        api = "https://api.themoviedb.org/3/search/movie"
        searchParam = params
        self.movies = movies
        emptyView.hidden = true 
        movieList.setup(movies)
    }
    
    func handleFilterFail(message: String) {
        showLoading(false)
        showErrorViewWithMessage(message)
    }
    
    func handleFilterEmptyState() {
        showLoading(false)
        movies.removeAll()
        emptyView.hidden = false
    }
    
    
    func showSearchBar(show: Bool) {
        searchBar.resignFirstResponder()
    }

}

extension SearchController : LoadMoviesDelegate {
    
    func loadMore() {
        
        guard shouldLoadMore && !isLoading else { return }
        isLoading = true
        searchParam = searchParam == nil ? [String: AnyObject]() : searchParam
        
        api = "https://api.themoviedb.org/3/search/movie"
        Communicator.get(api, params: searchParam, successCompletion: { [unowned self] (rawData) in
            self.isLoading = false
            self.currentPage += 5
            let data = Communicator.parseMovieData(rawData)
            if self.currentPage >= data.totalPage {
                self.shouldLoadMore = false
            }
            
            self.movies.appendContentsOf(data.movies)
        }) { [unowned self] (message) in
            self.showErrorViewWithMessage(message)
        }
    }
    
    func reloadMovie(complete: (() -> ())?) {
        
        searchParam = ["page": String(1)]
        Communicator.get(api, params: ["page": String(1)], successCompletion: { [unowned self] (rawData) in
            self.isLoading = false
            self.currentPage += 1
            let data = Communicator.parseMovieData(rawData)
            if self.currentPage >= data.totalPage {
                self.shouldLoadMore = false
            }
            
            self.movies = data.movies
            complete?()
        }) { [unowned self] (message) in
            self.showErrorViewWithMessage(message)
        }
        
    }
}

extension SearchController : HomeSectionDelegate {
    
    // empty func
    func showListWithData(movies: [Movie], title: String, api: String) { }
    
    func showMovieDetail(movie: Movie) {
        let controller = UIStoryboard(name: sb_Main, bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        controller.data = movie
        searchBar.resignFirstResponder()
        navigationController?.pushViewController(controller, animated: true)
    }
}




























