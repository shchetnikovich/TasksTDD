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
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataProvider()
        sut.taskManager = TaskManager()
        tableView = UITableView()
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
    
    func testData_rowAtIndexPath_returnTaskCell() {
        sut.taskManager?.add(task: Task(title: "task1"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
}
