//
//  NewTaskViewControllerTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 13.02.2023.
//

import XCTest
@testable import TasksTDD

final class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!

    override func setUpWithError() throws {
       try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
                                      
    }

    override func tearDownWithError() throws {
       try super.tearDownWithError()
    }

    func testNewTask_HasTitleTextField() {
        XCTAssertTrue(sut.titleTextFiled.isDescendant(of: sut.view))
    }

}
