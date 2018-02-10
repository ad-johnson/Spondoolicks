//
//  Model structures for Add Parent
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

enum AddParent {
    // MARK: - Use cases
    enum AddParent {
        struct Request {
            let newPin: String
        }
        struct Response {
            let parent: Parent
        }
        struct ViewModel { }
    }
}
