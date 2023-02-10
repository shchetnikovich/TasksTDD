//
//  DataProviderTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 07.02.2023.
//

import XCTest
@testable import TasksTDD

final class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var tableView: UITableView!
    
    var controller: TaskListViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        
        controller.loadViewIfNeeded()
        
        
        tableView = controller.tableView
        tableView.dataSource = sut
    }
    
    override func tearDownWithError() throws {
        tableView = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testData_numberSections_isTwo() {      //  2 типа "задачи" и "выполненые задачи"
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testData_numberRows_inSectionZero_isTaskCount() {
        sut.taskManager?.add(task: Task(title: "task1"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "task2"))
        
        tableView.reloadData()  //   Перегружаем таблицу
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testData_numberRows_inSectionOne_isDoneTaskCount() {
        sut.taskManager?.add(task: Task(title: "task1"))
        sut.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "task2"))
        sut.taskManager?.checkTask(at: 0)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCell_rowAtIndexPath_returnTaskCell() {
        sut.taskManager?.add(task: Task(title: "task1"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCell_rowAtIndexPath_dequeuedReusable() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
        
        sut.taskManager?.add(task: Task(title: "task1"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
        
        
    }
}

extension DataProviderTests {
    class MockTableView: UITableView {
        var cellIsDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}
