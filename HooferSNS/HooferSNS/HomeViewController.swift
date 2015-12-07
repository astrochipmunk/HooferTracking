//
//  HomeViewController.swift
//  HooferSNS
//
//  Created by Gaoyuan Chen on 12/2/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func signInAndLogOut(sender: UIBarButtonItem) {
        if(PFUser.currentUser() == nil){
            
            performSegueWithIdentifier("logInFromHome", sender: self)
            
        }else{
            performSegueWithIdentifier("logOut", sender: self)
            self.navigationItem.rightBarButtonItem?.title = "Sign In"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(PFUser.currentUser())
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(PFUser.currentUser() !== nil){
            
            self.navigationItem.rightBarButtonItem?.title = "Log out"
            
        }else{
            
            self.navigationItem.rightBarButtonItem?.title = "Sign In"
            
        }
        self.navigationItem.setHidesBackButton(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "logInFromHome") {
            // pass data to next view
            var lvc = segue.destinationViewController as! LogInViewController;
            lvc.tabBarController?.hidesBottomBarWhenPushed = true
        }
        if (segue.identifier == "logOut") {
            // pass data to next view
            var lvc = segue.destinationViewController as! LogOutViewController;
            lvc.tabBarController?.hidesBottomBarWhenPushed = true
        }
    }



}
