//
//  ListCommunicator.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

struct ListCommunicator {
    
    static func searchWithKeyword(key: String, complete: (movies: [Movie]) -> Void, fail: (message: String) -> Void) {
        
//        let api = "http://api.themoviedb.org/3/search/keyword"
//        let param = ["query": key, "page": "5"]
        
//        Communicator.get(api, params: param, successCompletion: { (rawData) in
//            let data = Communicator.parseMovieData(rawData)
//            complete(movies: data.movies)
//            }) { (message) in
//                fail(message: message)
//        }
    }
    
    static func filterWithParams(params: [String: AnyObject], complete: (movies: [Movie]) -> Void, fail: (message: String) -> Void, empty: () -> ()) {
        let api = "https://api.themoviedb.org/3/search/movie"
        Communicator.get(api, params: params, successCompletion: { (rawData) in
            let dic = rawData["result"] as? NSDictionary
            guard dic != nil else {
                empty()
                return }
            let data = Communicator.parseMovieData(rawData)
            complete(movies: data.movies)
            }) { (message) in
                fail(message: message)
        }
    }
}