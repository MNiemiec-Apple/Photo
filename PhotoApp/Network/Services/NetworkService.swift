//
//  NetwrokService.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import Foundation

class NetworkService {
}

extension NetworkService: HTTPClient, NetworkProvider {
    func fetchPhotos() async -> [PhotoModel] {
        let result = await sendRequest(endpoint: PhotosEndpoint(), responseModel: [PhotoModel].self)
        switch result {
        case .success(let model):
            return model
        case .failure(_):
            return []
        }
    }
}
