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
    @NSManaged internal(set) var pin: String?
    static let predicate = NSPredicate(format: "TRUEPREDICATE")
}

extension Parent: Managed {

    static func insertOrUpdate(newPin: String?) -> Parent {
        
        if let parent = findOrFetch(matching: predicate) {
            parent.pin = newPin
           return parent
        } else {
            return insert(newPin: newPin)
        }
    }

    static func insert(newPin: String?) -> Parent {
        let parent: Parent = context.insertObject()
        parent.pin = newPin
        return parent
    }
    
    static func findOrCreate(for pin: String?) -> Parent {
        let parent = findOrCreate(matching: predicate) { $0.pin = pin }
        return parent
    }
}
