//
//  ViewController.swift
//  SFLiteSDKReference
//
//  Created by David G. Young on 9/10/20.
//  Copyright © 2020 davidgyoungtech. All rights reserved.
//

import UIKit
import SFLiteSDK
import CoreLocation

class ViewController: UIViewController, SFBeaconManagerDelegate {
    @IBOutlet weak var label: UILabel!
    let beaconManager = SFBeaconManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting the delegate is optional, but will give you callbacks to the dataChanged() delegate method, allowing you to update
        // your UI when an event happens in the SDK
        beaconManager.delegate = self
        dataChanged()

        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            // the following method call will only prompt the user once.  If you have already
            // prompted the user and they have not granted the proper permission you must figure
            // out a way to convince them to change their selection in settings
            beaconManager.locationManager.requestAlwaysAuthorization()
        }


    }

    // This callback is from SFLiteSDK.  Use it to update the UI with new info about what is going on inside the SDK
    func dataChanged() {
        DispatchQueue.main.async {
            var info = "SFLiteSDKReference\n"
            info.append("SDK version: \(self.beaconManager.version)\n\n")
            info.append("company: \(self.beaconManager.client)\n")
            info.append("email: \(self.beaconManager.email)\n")
            info.append("mode: \(self.beaconManager.mode)\n")
            info.append("active: \(self.beaconManager.active)\n")
            info.append("beacons visible: \(BeaconTracker.shared.trackedBeacons.count)\n")
            info.append("sucessful reports: \(self.beaconManager.successfulObservationPosts)\n")
            info.append("failed reports: \(self.beaconManager.failedObservationPosts)\n")
            self.label.text = info

        }
    }
}

