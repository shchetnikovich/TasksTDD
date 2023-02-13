//
//  DetailViewControllerTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 13.02.2023.
//

import XCTest
import CoreLocation
@testable import TasksTDD

final class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    
    //MARK: - Labels Tests
    
    func testDetailView_hasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))  //  Является ли объектом, который находится внутри нашего контроллера
    }
    
    func testDetailView_hasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testDetailView_hasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testDetailView_hasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func testDetailView_hasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    //MARK: - Sets Label Tests
    
    func setupTaskAndAppearanceTransition() {
        let coorinate = CLLocationCoordinate2D(latitude: 59.935855, longitude: 30.304101)
        let location = Location(name: "new_location", coordinate: coorinate)
        let date = Date(timeIntervalSince1970: 1676289286)      //  Количество секунд с 1970
        let task = Task(title: "task_one", date: date, description: "task_description", location: location)
        sut.task = task
        
        sut.beginAppearanceTransition(true, animated: true) //  Имитация срабатывания методов viewWillAppear & viewDidAppear
        sut.endAppearanceTransition()
    }
    
    func testDetailView_setsTitileLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "task_one")
    }
    
    func testDetailView_setsDescriptionLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "task_description")
    }
    
    func testDetailView_setsLocationLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "new_location")
    }
}
