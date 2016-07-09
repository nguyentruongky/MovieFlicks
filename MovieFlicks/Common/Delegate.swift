//
//  Delegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

protocol LoadMoviesDelegate {
    
    func loadMore()
    func reloadMovie(complete: (() -> ())?)
}
