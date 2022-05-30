//
//  PhotosDataService.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 26/05/2022.
//

import Foundation

protocol PhotosDataServiceProtocol {
    func fetchPhotos() async -> [PhotoModel]
    func updatePhotosData(_ photos: [PhotoModel])
}

class PhotosDataService {
    private let photoEntityService = PhotoEntityService()

    private func fetchPhotosFromNetwork() async -> [PhotoModel] {
        await NetworkService().fetchPhotos()
    }

    private func fetchPhotosFromDataPersistence() async -> [PhotoModel] {
        await photoEntityService.fetchAll()
    }
}

extension PhotosDataService: PhotosDataServiceProtocol {
    func fetchPhotos() async -> [PhotoModel] {
        var photos = [PhotoModel]()
        photos = await fetchPhotosFromDataPersistence()
        if photos.isEmpty {
            photos = await fetchPhotosFromNetwork()
            photoEntityService.add(photos: photos)
        }
        return photos
    }

    func updatePhotosData(_ photos: [PhotoModel]) {
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            photoEntityService.updateAll(photos)
        }
    }
}
