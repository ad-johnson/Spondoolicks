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
    static let predicate = NSPredicate(format: "TRUEPREDICATE")

}

extension User: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key:#keyPath(name), ascending: true)]
    }
    
    static func findUsers() -> [User] {
        guard let users = findOrFetchAll(matching: predicate) else {
            return []
        }
        return users
    }
    
    static func delete(_ user: User) -> Bool {
        return context.deleteObject(user)
    }

    static func insert(name: String, avatarImage: String) -> User {
        let user: User = context.insertObject()
        user.name = name
        user.avatarImage = avatarImage
        return user
    }
}
