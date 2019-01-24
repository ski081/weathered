//
//  AppDelegate.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/19/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "--°"
        statusItem.button?.action = #selector(AppDelegate.displayPopup(_:))
    }

    func applicationWillTerminate(_ aNotification: Notification) {

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
