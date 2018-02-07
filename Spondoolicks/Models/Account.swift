//
//  Core Data entitity Account
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class Account: NSManagedObject {
    // MARK: - Properties
    static let typeKey = "type"
    
    struct AccountInformation {
        var accountNumber: Int
        var sortCode: Int?
    }
    
    @NSManaged internal(set) var name: String
    @NSManaged internal(set) var currentBalance: Decimal
    @NSManaged internal(set) var user: User
    @NSManaged internal(set) var debitTransactions: Set<Transaction>
    @NSManaged internal(set) var creditTransactions: Set<Transaction>

    @NSManaged fileprivate var accountNumber: NSNumber?
    @NSManaged fileprivate var sortCode: NSNumber?
    @NSManaged fileprivate var primitiveType: NSNumber

    internal(set) var accountInformation: AccountInformation? {
        get {
            guard let accountNumber = accountNumber?.intValue else { return nil }
            let sortCode = self.sortCode.map { $0.intValue }
            return AccountInformation(accountNumber: accountNumber, sortCode: sortCode)
        }
        set {
            guard let accountNumber = accountNumber?.intValue else { return }
            self.accountNumber = NSNumber(value: accountNumber)
            self.sortCode = newValue?.sortCode.map { NSNumber(value: $0) }
        }
    }
    
    internal(set) var type: Global.AccountType {
        get {
            willAccessValue(forKey: Account.typeKey)
            guard let value = Global.AccountType(rawValue: primitiveType.int16Value) else {
                fatalError("Incorrect Account Type passed to Account")
            }
            didAccessValue(forKey: Account.typeKey)
            return value
        }
        set {
            willChangeValue(forKey: Account.typeKey)
            primitiveType = NSNumber(value: newValue.rawValue)
            didChangeValue(forKey: Account.typeKey)
        }
    }
}

