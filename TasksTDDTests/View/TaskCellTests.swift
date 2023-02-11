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
