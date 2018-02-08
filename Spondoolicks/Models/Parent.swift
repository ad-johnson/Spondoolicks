//
//  Core Data Entity Parent
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class Parent: NSManagedObject {
    // MARK: - Properties
    static let pinKey = "pin"
    
    @NSManaged fileprivate var primitivePin: NSNumber?

    internal(set) var pin: Int? {
        get {
            willAccessValue(forKey: Parent.pinKey)
            defer { didAccessValue(forKey: Parent.pinKey) }
            return primitivePin?.intValue
        }
        set {
            willChangeValue(forKey: Parent.pinKey)
            primitivePin = newValue.map { NSNumber(value: Int16($0)) }
            didChangeValue(forKey: Parent.pinKey)
        }
    }
}
