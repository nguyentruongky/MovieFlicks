//
//  KViewBase.swift
//  KeHoachPhuot
//
//  Created by Ky Nguyen on 1/27/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class KViewBase: UIView {

    var view: UIView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    
    func xibSetup() {
        backgroundColor = .clearColor()
        
        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        
        setupView()
    }
    
    func loadViewFromNib() -> UIView {
        
        return loadSubViewFromNib(0)
    }
    
    func loadSubViewFromNib(viewIndex: Int) -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: String(self.dynamicType), bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[viewIndex] as! UIView
        
        return view
    }
    
    func setupView() {
    }

}
