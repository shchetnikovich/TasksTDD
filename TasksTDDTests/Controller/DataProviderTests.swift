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
        tableView.delegate = sut
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
        sut.taskManager?.add(task: Task(title: "task_one"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "task_two"))
        
        tableView.reloadData()  //   Перегружаем таблицу
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testData_numberRows_inSectionOne_isDoneTaskCount() {
        sut.taskManager?.add(task: Task(title: "task_one"))
        sut.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "task_two"))
        sut.taskManager?.checkTask(at: 0)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCell_rowAtIndexPath_returnTaskCell() {
        sut.taskManager?.add(task: Task(title: "task_one"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCell_rowAtIndexPath_dequeuedReusable() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        sut.taskManager?.add(task: Task(title: "task_one"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    func testCell_rowAtZeroSection_callConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let task = Task(title: "task_one")
        sut.taskManager?.add(task: task)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        
        XCTAssertEqual(cell.task, task)
    }
    
    func testCell_rowAtFirstSection_callConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let taskOne = Task(title: "task_one")
        let taskTwo = Task(title: "task_two")
        sut.taskManager?.add(task: taskOne)
        sut.taskManager?.add(task: taskTwo)
        
        sut.taskManager?.checkTask(at: 0)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(cell.task, taskOne)
    }
    
    func testDeleteButton_titleZero_showsDone() {
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(buttonTitle, "Done")
    }
    
    func testDeleteButton_titleFirst_showsDone() {
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(buttonTitle, "Undone")
    }
    
    func testDeleteButton_checkingTask_checksInTaskManager() {
        let task = Task(title: "task_one")
        sut.taskManager?.add(task: task)
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.taskManager?.taskCount, 0)
        XCTAssertEqual(sut.taskManager?.doneTaskCount, 1)   //  1 - секция
    }
    
    func testDeleteButton_uncheckingTask_unckeksInTaskManager() {
        let task = Task(title: "task_one")
        sut.taskManager?.add(task: task)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.taskManager?.taskCount, 1)
        XCTAssertEqual(sut.taskManager?.doneTaskCount, 0)   //  0 - добавили таск он находился в 0 секции, мы его чекнули он попал в 1 секцию, нажимаем на кнопку delete и он должен упасть обратно в 0 секцию
    }
}

extension DataProviderTests {
    class MockTableView: UITableView {
        var cellIsDequeued = false
        
        static func mockTableView(withDataSource dataSorce: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 375, height: 658), style: .plain)
            mockTableView.dataSource = dataSorce
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell: TaskCell {
        var task: Task?
        
        override func configure(withTask task: Task) {
            self.task = task
        }
    }
}
