//
//  User.swift
//  Patisseria
//
//  Created by Alesson Abao on 5/05/23.
//

import Foundation

// user info to be saved
class Users: NSObject, NSCoding
{
    func encode(with coder: NSCoder) {
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(birthdate, forKey: "birthdate")
        coder.encode(email, forKey: "email")
        coder.encode(password, forKey: "password")
    }
    
    required init?(coder: NSCoder) {
        firstName = coder.decodeObject(forKey: "firstName") as! String
        lastName = coder.decodeObject(forKey: "lastName") as! String
        birthdate = coder.decodeObject(forKey: "birthdate") as! String
        email = coder.decodeObject(forKey: "email") as! String
        password = coder.decodeObject(forKey: "password") as! String
    }
    
    // variables for user we want to store
    var firstName : String
    var lastName : String
    var birthdate : String
    var email : String
    var password : String
    
    // constructor so values doesn't become nil
    init(firstName: String, lastName: String, birthdate: String, email: String,  password: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.email = email
        self.password = password
    }
}
