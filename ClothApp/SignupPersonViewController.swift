//
//  SignupViewController.swift
//  ClothApp
//
//  Created by Giacomo Ceribelli on 18/06/16.
//  Copyright © 2016 Giacomo Ceribelli. All rights reserved.
//

import UIKit
import Parse

class SignupPersonViewController: UIViewController {
    
    @IBOutlet weak var user: NSLayoutConstraint!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var birthday: UIDatePicker!
    
    @IBAction func signupButton(sender: AnyObject) {
        var message:String = ""
        if (username.text == "")    {
            message = "L'username non può essere vuoto"
        } else if (((username.text!.containsString(" ")))) {
            message = "L'username non può contenere spazi"
        }else if (password.text == "")  {
            message = "La password non può essere vuota"
        } else if (password.text != passwordConfirm.text)   {
            message = "Le password devono coincidere"
        }else if (!isValidEmail(email.text!)) {
            message = "La mail inserita non è valida"
        }else if (name.text == "" || surname.text == "")    {
            message = "Nome e Cognome non possono essere vuoti"
        }else if (password.text?.characters.count < 6 || password.text?.characters.count > 12)  {
            message = "La password deve essere almeno di 6 caratteri e massimo di 12 caratteri"
        }   //else if (password contiene caratteri giusti)
        else {
            //signup can proceed
            let username_check = PFUser.query()
            username_check!.whereKey("lowercase", equalTo:(username.text?.lowercaseString)!)
            username_check!.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                if error != nil || object == nil {
                    if (error?.code == 101) {
                        //user not found registration can proceed
                        let user = PFUser()
                        user.username = self.username.text
                        user.email = self.email.text
                        user.password = self.password.text
                        user["name"] = self.name.text
                        user["flagISA"] = "Persona"
                        user["lowercase"] = self.username.text?.lowercaseString
                        user["Settings"] = "1111111111"
                        user.signUpInBackgroundWithBlock{
                            (success: Bool, error: NSError?) -> Void in
                            if (success) {
                                // The object has been saved.
                                let person = PFObject()
                                person["username"] = self.username.text
                                person["lastname"] = self.surname.text
                                if (self.sex.selectedSegmentIndex == 0)    {
                                    person["sex"] = "m"
                                }else{
                                    person["sex"] = "f"
                                }
                                person["date"] = self.birthday.countDownDuration
                                person.saveInBackground()
                            } else {
                                //error with signup
                                parseErrorCheck(error!.code, uiViewController: self)
                            }
                        }
                        
                    }else{
                        //error querying
                        parseErrorCheck(error!.code, uiViewController: self)
                    }
                }else{
                    //username already exists
                    message = "L'username esiste già!"
                }
            }
        }
        if (message != "")  {
            let alert = UIAlertController(title: "Attenzione!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        print(sex.selectedSegmentIndex)
    }
    
    //funzione per controllare che sia indirizzo mail valido
    func isValidEmail(testStr:String) -> Bool {
        
        if (testStr == "") {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}