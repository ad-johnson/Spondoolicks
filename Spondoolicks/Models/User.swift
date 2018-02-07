//
//  Core Data entitity User
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    // MARK: - Properties
    static let pinKey = "pin"
    
    @NSManaged internal(set) var name: String
    @NSManaged internal(set) var avatarImage: String
    @NSManaged internal(set) var accounts: Set<Account>
    @NSManaged fileprivate var primitivePin: NSNumber?
    
    internal(set) var pin: Int? {
        get {
            willAccessValue(forKey: User.pinKey)
            let value: Int? = primitivePin.map { $0.intValue }
            didAccessValue(forKey: User.pinKey)
            return value
        }
        set {
            willChangeValue(forKey: User.pinKey)
            primitivePin = newValue.map { NSNumber(value: Int16($0)) }
            didChangeValue(forKey: User.pinKey)
        }
    }
}
