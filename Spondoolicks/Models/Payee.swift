//
//  Core Data entitity Payee
//
//  Created by Andrew Johnson on 07/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class Payee: NSManagedObject {
    @NSManaged internal(set) var name: String
    @NSManaged internal(set) var currentBalance: Decimal
    @NSManaged internal(set) var debitTransactions: Set<Transaction>
    @NSManaged internal(set) var creditTransactions: Set<Transaction>
    

}

