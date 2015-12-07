//
//  ShowRunViewController.swift
//  HooferSNS
//
//  Created by Cormick Hnilicka on 12/7/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit
import GoogleMaps
import HealthKit

class ShowRunViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var averageSpeed: UILabel!

    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var maxSpeed: UILabel!
    
    @IBOutlet weak var altitudeChange: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    override func viewDidLoad() {
        
    }
    
    
   override func didReceiveMemoryWarning() {
    
    }
//    func setUpView(){
//        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: run.distance.doubleValue)
//        distanceLabel.text = "Distance: " + distanceQuantity.description
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = .MediumStyle
//        dateLabel.text = dateFormatter.stringFromDate(run.timestamp)
//        
//        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: run.duration.doubleValue)
//        timeLabel.text = "Time: " + secondsQuantity.description
//        
//        let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
//        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: run.duration.doubleValue / run.distance.doubleValue)
//        paceLabel.text = "Pace: " + paceQuantity.description
//    
//    }
}
