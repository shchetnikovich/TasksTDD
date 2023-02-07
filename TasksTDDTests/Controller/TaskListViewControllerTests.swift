//
//  TaskListViewController.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 07.02.2023.
//

import XCTest
@testable import TasksTDD

final class TaskListViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
       
    }
    
    func testTableView_notNil_viewIsLoaded() {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        let sut = vc as! TaskListViewController
        
        _ = sut.view // sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
    }

}
