//
//  Run.swift
//  
//
//  Created by Cormick Hnilicka on 12/7/15.
//
//


import Foundation
import CoreData

class Run: NSManagedObject {
    
    @NSManaged var duration: NSNumber
    @NSManaged var distance: NSNumber
    @NSManaged var timestamp: NSDate
    @NSManaged var locations: NSOrderedSet
    
}
