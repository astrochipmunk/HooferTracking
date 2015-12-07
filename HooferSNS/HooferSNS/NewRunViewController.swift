//
//  NewRunViewController.swift
//  HooferSNS
//
//  Created by Cormick Hnilicka on 12/6/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import HealthKit
import CoreData


class NewRunViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var userSpeed: UILabel!
    
    @IBOutlet weak var userAltitude: UILabel!
    
    @IBOutlet weak var maxSpeed: UILabel!
    
    var userMaxSpeed = 0.0
    
    @IBOutlet weak var altitudeChange: UILabel!
    
    var firstAltitude: Double!
    var altitudeDif: Double!
    
    @IBOutlet weak var MapButton: UIButton!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var runDistance: UILabel!
    
    var locationmanager : CLLocationManager!
    
    var firstLocationUpdate: Bool?
    
    var didFindMyLocation = false
    
    var seconds = 0.0
    var distance = 0.0
    
    var myLocations = [CLLocation]()
    var timer = NSTimer()
    var bestEffortAtLocation: CLLocation!
    var lastDistance: Double!
    var currDistance: Double!
    var update = false;
    
    var speedCount = [Double]()
    
    
    var managedObjectContext = NSManagedObjectContext?()
    
    var run = Run?()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationmanager = CLLocationManager();
        mapView.delegate = self;
        mapView.animateToLocation(CLLocationCoordinate2DMake(43.4753, -110.7692));
        mapView.animateToZoom(20);
        
        self.locationmanager.delegate = self;
        self.locationmanager.requestWhenInUseAuthorization();
        self.locationmanager.distanceFilter = 10
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        self.mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
            mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
            mapView.settings.myLocationButton = true
            
            
            didFindMyLocation = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLoc = locations.first!
        if (update){
        let ha = currLoc.horizontalAccuracy
        if (ha < 25){
        if self.myLocations.count > 0 {

            let n = self.myLocations.last!
            let d = currLoc.distanceFromLocation(n);
            altitudeDif = altitudeDif + Double(altitudeChanges(Double(n.altitude), alt2: Double(currLoc.altitude)));
            distance += d
        }
            self.myLocations.append(currLoc);
        }
            
        }
        let speed = roundToTenth((currLoc.speed))
        let alt = roundToTenth((currLoc.altitude))
        userAltitude.text = (String)(alt) + "meters";
        userSpeed.text = (String)(speed) + "k/h"
       

    }
    

    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationmanager.startUpdatingLocation()
            let speed = (Int)(manager.location!.speed)
            let alt = (Int)(manager.location!.altitude)
            userAltitude.text = (String)(alt) + "meters";
            userSpeed.text = (String)(speed) + "k/h"
            self.myLocations.append(manager.location!);
            mapView.myLocationEnabled = true
            
        }
    }

    @IBAction func changeMapType(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeNormal
            self.MapButton.setTitle("Normal", forState: .Normal)
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeTerrain
            self.MapButton.setTitle("Terrain", forState: .Normal)
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeHybrid
            self.MapButton.setTitle("Hybrid", forState: .Normal)
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil);
    }
    func altitudeChanges(alt1: Double, alt2: Double) -> Double{
        if (alt1 > alt2){
            return alt1 - alt2;
        }
        return 0.0
    }
    func eachSecond(timer: NSTimer) {
        seconds++
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
        
        time.text = "Time: " + secondsQuantity.description
        

        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
        self.runDistance.text = "Distance: " + distanceQuantity.description
        let speed = roundToTenth((Double)(self.locationmanager.location!.speed));
        
        if (speed > userMaxSpeed){
            maxSpeed.text = (String)(speed) + " m/s";
            userMaxSpeed = speed
        }
        
        speedCount.append(speed);

        let alt = roundToTenth((Double)(self.locationmanager.location!.altitude));
        self.altitudeChange.text = (String)(roundToTenth(altitudeDif));
        userAltitude.text = (String)(alt) + "meters";
        userSpeed.text = (String)(speed) + " m/s";
        
    }
    func roundToTenth(value:Double) -> Double {
        let divisor = pow(10.0, Double(1))
        return round(value * divisor) / divisor
    }
    func startLocationUpdates() {
        // Here, the location manager will be lazily instantiated
        locationmanager.startUpdatingLocation()
        let currLoc = locationmanager.location!
        self.myLocations.append(currLoc);
        firstAltitude = currLoc.altitude
    }

    @IBAction func startPressed(sender: AnyObject) {
        locationmanager.stopUpdatingLocation();
        seconds = 0.0
        distance = 0.0
        altitudeDif = 0.0
        myLocations.removeAll(keepCapacity: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(1,
            target: self,
            selector: "eachSecond:",
            userInfo: nil,
            repeats: true)
        update = true;
        startLocationUpdates();
    }
    
    
    
    @IBAction func stopPressed(sender: AnyObject) {
        timer.invalidate()
        let actionSheet = UIAlertController(title: "Save Run?", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let save = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.saveRun();
            self.speedCount.removeAll(keepCapacity: false);
            self.performSegueWithIdentifier("showRun", sender: UIButton.self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        actionSheet.addAction(save)
        actionSheet.addAction(cancelAction)
        
         presentViewController(actionSheet, animated: true, completion: nil);
        
    }
    override func viewWillDisappear(animated: Bool) {
        mapView.removeObserver(self, forKeyPath: "myLocation", context: nil);
        mapView.delegate = nil;
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ShowRunViewController
        vc.ac = altitudeChange.text!
        vc.a_s = String(averageSpeed())
        vc.t = String(seconds)
        vc.d = String(distance)
        vc.da = NSDate()
        vc.ms = maxSpeed.text!
    }
    func averageSpeed() -> Double {
        var total = 0.0
        for x in speedCount {
            total += x
        }
        return (total/(Double)(speedCount.count))
    }
    
    func saveRun() {
        // 1
        
        var savedRun = PFObject(className: "Run");
        let ms = maxSpeed.text!
        let ac = altitudeChange.text!
        let a_s = String(averageSpeed())
        savedRun["distance"] = distance
        savedRun["duration"] = seconds
        savedRun["maxSpeed"] = ms
        savedRun["avgSpeed"] = a_s
        savedRun["altChange"] = ac
        savedRun["timestamp"] = NSDate()
        
        
        // 2
        var savedLocations = [Location]()
        for location in myLocations {
            let savedLocation = Location();
            savedLocation.timestamp = location.timestamp
            savedLocation.latitude = location.coordinate.latitude
            savedLocation.longitude = location.coordinate.longitude
            savedLocations.append(savedLocation)
        }
        
       // savedRun["locations"] = savedLocations
        
        savedRun.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
      self.run = savedRun as? Run
//        
    
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
