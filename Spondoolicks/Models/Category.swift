//
//  Core Data entitity Category
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class Category: NSManagedObject {
    // MARK: - Properties
    static let typeKey = "type"
    
    @NSManaged internal(set) var name: String
    @NSManaged internal(set) var currentBalance: Decimal
    @NSManaged internal(set) var transactionLines: Set<TransactionLine>?
    @NSManaged internal(set) var parent: Category?
    @NSManaged internal(set) var children: Set<Category>?
    @NSManaged fileprivate var primitiveType: NSNumber
    
    internal(set) var type: Global.TransactionType {
        get {
            willAccessValue(forKey: Category.typeKey)
            guard let value = Global.TransactionType(rawValue: primitiveType.int16Value) else {
                fatalError("Incorrect Transaction Type passed to Category")
            }
            didAccessValue(forKey: Category.typeKey)
            return value
        }
        set {
            willChangeValue(forKey: Category.typeKey)
            primitiveType = NSNumber(value: newValue.rawValue)
            didChangeValue(forKey: Category.typeKey)
        }
    }
}

