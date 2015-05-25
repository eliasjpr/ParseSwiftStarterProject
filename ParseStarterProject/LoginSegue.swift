//
//  LoginSegue.swift
//  ParseStarterProject
//
//  Created by Elias Perez on 5/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class LoginSegue: UIStoryboardSegue {
   
    override func perform() {
        let destination = self.destinationViewController as! UIViewController
        
        self.sourceViewController.presentViewController(destination, animated: true, completion: nil)
    }
    
    
    
}
