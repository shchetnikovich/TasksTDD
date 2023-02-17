//
//  APIClient.swift
//  TasksTDD
//
//  Created by Anton Shchetnikovich on 17.02.2023.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared //  Слишком тяжелый компонент, поэтому через lazy
    
    func login(withName: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://tasktdd.com/login") else {
            fatalError()
        }
        
        urlSession.dataTask(with: url) { (data, respose, error) in }.resume()
    }
}
