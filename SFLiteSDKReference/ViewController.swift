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
    var alert: UIAlertController? = nil

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
            info.append("registered beacon: \(self.beaconManager.associatedBeaconString ?? "none")\n")
            info.append("mode: \(self.beaconManager.mode)\n")
            info.append("active: \(self.beaconManager.active)\n")
            info.append("beacons visible: \(BeaconTracker.shared.trackedBeacons.count)\n")
            info.append("sucessful reports: \(self.beaconManager.successfulObservationPosts)\n")
            info.append("failed reports: \(self.beaconManager.failedObservationPosts)\n")
            self.label.text = info

            if (self.beaconManager.associatedBeaconString == nil) {
                if (self.beaconManager.visibleBeacons.count > 0) {
                    // At least one beacon is visible and this no associated beacon has been set yet.  We need to ask the user to confirm here if this is their beacon, and then set it as the associated beacon.  If more than one beacon is visible, we may need to ask the user which one is theirs (if any).
                    self.promptUserToPickBeacon(index: 0)
                }
            }

            
        }
    }
    
    func promptUserToPickBeacon(index: Int) {
        if (alert != nil) {
            // we are already prompting.  Don't show a second dialog
            return
        }
        let title = "Configure Beacon"
        let visibleBeaconsToChooseFrom = self.beaconManager.visibleBeacons
        if visibleBeaconsToChooseFrom.count > index {
            let major = visibleBeaconsToChooseFrom[index].major
            let minor = visibleBeaconsToChooseFrom[index].minor
            let beaconHex = String(format: "%04X%04X", Int(truncating: major), Int(truncating: minor))
            let message = "Is the number printed on the back of your beacon \(beaconHex) ?"
            self.alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            if let alert = self.alert {
                alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler:  {(alertAction: UIAlertAction!) in
                    self.beaconManager.setAssociatedBeacon(visibleBeaconsToChooseFrom[index])
                    self.alert = nil
                }))
                alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler:  {(alertAction: UIAlertAction!) in
                    // go to next one
                    self.alert = nil
                    self.promptUserToPickBeacon(index: index+1)
                }))
                alert.addAction(UIAlertAction(title: "Skip", style: UIAlertAction.Style.cancel, handler:  {(alertAction: UIAlertAction!) in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

