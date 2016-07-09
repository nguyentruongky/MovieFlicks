//
//  HomeListCellDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/7/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

protocol HomeSectionDelegate {
 
    func showListWithData(movies: [Movie], title: String, api: String)
    
    func showMovieDetail(movie: Movie)
}
extension HomeListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return movies.count }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCollectionCell", forIndexPath: indexPath) as! HomeCollectionCell
        cell.setupData(movies[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 165, height: 216)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate.showMovieDetail(movies[indexPath.row])
    }
}
