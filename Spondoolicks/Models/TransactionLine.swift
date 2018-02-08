//
//  Core Data entitity TransactionLine
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class TransactionLine: NSManagedObject {
    // Mark: Properties
    
    @NSManaged internal(set) var amount: Decimal
    @NSManaged internal(set) var transaction: Transaction
    @NSManaged internal(set) var category: Category?
}

