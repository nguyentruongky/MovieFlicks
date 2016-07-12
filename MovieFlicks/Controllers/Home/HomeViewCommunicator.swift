//
//  HomeViewCommunicator.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import Alamofire

struct HomeViewCommunicator {
    
    static func fetchNowPlayingMovieAtPage(page: Int, successCompletion: (movies: [Movie], totalPage: Int) -> Void, failCompletion: ((message: String) -> Void)?) {
        
        let api = "https://api.themoviedb.org/3/movie/now_playing"
        Communicator.get(api, params: ["page": String(page)], successCompletion: { (rawData) in
            
            let data = Communicator.parseMovieData(rawData)
            successCompletion(movies: data.movies, totalPage: data.totalPage)
            }) { (message) in
                failCompletion?(message: message)
        }
    }
    
    static func fetchTopRatedMovieAtPage(page: Int, successCompletion: (movies: [Movie], totalPage: Int) -> Void, failCompletion: ((message: String) -> Void)?) {
        
        let api = "https://api.themoviedb.org/3/movie/top_rated"
        Communicator.get(api, params: ["page": String(page)], successCompletion: { (rawData) in
            
            let data = Communicator.parseMovieData(rawData)
            successCompletion(movies: data.movies, totalPage: data.totalPage)
        }) { (message) in
            failCompletion?(message: message)
        }

    }
    
   
}
