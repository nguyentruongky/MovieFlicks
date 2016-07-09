//
//  MovieListDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieListViewController: HomeSectionDelegate, LoadMoreMoviesDelegate {
    
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
        Communicator.get(api, params: ["page": String(currentPage)], successCompletion: { [unowned self] (rawData) in
            self.isLoading = false
            self.currentPage += 1
            let data = HomeViewCommunicator.parseData(rawData)
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
}