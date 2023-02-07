//
//  LocationTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 06.02.2023.
//

import XCTest
import CoreLocation

@testable import TasksTDD

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testLocation_initName() {
        let location = Location(name: "location_name")
        XCTAssertEqual(location.name, "location_name")
    }
    
    func testLocation_initCoordinates() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 1,
            longitude: 2
        )
        let location = Location(name: "location_name", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
}
