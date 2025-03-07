//
//  MediumCloneTests.swift
//  MediumCloneTests
//
//  Created by jmlb23 on 11/12/20.
//

import Combine
import CombineExpectations
import XCTest
import os

@testable import MediumClone

class MediumCloneTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() throws {
    let service = ArticleServiceImp()
    let result = service.getFeed(page: 1).record()
    let collect = try wait(for: result.last, timeout: 2, description: "Elements")
    XCTAssert((collect?.articles).orEmpty().count > 1)

  }

}
