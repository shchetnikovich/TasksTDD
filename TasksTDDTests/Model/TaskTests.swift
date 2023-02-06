import XCTest
@testable import TasksTDD

final class TaskTests: XCTestCase {
    
    func testInitTask_withTitle() {
        let task = Task(title: "title")
        XCTAssertNotNil(task)
    }
    
    func testInitTask_withDescription() {
        let task = Task(title: "title", description: "description")
        XCTAssertNotNil(task)
    }
    
    func testTaskTitle_whenGiven_setsTitle() {
        let task = Task(title: "title")
        XCTAssertEqual(task.title, "title")
    }
    
    func testTaskDescription_whenGiven_setsDescription() {
        let task = Task(title: "title", description: "description")
        XCTAssertTrue(task.description == "description")
    }
    
    func testTastInits_WithDate() {
        let task = Task(title: "title")
        XCTAssertNotNil(task.date)
    }
}
