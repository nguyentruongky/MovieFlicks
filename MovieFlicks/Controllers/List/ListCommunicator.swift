//
//  ListCommunicator.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

struct ListCommunicator {
    
    static func filterWithParams(params: [String: AnyObject], complete: (movies: [Movie]) -> Void, fail: (message: String) -> Void, empty: () -> ()) {
        let api = "https://api.themoviedb.org/3/search/movie"
        Communicator.get(api, params: params, successCompletion: { (rawData) in
            
            guard let dic = rawData["results"] as? NSArray else {
                empty()
                return
            }
            
            guard dic.count > 0 else {
                empty()
                return
            }
            
            let data = Communicator.parseMovieData(rawData)
            complete(movies: data.movies)
            }) { (message) in
                fail(message: message)
        }
    }
}