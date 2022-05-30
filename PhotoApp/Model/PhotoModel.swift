//
//  PhotoModel.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import Foundation

class PhotoModel: Codable, Identifiable {
    var albumId = 0
    var id = 0
    var title = ""
    var url = ""
    var thumbnailUrl = ""

    init(entity: PhotoEntity) {
        albumId = Int(entity.albumId)
        id = Int(entity.identifier)
        title = entity.title ?? ""
        url = entity.url ?? ""
        thumbnailUrl = entity.thumbnailUrl ?? ""
    }
}
