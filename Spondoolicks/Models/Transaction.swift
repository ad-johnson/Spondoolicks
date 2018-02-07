//
//  Core Data entitity Transaction
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class Transaction: NSManagedObject {
    // MARK: - Properties
    static let typeKey = "type"
    
    @NSManaged internal(set) var transactionDate: Date
    @NSManaged internal(set) var totalAmount: Decimal
    @NSManaged internal(set) var reconciled: Bool
    @NSManaged internal(set) var note: String?
    
    @NSManaged fileprivate var primitiveType: NSNumber
    
    internal(set) var type: Global.TransactionType {
        get {
            willAccessValue(forKey: Transaction.typeKey)
            guard let value = Global.TransactionType(rawValue: primitiveType.int16Value) else {
                fatalError("Incorrect Transaction Type passed to Category")
            }
            didAccessValue(forKey: Transaction.typeKey)
            return value
        }
        set {
            willChangeValue(forKey: Transaction.typeKey)
            primitiveType = NSNumber(value: newValue.rawValue)
            didChangeValue(forKey: Transaction.typeKey)
        }
    }
}
