//
//  APIClientTests.swift
//  PopularPixTests
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import XCTest
@testable import PopularPix

class APIClientTests: XCTestCase
{
    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopularRequest()
    {
        let e = expectation(description: "Get Popular Images")
        GetPopularImagesService().execute(onSuccess: { (poularImageModel) in
            assert(poularImageModel.currentPage != nil, "Current Page is empty")
            assert(poularImageModel.totalPages != nil, "total pages is empty")
            e.fulfill()
        }) { (error) in
            assertionFailure("There is an error: \(error)")
            e.fulfill()
        }
        
        wait(for: [e], timeout: 5.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
