//
//  Movie.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

class Movie {
    var title: String?
    var poster: String?
    var overview: String?
    var id: Int?
    var runtime: Int?
    var releaseDate: String?
    var voteAverage: Double?
    var favourite = false 
    
    init(rawData: AnyObject) {
        
        let poster = rawData["poster_path"] as? String
        let backdrop = rawData["backdrop_path"] as? String
        if let poster = poster {
            self.poster = poster
        }
        else {
            self.poster = backdrop!
        }
        
        runtime = rawData["runtime"] as? Int
        releaseDate = rawData["release_date"] as? String
        id = rawData["id"] as? Int
        let overviewValue = rawData["overview"]  as? String
        overview = overviewValue == nil ? "" : overviewValue!
        title = rawData["title"] as? String
        voteAverage = rawData["vote_average"] as? Double
    }

}