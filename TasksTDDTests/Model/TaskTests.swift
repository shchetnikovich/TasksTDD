import XCTest
@testable import TasksTDD

final class TaskTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testInitTask_withTitle() {
        let task = Task(title: "task_title")
        XCTAssertNotNil(task)
    }
    
    func testTastInits_WithDate() {
        let task = Task(title: "task_title")
        XCTAssertNotNil(task.date)
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
    
    func testTaskTitle_whenGiven_setsLocation() {
        let location = Location(name: "location_name")
        
        let task = Task(title: "task_title",
                        description: "task_description",
                        location: location)
        XCTAssertEqual(location, task.location)
    }
}
