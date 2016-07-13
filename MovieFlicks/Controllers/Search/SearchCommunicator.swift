//
//  SearchCommunicator.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

struct SearchCommunicator {

    static func searchWithKeyword(key: String, params: [String: AnyObject], complete: (movieIds: [Int]) -> Void, fail: (message: String) -> Void, empty: () -> Void) {
        
                let api = "https://api.themoviedb.org/3/search/keyword"
                Communicator.get(api, params: params, successCompletion: { (rawData) in
                    
                    guard rawData["results"] != nil else { return } 
                    let results = rawData["results"] as! NSArray
                    guard results.count > 0 else {
                        empty()
                        return
                    }
                    
                    var movieIds = [Int]()
                    for movie in results {
                        let id = movie["id"] as! Int
                        movieIds.append(id)
                    }
                    complete(movieIds: movieIds)
                    
                    }) { (message) in
                        fail(message: message)
                }
    }
    
    static func getMovieDataWithId(id: Int, complete: (movie: Movie) -> Void) {
        
        let api = "https://api.themoviedb.org/3/movie/\(id)"
        Communicator.get(api, params: nil, successCompletion: { (rawData) in
            
            let poster = rawData["poster_path"] as? String
            let backdrop = rawData["backdrop_path"] as? String
            guard backdrop != nil || poster != nil else { return }
            
            let movie = Movie(rawData: rawData)
            complete(movie: movie)
            
            }, failCompletion: { message in 
            print("load fail \(id)")
        })
        
    }
    
    
    
    
    
    
    

    
}











