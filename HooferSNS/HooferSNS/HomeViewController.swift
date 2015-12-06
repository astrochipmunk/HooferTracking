//
//  HomeViewController.swift
//  HooferSNS
//
//  Created by Gaoyuan Chen on 12/2/15.
//  Copyright © 2015 Gaoyuan Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(PFUser.currentUser())
        if(PFUser.currentUser() !== nil){
            
        self.navigationItem.rightBarButtonItem?.title = "Log out"
//      self.navigationItem.rightBarButtonItem?.action = Selector(logOut())

        }else{
        self.navigationItem.rightBarButtonItem?.title = "Sign In"
        }
        // Do any additional setup after loading the view.
    }
    
    func logOut(){
        print("get in logOut")
        PFUser.logOut()
        let currentUser = PFUser.currentUser() // this will now be nil
         print(PFUser.currentUser())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
