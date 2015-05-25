//
//  Users.swift
//  ParseStarterProject
//
//  Created by Elias Perez on 5/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

struct User {
    var objectId: String
    var obj: PFUser
    
    
    init(object:PFUser){
        self.obj = object
        self.objectId = object.objectId!
    }
    
    
    
    
    
    func countFollowers()-> Int {
    
        var query = PFQuery(className: "Followers")
        query.whereKey("follower", equalTo: self.obj)
        
        return query.countObjects()
        
    }
    
    

}