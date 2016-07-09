//
//  FilterViewController.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import HorizontalPicker

class FilterViewController: UITableViewController {

    @IBOutlet weak var adultSwitch: UISwitch!
    
    @IBOutlet weak var releaseYearPicker: HorizontalPickerView!
    
    let firstYear = 1967
    let yearCount = 50
    var filterDelegate : SearchDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        releaseYearPicker.dataSource = self
        releaseYearPicker.delegate = self
        releaseYearPicker.selectRow(yearCount - 1, animated: false)
    }

    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            let filterData = MovieFilter(releaseYear: String(releaseYearPicker.selectedRow() + firstYear), adult: adultSwitch.on)
            filterDelegate.didFilterWithData(filterData)
        }
    }

}
