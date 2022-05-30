//
//  ImageService.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 26/05/2022.
//

import Foundation
import SwiftUI

class ImageService {
    static let shared = ImageService()

    func download(url: URL, toFile file: URL) async throws {
        let (location, response) = try await URLSession.shared.download(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw HTTPError.unknown
        }

        try FileManager.default.moveItem(at: location, to: file)
    }

    func loadData(_ fromString: String? = nil, _ fromUrl: URL? = nil) async throws -> Data {
        lazy var url: URL = {
            var _url: URL!
            if let fromString = fromString,
               let url = URL(string: fromString) {
                _url = url
            } else if let url = fromUrl {
                _url = url
            }
            return _url
        }()

        let components = url.pathComponents
        let fileName = "\(components[components.count-1])_\(components[components.count-2])"

        let filePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                fileName,
                isDirectory: false
            )
        
        var data = loadDataFromDisk(filePath)
        if data == nil {
            try await download(url: url, toFile: filePath)
            data = loadDataFromDisk(filePath)
        }
        if let data = data {
            return data
        } else {
            throw HTTPError.unknown
        }
    }

    private func loadDataFromDisk(_ filePath: URL) -> Data? {   
        if let data = try? Data(contentsOf: filePath) {
            return data
        }
        return nil
    }
}
