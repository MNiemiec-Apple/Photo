//
//  DataProvider.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 18/05/2022.
//

import Foundation

protocol DataProviderProtocol {
    func fetchPhotos() async -> [PhotoModel]
    func udpateAll(_ photos: [PhotoModel])
}

class DataProvider: ObservableObject {

    private let photosDataService = PhotosDataService()

    var photos: [PhotoModel] = []

    var requestInProcess = false
}

extension DataProvider: DataProviderProtocol {
    func fetchPhotos() async -> [PhotoModel] {
        var photos = [PhotoModel]()
        if !requestInProcess {
            requestInProcess = true
            photos = await photosDataService.fetchPhotos()
            requestInProcess = false
        }
        return photos
    }

    func udpateAll(_ photos: [PhotoModel]){
        photosDataService.updatePhotosData(photos)
    }
}
