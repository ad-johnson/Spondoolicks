//
//  Test helper methods to use Core Data.
//
//  Created by Andrew Johnson on 12/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

//import Foundation
import XCTest
import CoreData
@testable import Spondoolicks

class CoreDataManagerMock: CoreDataManager {
    var identifier = ""
    var expectation: XCTestExpectation!
    
    // Work with in-memory
    override func initialiseStack(completion: @escaping () -> () ) {
       let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSInMemoryStoreType
        initialiseStack(storeDescription: storeDescription, completion: completion)
    }

    // Need to ensure that the expectation is fulfilled alongside the block so it
    // needs wrapping as the block is executed asynchronously.
    override func perform(identifier: String, block: @escaping () -> ()) {
        self.identifier = identifier
        super.perform(identifier: identifier) {
            block()
            self.expectation.fulfill()
        }
    }
    
    static func initialiseForTest() -> CoreDataManagerMock {
        let cdm = CoreDataManagerMock()
        cdm.persistentContainer = nil // Drop the SQLite store
        
        let expectation = XCTestExpectation(description: "Wait for Core Data initialisation")
        cdm.initialiseStack { expectation.fulfill() }
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        if cdm.persistentContainer == nil {
            XCTFail("Couldn't set up Core Data Manager for tests.")
        }
        return cdm
    }
}

