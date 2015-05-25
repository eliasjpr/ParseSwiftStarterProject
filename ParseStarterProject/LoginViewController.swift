//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    var signupActive: Bool = true
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var alreadyRegistered: UILabel!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        // Hide activity indicator
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.stopAnimating()
        println("View loaded!")
        
        println(PFUser.currentUser())
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()  != nil {
            self.performSegueWithIdentifier("goToUserTable", sender: self)
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    * Toggle signup  user to the app
    *
    */
    func displayAlert(title: String, error: String?) -> Void {
        // Display error to user
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
    * Toggle signup  user to the app
    *
    *
    */
    @IBAction func toggleSignup(sender: AnyObject) {
        
        if signupActive == true {
            
            signupActive = false
            signUpLabel.text = "Access your account:"
            signUpBtn.setTitle("Sign in", forState: UIControlState.Normal )
            alreadyRegistered.text = "Not Registered?"
            
            loginBtn.setTitle("Sign Up", forState: UIControlState.Normal)
        }
        else {
            signupActive = true
            signUpLabel.text = "Create your account:"
            signUpBtn.setTitle("Sign up", forState: UIControlState.Normal )
            alreadyRegistered.text = "Already Registered?"
            
            loginBtn.setTitle("Sign in", forState: UIControlState.Normal)
        
        }
    }
    
    /*
    * Signup user to the app
    *
    *
    */
    @IBAction func signup(sender: AnyObject) {
        // Show activity indicator
        activityIndicator.hidden = false
        
        //Stop propagating application events
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        var error = ""
        
        if username.text == "" || password.text == "" {
            
            error = "Please enter a username and password!"
            
        }
        
        if error != "" {
            self.displayAlert( "Login error", error: error )
            
        } else {
            
            // Sign in user
            var user        = PFUser()
            user.username   = username.text
            user.password   = password.text
            
            if signupActive == true {
                
                user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if error == nil {
                        
                    }
                    else {
                        if let signUpError = error!.userInfo?["error"] as? NSString {
                            self.displayAlert( "Could not sign up", error: signUpError as String )
                        } else {
                            self.displayAlert( "Unkown Error", error: "Please try again later." )
                        }
                    }
                })
            
            } else {
            
               PFUser.logInWithUsernameInBackground(username.text, password: password.text){ (user: PFUser?, error: NSError?) -> Void in
                
                    println(error)
                    if error == nil {
                        println( "User logged in successfully ")
                    } else {
                        // User logged in successfully 
                        if let signInError = error?.userInfo?["error"] as? String {
                        self.displayAlert( "Sign in Error", error:  signInError as String )
                    }
                }
            }
        }
        
        // Hide activity indicator and start receiving events
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
   }
}

