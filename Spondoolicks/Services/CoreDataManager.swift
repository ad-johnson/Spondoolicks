//
//  Handles all interactions with Core Data
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    // Mark: Properties
    static let instance = CoreDataManager()
    
    let modelName: String
    var persistentContainer: NSPersistentContainer!
    
    // Mark: Initialisers
   
    convenience init() {
        self.init(Global.Identifier.Name.MODEL_NAME)
    }
    
    init(_ modelName: String) {
        self.modelName = modelName
    }
    
    // Default Core Data use is SQLite based.
    func initialiseStack(completion: @escaping () -> () ) {
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSSQLiteStoreType
        initialiseStack(storeDescription: storeDescription, completion: completion)
    }
    
    func initialiseStack(storeDescription: NSPersistentStoreDescription, completion: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Could not initialise the Core Data Stack: \(error!)") }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func privateManagedContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func perform(identifier: String, block: @escaping () -> ()) {
        privateManagedContext().performChanges(identifier: identifier, block: block)
    }
}
