//
// Standardises and simplifies Managed Object interaction
//
//  Created by Andrew Johnson on 09/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import CoreData

protocol Managed: AnyObject, NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    static var context: NSManagedObjectContext { get }
}
// MARK: - Convenience accessors
extension Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
    static var context: NSManagedObjectContext {
        return CoreDataManager.instance.privateManagedContext()
    }
}

extension Managed where Self: NSManagedObject {
    static var entityName: String {
        return entity().name!
    }
}

// MARK: - Convenience finders
extension Managed where Self: NSManagedObject {
    static func findOrCreate(matching predicate: NSPredicate, configure: (Self) -> ()) -> Self {
        guard let object = findOrFetch(matching: predicate) else {
            let newObject: Self = context.insertObject()
            configure(newObject)
            return newObject
        }
        return object
    }
    
    static func findOrFetch(matching predicate: NSPredicate) -> Self? {
        guard let object = materialisedObject(matching: predicate) else {
            return fetch() { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
            }.first
        }
        return object
    }

    static func materialisedObject(matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }

    static func fetchAll(matching predicate: NSPredicate) -> [Self]? {
            return fetch() { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
            }
    }

    static func fetch(configurationBlock: (NSFetchRequest<Self>) -> () = {_ in}) -> [Self] {
        let request = Self.sortedFetchRequest
        configurationBlock(request)
        return try! context.fetch(request)
    }
}
