//
//  MovieGridDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/5/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieGrid : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return movies.count }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionCell", forIndexPath: indexPath) as! MovieCollectionCell
        cell.setup(movies[indexPath.row])
        return cell
    }
}