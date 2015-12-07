//
//  WeatherTableTableViewController.swift
//  HooferSNS
//
//  Created by Sophia Ehlen on 12/5/15.
//  Copyright © 2015 Sophia Ehlen. All rights reserved.
//


import UIKit
import SwiftyJSON

class WeatherTableTableViewController: UITableViewController {
    
    
    @IBOutlet var table: UITableView!
    
   
//    var labels = [String: UILabel]()
//    var strings = [String]()
//    var objects = [[String: String]]()
//

    var weatherType = [String]()
    var weatherTemp = [String]()
    var weatherFeelsLike = [String]()
    var weatherWindInfo = [String]()
    var pic = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Determine if json can be parsed from WeatherUndergroundAPI
        let urlString = "http://api.wunderground.com/api/e9de73f691203607/conditions/q/WI/Madison.json"
        
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url) {
                let json = JSON(data: data!)
                
                if json["response"]["version"].string == "0.1" {
                    // Parsing of JSON data will proceed
                    parseJSON(json)
                }
            }
        }
    }

    
    
    func parseJSON(json: JSON) {
        
        for result in json["response"]["current observation"].arrayValue {
            let weather = result["weather"].stringValue
            weatherType.append(weather)
            let iconurl = result["icon_url"].stringValue
            pic.append(iconurl)
            let temp_f = result["temp_f"].stringValue
            weatherTemp.append(temp_f)
            //let wind_mph = result["wind_mph"].stringValue
            let wind_string = result["wind_string"].stringValue
            weatherWindInfo.append(wind_string)
            let feelslike_f = result["feelslike_f"].stringValue
            weatherFeelsLike.append(feelslike_f)
            
            print(weatherFeelsLike[1])
            
        }
        table.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell", forIndexPath: indexPath)

        // Configure the cell...
        let currentWeather = weatherTemp[indexPath.row]
        cell.textLabel?.text = weatherTemp[0]
        cell.detailTextLabel?.text = weatherType[0]
    

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
