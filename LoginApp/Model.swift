//
//  Model.swift
//  LoginApp
//
//  Created by Ángel González on 18/03/22.
//

import Foundation

struct Account {
    var user: String
    var pass: String
}
    
struct Registered {
  let user1: Account = Account(user: "ricardo@bedu.org", pass: "Password10")
}
