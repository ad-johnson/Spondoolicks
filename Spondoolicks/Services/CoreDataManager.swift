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
    
    private let modelName: String
    private var persistentContainer: NSPersistentContainer!
    
    // Mark: Initialisers
   
    convenience init() {
        self.init(Global.Identifier.Name.MODEL_NAME)
    }
    
    init(_ modelName: String) {
        self.modelName = modelName
    }
    
    func initialiseStack(completion: @escaping () -> () ) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Could not initialise the Core Data Stack: \(error!)") }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
