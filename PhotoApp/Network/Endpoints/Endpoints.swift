//
//  Endpoints.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import Foundation

struct PhotosEndpoint: Endpoint {
    var path: String {
        "photos"
    }

    var method: HTTPMethod {
        .get
    }

    var header: [String : String]? {
        nil
    }

    var body: [String : String]? {
        nil
    }
}
