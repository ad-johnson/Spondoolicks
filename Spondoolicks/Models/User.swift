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
    @NSManaged internal(set) var name: String
    @NSManaged internal(set) var avatarImage: String
    @NSManaged internal(set) var accounts: Set<Account>
    @NSManaged internal(set) var pin: String?
}
