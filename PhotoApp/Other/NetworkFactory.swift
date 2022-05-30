//
//  NetworkFactory.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 30/05/2022.
//

import Foundation


protocol NetworkProvider {
    func fetchPhotos() async -> [PhotoModel]
}

protocol NetworkFactory {
    func createNetworkService() -> NetworkProvider
}

class OnlineDataProviderFactory: NetworkFactory {
    @MainActor func createNetworkService() -> NetworkProvider {
        NetworkService()
    }
}

class OfflineDataProviderFactory: NetworkFactory {
    func createNetworkService() -> NetworkProvider {
        MockNetworkService()
    }
}
