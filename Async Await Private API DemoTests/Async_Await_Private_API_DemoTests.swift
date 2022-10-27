//
//  Async_Await_Private_API_DemoTests.swift
//  Async Await Private API DemoTests
//
//  Created by Trevor Whittingham on 10/27/22.
//

import XCTest
@testable import Async_Await_Private_API_Demo

final class Async_Await_Private_API_DemoTests: XCTestCase {

    func testPersonAPI() {
        let sut = PrivateStarWarsAPI()
        let exp = expectation(description: "wait for API response")
        sut.loadPeople { result in
            switch result {
            case .success(let personArray):
                print(personArray)
                XCTAssert(personArray.count > 0)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 30) // the API can be slow :]
    }
    
    func testPersonAPIAsync() async throws {
        let sut = AsyncAPI()
        let personArray = try await sut.loadPeopleAsync()
        print(personArray)
        XCTAssert(personArray.count > 0)
    }

}
