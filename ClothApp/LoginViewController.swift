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
    
    @IBAction func forgotButton(sender: UIButton) {
    }
    
    @IBAction func signupButton(sender: UIButton) {
        //create alert
        let alert = UIAlertController(title: "Che tipo di utente sei?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        //add buttons
        alert.addAction(UIAlertAction(title: "Persona", style:UIAlertActionStyle.Default, handler: goToSignupPerson))
        alert.addAction(UIAlertAction(title: "Negozio", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //handler for Person signup
    func goToSignupPerson(alert: UIAlertAction!)   {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignupPersonViewController") as UIViewController
        presentViewController(vc, animated: true, completion: nil)
    }
    
    //pressed login button
    @IBAction func loginPressed(sender: UIButton) {
        if (!username.hasText() || !password.hasText())  {
            
            //initialize alert dialog
            let alert = UIAlertController(title: "Attenzione!", message: "I campi non possono essere vuoti", preferredStyle: UIAlertControllerStyle.Alert)
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
                    if (error?.code == 101) {
                        parseErrorCheck(0, uiViewController: self)
                    }else{
                        parseErrorCheck(error!.code, uiViewController: self)
                    }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*override func viewDidAppear(animated: Bool) {
        let mySelector:Selector = Selector("goToSignup")
        
        let tapOutTextField:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: mySelector)
        tapOutTextField.numberOfTapsRequired = 1
        signupButton.addGestureRecognizer(tapOutTextField)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}