import XCTest
@testable import TasksTDD

final class TaskTests: XCTestCase {
    
    func testInitTask_withTitle() {
        let task = Task(title: "task_title")
        XCTAssertNotNil(task)
    }
    
    func testInitTask_withDescription() {
        let task = Task(title: "task_title", description: "task_description")
        XCTAssertNotNil(task)
    }
    
    func testTaskTitle_whenGiven_setsTitle() {
        let task = Task(title: "task_title")
        XCTAssertEqual(task.title, "task_title")
    }
    
    func testTaskDescription_whenGiven_setsDescription() {
        let task = Task(title: "task_title", description: "task_description")
        XCTAssertTrue(task.description == "task_description")
    }
    
    func testTastInits_WithDate() {
        let task = Task(title: "task_title")
        XCTAssertNotNil(task.date)
    }
    
    func testTaskTitle_whenGiven_setsLocation() {
        let location = Location(name: "location_name")
        
        let task = Task(title: "task_title",
                        description: "task_description",
                        location: location)
        XCTAssertEqual(location, task.location)
    }
}
