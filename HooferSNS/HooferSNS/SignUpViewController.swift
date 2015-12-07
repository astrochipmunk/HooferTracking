//
//  SignUpViewController.swift
//  HooferSNS
//
//  Created by Gaoyuan Chen on 12/2/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        

            var user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            user.email = emailField.text
      
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    
                    let errorString = error.userInfo["error"] as? NSString
                    
                } else {
                    
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }

    }
       override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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
