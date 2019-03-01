//
//  AppDelegate.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/19/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa
import CoreLocation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CLLocationManagerDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "--°"
        statusItem.button?.action = #selector(AppDelegate.displayPopup(_:))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.distanceFilter = 1000
        locationManager.startUpdatingLocation()
        
        let updateWeatherData = Timer.scheduledTimer(timeInterval: 60 * 15,
                                                     target: self,
                                                     selector: #selector(AppDelegate.downloadWeatherData),
                                                     userInfo: nil,
                                                     repeats: true)
        updateWeatherData.tolerance = 60
        downloadWeatherData()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        currentLocation = location
        Location.instance.latitude = location.coordinate.latitude
        Location.instance.longitude = location.coordinate.longitude
        downloadWeatherData()
    }
    
    @objc func downloadWeatherData() {
        WeatherService.instance.downloadWeatherDetails {
            guard let temp = WeatherService.instance.currentWeather?.currentTemp else {
                return
            }
            
            self.statusItem.button?.title = "\(temp)°"
            
            WeatherService.instance.downloadForecast {
                NotificationCenter.default.post(Notification(name: Notification.Name.Download.downloadComplete))
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    @objc
    func displayPopup(_ sender: AnyObject?) {
        let storyboard = NSStoryboard(name: "Main",
                                      bundle: nil)
        guard let viewController = storyboard.instantiateController(withIdentifier: "WeatherViewController") as? WeatherViewController else {
            fatalError("Invalid VC")
        }
        
        let popOverView = NSPopover()
        popOverView.contentViewController = viewController
        popOverView.behavior = .transient
        popOverView.show(relativeTo: (statusItem.button?.bounds)!,
                         of: statusItem.button!,
                         preferredEdge: .minY)
    }
}
