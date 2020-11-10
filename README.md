# SFLiteSDKReference

This is a simple project showing you how to use the SFLiteSDK in your app

## Changelog

2020/11/10 Version 1.1 Add ability to set an associated beacon
2020/09/10 Version 1.0

## Running the Reference App

1. Using XCode 11.2+, open SFLiteSDKReference.xcproject
2. Mofify the Team name and Bundle Identifier to match your development team.
3. Plug in an iOS 12+ device for which you have development enabled
4. Choose to run the app on that phone, then choose Product -> Run
5. You should see something like this:

<img src='https://i.imgur.com/jO1TiCe.png'/>


## Adding the SDK to Your Own Project.

1. Modify your app's Info.plist so that it contains:

```
    <key>UIBackgroundModes</key>
    <array>
	<string>location</string>
    </array>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>“Always Allow” is required for this app.  It uses your location to measure the distance to beacons nearby.</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>“Always Allow” is required for this app.  It uses your location to measure the distance to beacons nearby.</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>“Always Allow” is required for this app.  It uses your location to measure the distance to beacons nearby.</string>
```

You may modify the above usage strings to your liking, as they will be visible to the end user when the user is prompted for location permission.

2. Copy the folder SFLiteSDK.xcframework out of this project into your project.  Be sure to check "copy items if needed" when prompted.

3. Under your project settings, add SFLiteSDK.scframework to your "Frameworks, Libraries and Embedded Content" section.

4. In the above selection, choose "Sign and Embed"

5. In your AppDelegate file, add the line `import SFLiteSDK`.  Note:  IF you get a build error regarding this, do a clean and rebuild.

6. Add the following lines of code to the `didFinishLaunching` method:

```
        beaconManager.client = "my company name" // Please change this
        // Always call start() in your AppDelegate didFinishLaunching
        // so detection will start up automatically.
        beaconManager.start()
        // This should be replaced with a validated email address of the user running this app
        beaconManager.email = "test@test.com"
        NSLog("SFLiteSDK version is %@", beaconManager.version
```

7. Customize the above with the company name that the app will be for, and populate the email field with the email of the user.  The email population may be moved out of the AppDelegate if needed.  The "on" mode will report detections to the server regularly.  In "auto" mode it will only do so if 3+ beacons are detected.

8. Be sure to surface the version of the SDK in the UI.  This will allow us to troubleshoot any bug fixes by making sure what version you are running.  There is an example of how to do this in the ViewController.swift in the reference app.

9. In your ViewController or UI class, you must prompt the user for "Always" location permission.  This can be tricky becausse the user can deny this permission now or at a later time, or grant "when in use" permission.  It is critical that "Always" permission be granted for background detections.

```
        import "CoreLocation"
        ...

        // You must get the user to grant always authorization. The user could only grant
        // "when in use" authorization or "never". If this happens, the SDK will not detect in
        // the background.
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            // the following method call will only prompt the user once.  If you have already
            // prompted the user and they have not granted the proper permission you must figure
            // out a way to convince them to change their selection in settings
            beaconManager.locationManager.requestAlwaysAuthorization()
        }

```


 
