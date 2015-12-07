//
//  LogInViewController.swift
//  HooferSNS
//
//  Created by Gaoyuan Chen on 12/2/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBAction func signIn(sender: AnyObject) {
        
        let usernameText = usernameField.text!
        let passwordText = passwordField.text!
        
        PFUser.logInWithUsernameInBackground(usernameText, password:passwordText) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.navigationController?.popToRootViewControllerAnimated(true)
                
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
   
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "homeFromLogIn") {
//            // pass data to next view
//            var hvc = segue.destinationViewController as! HomeViewController;
//            hvc.navigationItem.hidesBackButton = true
//            hvc.navigationItem.rightBarButtonItem?.title = "Log out"
//            hvc.tabBarController?.hidesBottomBarWhenPushed = false
//            
//            
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
