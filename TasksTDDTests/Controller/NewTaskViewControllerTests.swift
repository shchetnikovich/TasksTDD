//
//  NewTaskViewControllerTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 13.02.2023.
//

import XCTest
import CoreLocation
import MapKit
@testable import TasksTDD

final class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut.taskManager?.removeAll()
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - IBOutlet Tests
    
    func testNewTask_hasTitleTextField() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasDateTextField() {
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasLocationTextField() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasAddressTextField() {
        XCTAssertTrue(sut.addressTextField.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testNewTask_hasSaveMockGeocoder_convertCoordinatesFromAddress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "13.02.2023")
        
        sut.titleTextField.text = "task_one"
        sut.dateTextField.text = "13.02.2023"
        sut.descriptionTextField.text = "task_description"
        sut.locationTextField.text = "task_location"
        sut.addressTextField.text = "Санкт-Петербург"
        sut.taskManager = TaskManager()
        
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.save()
        
        let coordinate = CLLocationCoordinate2D(latitude: 59.0000000, longitude: 30.0000000)
        let location = Location(name: "task_location", coordinate: coordinate)
        let generatedTask = Task(title: "task_one", date: date, description: "task_description", location: location)
        
        placemark = MockCLPlacemark()
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testNewTask_geocoderFetches_CorrectCoordinates() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Санкт-Петербург"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            let placemark = placemarks?.first
            let location = placemark?.location
            
            guard
                let latitude = location?.coordinate.latitude,
                let longitude = location?.coordinate.longitude else {
                    XCTFail()
                    return
                }
            XCTAssertEqual(latitude, 59.9366713)    //  Текущие координаты при вкл интернете
            XCTAssertEqual(longitude, 30.3150267)
            geocoderAnswer.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)       //  Асинхронный запрос геокодера обязывает подождать опр время
    }
    
    func testSaveButton_hasSaveMethod() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save")) //  actions содержит методы с названием save
    }
}


extension NewTaskViewControllerTests {
    
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
        
    }
    
    class MockCLPlacemark: CLPlacemark {
        let mockCoordinate = CLLocationCoordinate2D(latitude: 59.0000000, longitude: 30.0000000)
        
        init() {
            let mkPlacemark = MKPlacemark(coordinate: mockCoordinate) as CLPlacemark
            super.init(placemark: mkPlacemark)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}
