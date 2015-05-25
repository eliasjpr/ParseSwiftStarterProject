//
//  Followers.swift
//  ParseStarterProject
//
//  Created by Elias Perez on 5/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

struct Follower {
    let following: PFUser
    let follower: PFUser
    
    
    init( following: PFUser, follower: PFUser){
        self.follower = follower
        self.following = following
    }
    
    init( object: AnyObject ){
        self.follower  = object["follower"] as! PFUser
        self.following = object["following"] as! PFUser
    }
    
    
    static func add( following: PFUser, follower: PFUser)-> Void{
        var follow = PFObject(className: "Followers")
        
        follow["following"] = following
        follow["follower"]  = follower
        
        follow.saveInBackground()
        
       println("Successfully saved \(following.username) followers.")
    }
    
    
    static func remove(following: PFUser, follower: PFUser)-> Void{
        var query = PFQuery(className: "Followers")
        
        query.whereKey("following", equalTo: following)
        query.whereKey("follower", equalTo: follower)
        
        query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully removed \(objects!.count) followers.")
                
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //Delete object in background
                        object.deleteInBackground()
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        })
    }
    
    static func followerExistsForUser( user: PFUser, following: PFUser)-> Bool {
        
        var query = PFQuery(className: "Followers")
        var exists = false
        
        query.whereKey("follower" , equalTo: user)
        query.whereKey("following" , equalTo: following)
        
        var count = query.countObjects()
        
        if count > 0 {
            exists = true
        }

        return exists
    }

   
}

