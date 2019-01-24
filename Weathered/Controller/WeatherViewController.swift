//
//  WeatherViewController.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/19/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class WeatherViewController: NSViewController {
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var temperatureLabel: NSTextField!
    @IBOutlet weak var locationLabel: NSTextField!
    @IBOutlet weak var weatherImageView: NSImageView!
    @IBOutlet weak var weatherConditionLabel: NSTextField!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.enclosingScrollView?.borderType = .noBorder
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.layer?.backgroundColor = CGColor(red: 0.29,
                                              green: 0.72,
                                              blue: 0.98,
                                              alpha: 1.0)
        
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }
}

extension WeatherViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let foreCastItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "WeatherCell"),
                                                   for: indexPath)
        return foreCastItem
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}

extension WeatherViewController: NSCollectionViewDelegate {
    
}

extension WeatherViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 125, height: 125)
    }
}
