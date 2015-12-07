//
//  StatsViewController.swift
//  HooferSNS
//
//  Created by Gaoyuan Chen on 12/2/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            
            let alert = UIAlertController(title: "Sign in?", message: "You have to sign in to continue this page", preferredStyle: .Alert)
            let firstAction = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) -> Void in
                self.tabBarController?.selectedIndex = 0;
            }
            
            let secondAction = UIAlertAction(title: "Sign In", style: .Default) { (alert: UIAlertAction!) -> Void in
                self.performSegueWithIdentifier("signInFromStats", sender: self)
            }
            
            alert.addAction(firstAction)
            alert.addAction(secondAction)
            presentViewController(alert, animated: true, completion:nil)
        
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
