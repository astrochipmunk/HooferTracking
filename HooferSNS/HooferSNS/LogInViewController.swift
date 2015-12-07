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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}