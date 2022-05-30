//
//  Endpoint.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        guard let filePath = Bundle.main.path(forResource: "API-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: "BASE_URL") as? String else
        {
            fatalError("Couldn't find file 'API-Info.plist'.")
        }
        return value
    }
}
