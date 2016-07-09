//
//  MovieListDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieListViewController: HomeSectionDelegate, LoadMoviesDelegate {
    
    func showMovieDetail(movie: Movie) {
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        detail.data = movie
        navigationController?.pushViewController(detail, animated: true)
    }
    
    // empty func
    func showListWithData(movies: [Movie], title: String, api: String) {
        
    }
    
    func loadMore() {
        
        guard shouldLoadMore && !isLoading else { return }
        isLoading = true
        searchParam = ["page": String(currentPage)]
        Communicator.get(api, params: searchParam, successCompletion: { [unowned self] (rawData) in
            self.isLoading = false
            self.currentPage += 1
            let data = Communicator.parseMovieData(rawData)
            if self.currentPage >= data.totalPage {
                self.shouldLoadMore = false
            }
            
            self.movies.appendContentsOf(data.movies)
            self.viewMode == ViewMode.GridView ?
                self.movieGrid.setup(self.movies) :
                self.movieList.setup(self.movies)
            
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
            self.viewMode == ViewMode.GridView ?
                self.movieGrid.setup(self.movies) :
                self.movieList.setup(self.movies)
            
            complete?()
        }) { [unowned self] (message) in
            self.showErrorViewWithMessage(message)
        }

    }
}

extension MovieListViewController: SearchDelegate {
    
    func searchWithKeyword(key: String) {
       
    }
    
    func didFilterWithData(filterData: MovieFilter) {
        
        showLoading(true)
        var params = [String: AnyObject]()
        params["query"] = "Fight"
        params["page"] = "3"
        params["include_adult"] = String(filterData.adult.hashValue)
        params["year"] = filterData.releaseYear
        
        ListCommunicator.filterWithParams(params, complete: { [unowned self] (movies) in
            self.handleFilterComplete(movies, params: params)
            }, fail: { [unowned self] (message) in
                self.handleFilterFail(message)
            }) { [unowned self] in // empty
                self.handleFilterEmptyState()
        }
    }
    
    func handleFilterComplete(movies: [Movie], params: [String: AnyObject]) {
        
        self.showLoading(false)
        self.api = "https://api.themoviedb.org/3/search/movie"
        self.searchParam = params
        self.movies = movies
        self.reloadMovie()
    }
    
    func handleFilterFail(message: String) {
        showLoading(false)
        showErrorViewWithMessage(message)
    }
    
    func handleFilterEmptyState() {
        showLoading(false)
        movies.removeAll()
        reloadMovie()
        emptyView.hidden = false
        movieList.hidden = true
        movieGrid.hidden = true
    }
}


















