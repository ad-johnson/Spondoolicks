//
//  Facilitates interaction with the Core Data service
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import Foundation

class AddParentWorker {
    func addParent(newPin: String, completion: @escaping (Parent) -> ()) {
        DispatchQueue.main.async {
            CoreDataManager.instance.perform(identifier: "AddParent") {
                let parent = Parent.insertOrUpdate(newPin: newPin)
                completion(parent)
            }
        }
    }
}
