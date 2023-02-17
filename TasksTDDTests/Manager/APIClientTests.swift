//
//  APIClientTests.swift
//  TasksTDDTests
//
//  Created by Anton Shchetnikovich on 17.02.2023.
//

import XCTest
@testable import TasksTDD

final class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockURLSession = MockURLSession()
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func userLogin() {
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "user_name", password: "12345", completionHandler: completionHandler)
    }

    func testAPIClent_whenLogin_usesCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "tasktdd.com")
    }
    
    func testAPIClient_whenLogin_usesCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }

}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?

        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
