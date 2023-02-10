//
//  TaskManagerTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 07.02.2023.
//

import XCTest
@testable import TasksTDD

final class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TaskManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testTaskManager_initWithZeroTask() {
        XCTAssertEqual(sut.taskCount, 0)
    }
    
    func testTaskManager_initWithZeroDoneTask() {
        XCTAssertEqual(sut.doneTaskCount, 0)
    }
    
    
    func testTaskManager_addTask_incrementCount() {
        let task = Task(title: "task_one")
        sut.add(task: task)
        
        XCTAssertEqual(sut.taskCount, 1)
    }
    
    func testTaskManager_addTask_atIndexTask() {
        let task = Task(title: "task_one")
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    func testTaskManager_checkTask_atIndexCounts() {
        let task = Task(title: "task_one")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.taskCount, 0)
        XCTAssertEqual(sut.doneTaskCount, 1)
    }
    
    func testTaskManager_checkedTask_removedFromTasks() {
        let firstTask = Task(title: "task_one")
        let secondTask = Task(title: "task_two")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    func testTaskManager_doneTask_returnsCheckedTask() {
        let task = Task(title: "task_one")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    func testTaskManager_removeAllResults_countsBeZero() {
        sut.add(task: Task(title: "task_one"))
        sut.add(task: Task(title: "task_two"))
        
        sut.checkTask(at: 0)
        sut.removeAll()
        
        XCTAssertTrue(sut.taskCount == 0)
        XCTAssertTrue(sut.doneTaskCount == 0)
    }
    
    func testTaskManager_addTask_sameObjectDoesNotIncrementCount() {
        sut.add(task: Task(title: "task_one"))
        sut.add(task: Task(title: "task_one"))
        
        XCTAssertTrue(sut.taskCount == 1)
    }
    
}
