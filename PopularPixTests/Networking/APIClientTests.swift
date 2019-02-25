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
    var service = GetPopularImagesService()

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopularRequestIsNotEmpty()
    {
        let e = expectation(description: "Get Popular Images")
        self.service.execute(onSuccess: { (poularImageModel) in
            assert(poularImageModel.currentPage > 0, "Current Page is empty")
            assert(poularImageModel.totalPages > 0 , "total pages is empty")
            e.fulfill()
        }) { (error) in
            assertionFailure("There is an error: \(error)")
            e.fulfill()
        }
        
        wait(for: [e], timeout: 5.0)
    }
    
    func testPopularRequestChangesPageNumber()
    {
        let e = expectation(description: "Get Popular Images")
        self.service.update(pageNumber: 2)
        self.service.execute(onSuccess: { (poularImageModel) in
            assert(poularImageModel.currentPage > 1, "Current Page is not updating")
            e.fulfill()
        }) { (error) in
            assertionFailure("There is an error: \(error)")
            e.fulfill()
        }
        
        wait(for: [e], timeout: 5.0)
    }
    
    func testPopularImagesRequestForAtLeastOnePhotosModel()
    {
        let e = expectation(description: "Get Popular Images")
        self.service.update(pageNumber: 1)
        self.service.execute(onSuccess: { (poularImageModel) in
            assert(poularImageModel.currentPage == 1, "Current Page is not updating")
            assert(poularImageModel.photos.count > 0, "photos model is empty")
            assert(poularImageModel.photos.first?.user?.avatars?.small?.https != nil, "Could not get the small image url for the user")
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
