//
//  TaskCellTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 11.02.2023.
//

import XCTest
@testable import TasksTDD

final class TaskCellTests: XCTestCase {
    
    var cell: TaskCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }
    
    override func tearDownWithError() throws {
        cell = nil
        try super.tearDownWithError()
    }
    
    func testCell_hasTitleLable() {
        XCTAssertNotNil(cell.titleLabel)        //  Проверяем что ярлык внутри TaskCell, который отображает название Task'a не равен nil
    }
    
    func testCellHas_titleLabel_inContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))   // Находится ли titleLable внутри view?
    }
    
    func testCell_hasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCell_locationLabel_inContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testCell_hasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCell_dateLabel_inContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func testCell_configureTitle() {
        let task = Task(title: "task_one")
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    func testCell_configureDate() {
        let task = Task(title: "task_one")
        
        cell.configure(withTask: task)
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        
        let date = task.date
        let dateString = df.string(from: date)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    func testCell_configureLocation() {
        let location = Location(name: "Saint-Petersburg")
        let task = Task(title: "task_one", location: location)
        
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
        
    }
    
    func testTask_checkedDone_styleStrikeThrough() {        //  Выполненые задачи должны быть иметь "зачёркнутый" стиль
        let task = Task(title: "task_one")
        cell.configure(withTask: task, done: true)
        
        let attributedString = NSAttributedString(
            string: "task_one",
            attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    }
    
    func testTask_doneTaskDateLabel_equalsNul() {       //  Необязательно хранить дату и локацию у выполненных задач
        let task = Task(title: "task_one")
        cell.configure(withTask: task, done: true)
        
        XCTAssertNil(cell.dateLabel)    //  Проверяем пустой ли лейбл с датой
    }
    
    func testTask_doneTaskLocationLabel_equalsNul() {
        let location = Location(name: "Saint-Petersburg")
        let task = Task(title: "task_one", location: location)
        cell.configure(withTask: task, done: true)
        
        XCTAssertNil(cell.locationLabel)        //  И  с локацией
    }
}

extension TaskCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
