//
//  UserDefaultsHelper.swift
//  Spondoolicks
//
//  Created by Andrew Johnson on 09/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct UserDefaultsHelper {
    struct Properties {
        static let FIRST_USE = "firstUse"
    }
    
    let defaults = UserDefaults.standard
    
    // Use the inverse of the value to match the name otherwise we'd have
    // to set isFirstUse = true when it was no longer first use!!
    var isFirstUse: Bool {
        get {
            return !(defaults.bool(forKey: UserDefaultsHelper.Properties.FIRST_USE))
        }
        set {
            defaults.set(!newValue, forKey: UserDefaultsHelper.Properties.FIRST_USE)
        }
    }
}
