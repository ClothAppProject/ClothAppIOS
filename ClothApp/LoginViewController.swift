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
    @IBOutlet weak var signupButton: UITextView!
    @IBOutlet weak var forgotButton: UITextView!
    
    //pressed login button
    @IBAction func loginPressed(sender: UIButton) {
        var message:String = ""
        if (!username.hasText() || !password.hasText())  {
            message = "I campi non possono essere vuoti"
            
            //initialize alert dialog
            let alert = UIAlertController(title: "Attenzione!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            //proceed with login
            //get username capitalized or not
            let username_check = PFUser.query()
            username_check!.whereKey("lowercase", equalTo:(username.text?.lowercaseString)!)
            username_check!.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                if error != nil || object == nil {
                    parseErrorCheck(error!.code, uiViewController: self)
                } else {
                    //obtained correct username
                    let usr:PFUser = (object as? PFUser)!
                    PFUser.logInWithUsernameInBackground(usr.username!, password: self.password.text!)    {
                        (user: PFUser?, error: NSError?) -> Void in
                        if user != nil {
                            // success
                            //go back to splash screen
                        } else {
                            if (error?.code == 101) {
                                parseErrorCheck(0, uiViewController: self)
                            }else{
                                parseErrorCheck(error!.code, uiViewController: self)
                            }
                        }
                    }
                }
            }
        }
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (signupButton.exclusiveTouch)    {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("SignupViewController") as UIViewController
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}