//
//  ViewController.swift
//  ClothApp
//
//  Created by Giacomo Ceribelli on 18/06/16.
//  Copyright © 2016 Giacomo Ceribelli. All rights reserved.
//

import UIKit
import Parse

class SplashViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        
        let currentUser = PFUser.currentUser()
        
        if (!currentUser!.authenticated) {
            //load images
            print("loggato")
        }else{
            print("non loggato")
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
            presentViewController(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

