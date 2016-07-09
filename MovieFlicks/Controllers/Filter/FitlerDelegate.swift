//
//  FitlerDelegate.swift
//  MovieFlicks
//
//  Created by Ky Nguyen on 7/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import HorizontalPicker

extension FilterViewController: HorizontalPickerViewDelegate, HorizontalPickerViewDataSource {
    
    func numberOfRowsInHorizontalPickerView(pickerView: HorizontalPickerView) -> Int {
        return yearCount
    }
    
    func horizontalPickerView(pickerView: HorizontalPickerView, titleForRow row: Int) -> String {
        return "\(firstYear + row)"
    }
    
    func horizontalPickerView(pickerView: HorizontalPickerView, didSelectRow row: Int) {

    }

    
    
}