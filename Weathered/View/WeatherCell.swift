//
//  WeatherCell.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/23/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class WeatherCell: NSCollectionViewItem {
    @IBOutlet weak var cellDateLabel: NSTextField!
    @IBOutlet weak var highTemperatureLabel: NSTextField!
    
    @IBOutlet weak var lowTemperatureLabel: NSTextField!
    @IBOutlet weak var weatherCellImageView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        view.layer?.backgroundColor = CGColor(red: 0.69,
                                              green: 0.85,
                                              blue: 0.99,
                                              alpha: 0.5)
        view.layer?.cornerRadius = 5
    }
    
}
