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
        let savedData = getFilterData()
        adultSwitch.setOn(savedData.allowAdult, animated: true)
        let year = Int(savedData.year)!
        releaseYearPicker.selectRow(year - firstYear, animated: true)
        title = "FILTER SETTING"
    }

    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            let filterData = MovieFilter(releaseYear: String(releaseYearPicker.selectedRow() + firstYear), adult: adultSwitch.on)
            filterDelegate.didFilterWithData(filterData)
            saveFilterData(filterData.releaseYear, allowAdult: filterData.adult)
        }
    }
    
    func saveFilterData(year: String, allowAdult: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(allowAdult, forKey: "allowAdult")
        NSUserDefaults.standardUserDefaults().setValue(year, forKey: "year")
    }
    
    func getFilterData() -> (year: String, allowAdult: Bool) {
        
        let adult = NSUserDefaults.standardUserDefaults().boolForKey("allowAdult")
        let year = NSUserDefaults.standardUserDefaults().stringForKey("year")
        return (year: year == "" || year == nil  ? "2016" : year!, allowAdult: adult)
    }

}
