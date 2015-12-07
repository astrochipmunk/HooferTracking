//
//  GPSViewController.swift
//  HooferSNS
//
//  Created by Cormick Hnilicka on 12/6/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit
import GoogleMaps

class GPSViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var MapButton: UIButton!
    
    var locationmanager = CLLocationManager();
    
    var firstLocationUpdate: Bool?
    
    var didFindMyLocation = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true;
        
        mapView.delegate = self;
        mapView.animateToLocation(CLLocationCoordinate2DMake(43.4753, -110.7692));
        mapView.animateToZoom(20);
        
        self.locationmanager.delegate = self;
        self.locationmanager.requestWhenInUseAuthorization();
        self.locationmanager.distanceFilter = kCLDistanceFilterNone
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationmanager.startUpdatingLocation()
        
        
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
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationmanager.startUpdatingLocation()
            
            
            mapView.myLocationEnabled = true
            
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapView.removeObserver(self, forKeyPath: "myLocation", context: nil);
        mapView.delegate = nil;
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
