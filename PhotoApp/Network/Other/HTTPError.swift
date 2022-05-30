//
//  HTTPError.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import Foundation

enum HTTPError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
