//
//  Convenience functions for interacting wtih Core Data
//
//  Created by Andrew Johnson on 09/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type tried to be inserted.")
        }
        
        return object
    }
    
    func saveOrRollback(_ identifier: String) -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            NotificationCenter.default.post(name: Global.Notifications.CORE_DATA_ROLLBACK,
                object: nil,
                userInfo: [Global.Notifications.UserInfo.identifier: identifier, Global.Notifications.UserInfo.error: error.localizedDescription])
            return false
        }
    }
    
    func performChanges(identifier: String, block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback(identifier)
        }
    }
}
