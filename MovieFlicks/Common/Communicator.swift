//
//  Communicator.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

struct Communicator {
    
    static func get(api: String, params: [String: AnyObject]?, successCompletion: (rawData: AnyObject) -> Void, failCompletion: ((message: String) -> Void)?) {
        
        var parameters = params == nil ? [String: AnyObject]() : params!
        parameters["api_key"] = apiKey
        
        Alamofire.request(.GET, api, parameters: parameters)
            .responseJSON { response in
                guard let rawData = response.result.value else {
                    failCompletion?(message: response.result.error!.localizedDescription)
                    return
                }
                successCompletion(rawData: rawData)
        }
    }
    
    static func parseMovieData(rawData: AnyObject) -> (movies: [Movie], totalPage: Int) {
        
        let totalPage = rawData["total_pages"] as? Int
        let results = rawData["results"] as! [AnyObject]
        var movies = [Movie]()
        for result in results {
            let poster = result["poster_path"] as? String
            let backdrop = result["backdrop_path"] as? String
            guard backdrop != nil || poster != nil else { continue }
            
            movies.append(Movie(rawData: result))
        }
        
        guard let total = totalPage else { return (movies, 0) }
        return (movies, total)
    }
}

