//
//  AppDelegate.swift
//  SFLiteSDKReference
//
//  Created by David G. Young on 9/10/20.
//  Copyright © 2020 davidgyoungtech. All rights reserved.
//

import UIKit
import SFLiteSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let beaconManager = SFBeaconManager.shared


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        beaconManager.client = "my company name" // Please change this
        // Always call start() in your AppDelegate didFinishLaunching
        // so detection will start up automatically.
        beaconManager.start()
        // This should be replaced with a validated email address of the user running this app
        beaconManager.email = "test@test.com"
        beaconManager.mode = "on" // Change to "auto" after you are done testing. Auto will turn on tracking when 3+ beacons are visible

        // In order to set the beacon associated with this app installation, you need to
        // detect a beacon first, then you can call the method below. An example of how
        // to do this is shown in ViewController.swift
        // beaconManager.setAssociatedBeacon(...)

        NSLog("SFLiteSDK version is %@", beaconManager.version)
        
        return true
    }



}

