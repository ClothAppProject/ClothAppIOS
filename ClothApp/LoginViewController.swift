//
//  loginView.swift
//  ClothApp
//
//  Created by Giacomo Ceribelli on 18/06/16.
//  Copyright © 2016 Giacomo Ceribelli. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //pressed login button
    @IBAction func loginPressed(sender: UIButton) {
        var message:String = ""
        if (!username.hasText() || !password.hasText())  {
            message = "I campi non possono essere vuoti"
            
            //initialize alert dialog
            let alert = UIAlertController(title: "Attenzione!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //proceed with login
        
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}