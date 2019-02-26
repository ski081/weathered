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
    @IBOutlet weak var poweredByButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    
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
        updateUI()
        
        quitButton.styleButtonText(withName: "Quit",
                                   fontColor: .darkGray,
                                   alignment: .center,
                                   font: "Avenir Next",
                                   size: 11)
        poweredByButton.styleButtonText(withName: "Powered By",
                                        fontColor: .darkGray,
                                        alignment: .center,
                                        font: "Avenir Next",
                                        size: 11)
        
        WeatherService.instance.downloadForecast { [unowned self] in
            self.collectionView.reloadData()
        }
    }

    func updateUI() {
        guard let weather = WeatherService.instance.currentWeather else {
            return
        }
        
        dateLabel.stringValue = weather.date
        temperatureLabel.stringValue = "\(weather.currentTemp)°"
        weatherConditionLabel.stringValue = weather.weatherType.rawValue
        weatherImageView.image = NSImage(named: NSImage.Name("\(weather.weatherType.rawValue)"))
    }
    
    
    @IBAction func poweredByButtonClicvked(_ sender: NSButton) {
        NSWorkspace.shared.open(apiHomepageURL)
    }
    
    @IBAction func quitButtonClicked(_ sender: NSButton) {
        NSApplication.shared.terminate(nil)
    }
}

extension WeatherViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let foreCastItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "WeatherCell"),
                                                   for: indexPath)
        
        guard let forecastCell = foreCastItem as? WeatherCell else {
            return foreCastItem
        }
        
        forecastCell.configure(with: WeatherService.instance.forecast[indexPath.item])
        
        return forecastCell
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherService.instance.forecast.count
    }
}

extension WeatherViewController: NSCollectionViewDelegate {
    
}

extension WeatherViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 125, height: 125)
    }
}
