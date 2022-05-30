//
//  MockNetworkService.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 30/05/2022.
//

import Foundation

class MockNetworkService {
}

extension MockNetworkService: HTTPClient, NetworkProvider {
    func fetchPhotos() async -> [PhotoModel] {
        guard let photos = JSONHelper.loadJson(filename: "mock_photos", type: [PhotoModel].self) else {
            return []
        }
        return photos
    }
}

struct JSONHelper {
    static func loadJson<T: Decodable>(filename fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
