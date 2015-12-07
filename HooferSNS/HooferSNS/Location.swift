//
//  Location.swift
//  HooferSNS
//
//  Created by Cormick Hnilicka on 12/7/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    
    @NSManaged var timestamp: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var run: NSManagedObject
    
}

