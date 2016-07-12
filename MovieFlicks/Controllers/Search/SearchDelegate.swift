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
        
        print("start search")
        loading.hidden = false
        loading.startAnimating()
        
        let filterData = getFilterData()
        searchParam = searchParam == nil ? [String: AnyObject]() : searchParam
        searchParam["query"] = key
        searchParam["page"] = "5"
        searchParam["include_adult"] = filterData.allowAdult ? "true" : "false"
        let year = Int(filterData.year)! % 2 == 0 ? "" : filterData.year
        searchParam["year"] = year
        
        SearchCommunicator.searchWithKeyword(key, params: searchParam, complete: { [unowned self] (movieIds) in
            self.loading.stopAnimating()
            self.movieList.setup(self.movies)
            self.emptyView.hidden = true
            self.movieList.hidden = false
            self.shouldLoadMore = false
            
            for id in movieIds {
                
                SearchCommunicator.getMovieDataWithId(id, complete: { (movie) in
                    self.movies.append(movie)
                    self.movieList.setup(self.movies)
                })
            }
            }, fail: { [unowned self] (message) in
                self.loading.stopAnimating()
                self.showErrorViewWithMessage(message)
            }) { [unowned self] in
                self.loading.stopAnimating()
                self.searchBar.resignFirstResponder()
                self.emptyView.hidden = false
        }
    }
    
    // empty func
    func didFilterWithData(filterData: MovieFilter) { }
    
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






























