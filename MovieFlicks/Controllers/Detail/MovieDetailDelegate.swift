//
//  MovieDetailDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieDetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if self.scrollView == scrollView {
            
            if scrollView.contentOffset.y  == 0 {
                UIView.animateWithDuration(0.5, animations: {
                    self.overviewScrollView.contentOffset.y = 0
                })
            }
            overviewScrollView.scrollEnabled = scrollView.contentOffset.y != 0
        }
    }
}

struct MovieDetailCommunication {
    
    static func getDetailWithMovieId(id: Int, successHandler: (runTime: Int) -> (), failHandler: (() -> ())?) {
        
        let api = "https://api.themoviedb.org/3/movie/\(id)"
        Communicator.get(api, params: nil, successCompletion: { (rawData) in
            
                let runtime = rawData["runtime"] as! Int
                successHandler(runTime: runtime)
            
            }, failCompletion: nil)
    }

}