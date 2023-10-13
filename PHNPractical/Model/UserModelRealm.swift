//
//  UserModelRealm.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import Foundation
import RealmSwift

class UserRegistration: Object {
    @Persisted var name : String = ""
    @Persisted var email : String = ""
    @Persisted var password : String = ""
    @Persisted var confirmPassword : String = ""
}

