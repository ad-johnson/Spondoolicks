//
//  Created by Andrew Johnson on 14/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import CoreData
import XCTest
@testable import Spondoolicks

extension CoreDataManagerMock {
    func addUsersForTest() -> [User] {
        let expectation = XCTestExpectation(description: "Wait for Test Data initialisation")
        var users: [User] = []
        
        self.expectation = XCTestExpectation(description: "Wait for Test Data")
        perform(identifier: "AddUser", block: {
            let user = User.insert(name: "Andrew", avatarImage: "Image1")
            users.append(user)
        })
        self.expectation = XCTestExpectation(description: "Wait for Test Data")
        perform(identifier: "AddUser", block: {
            let user = User.insert(name: "Katherine", avatarImage: "Image2")
            users.append(user)
        })
        self.expectation = XCTestExpectation(description: "Wait for Test Data")
        perform(identifier: "AddUser", block: {
            let user = User.insert(name: "Jason", avatarImage: "Image3")
            users.append(user)
            expectation.fulfill()
        })
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        if users.count != 3 {
            XCTFail("Did not create the right number of test users: \(users.count)")
        }
        return users
    }
    
    func deleteUsersForTest() {
        var users: [User]!
        self.expectation = XCTestExpectation(description: "Wait for Test Data")
        perform(identifier: "FindUser", block: {
            users = User.findUsers()
        })
        let _ = XCTWaiter.wait(for: [self.expectation], timeout: 5)
        for user in users {
            self.expectation = XCTestExpectation(description: "Wait for Test Data")
            perform(identifier: "DeleteUser", block: {
                let _ = User.delete(user)
            })
            let _ = XCTWaiter.wait(for: [self.expectation], timeout: 5)
        }
    }
}

