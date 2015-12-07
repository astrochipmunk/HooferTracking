//
//  HomeSplashViewController.swift
//  HooferSNS
//
//  Created by Sophia Ehlen on 12/6/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage




class HomeSplashViewController: UIViewController {

    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var condition: UILabel!
    
    @IBOutlet weak var Wind: UILabel!
    @IBOutlet weak var icon: UIImageView!
    //    var labels = [String: UILabel]()
    //    var strings = [String]()
    //    var objects = [[String: String]]()
    //
    
//    var weatherType = [String]()
//    var weatherTemp = [String]()
//    var weatherFeelsLike = [String]()
//    var weatherWindInfo = [String]()
//    var pic = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageURL : String = "no url"
        
        
        Alamofire.request(.GET, "http://api.wunderground.com/api/e9de73f691203607/conditions/q/WI/Madison.json")
            .responseJSON { response in
//                debugPrint(response)
//                print("Orig URL")
//                print(response.request)
//                print(response.response)
//                print(response.data)
//                print(response.result)
                
                if let value: AnyObject = response.result.value{
                    
                    let post = JSON(value)
                    
                    print("The post is " + post.description)
                    
                    // Parse the current weather conditions
                    if let weather = post["current_observation"]["weather"].string {
                        print("THE WEATHER IS "  + weather)
                        self.condition.text = weather
                        
                    }
                    else {
                        print("error parsing WEATHER")
                    }
                    // Parse the weather icon url
                    if let iconURL = post["current_observation"]["icon_url"].string {
                        print("THE ICON URL IS " + iconURL)
                        imageURL = String(iconURL)
                        //self.load_icon("iconURL")
                        print(imageURL)
                    }
                    else {
                        print("error parsing icon url")
                    }
                    

                    
                    // Parse the temperature
                    if let temp = post["current_observation"]["temp_f"].double {
                        let tempString = String(temp)
                        print("THE TEMP IS " +  tempString)
                        self.temp.text = tempString
                        self.temp.text?.appendContentsOf("°F")
                    }
                    else {
                        print("error parsing temp")
                    }
                    
                    // Parse the wind string
                    if let windString = post["current_observation"]["wind_string"].string {
                        print("THE WIND STRING IS " + windString)
                        self.Wind.text = "Wind: "
                        self.Wind.text?.appendContentsOf(windString)
                    }
                    else {
                        print("error parsing windString")
                    }
                    

          
                    
                }

                Alamofire.request(.GET, imageURL).responseImage { response in
                    debugPrint(response)
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    if let image = response.result.value {
                        print("Image downloaded: \(image)")
                        let url: NSURL = NSURL(string: imageURL)!
                        let size = CGSize(width: 50.0, height: 50.0)
                        let aspectScaledToFitImage = image.af_imageScaledToSize(size)
                        self.icon.image = image
                        
                    }

                }
                
                

                
                
        }
        
        
        
        
        

    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    
