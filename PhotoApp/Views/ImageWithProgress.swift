//
//  ImageWithProgress.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 26/05/2022.
//

import SwiftUI

struct ImageWithProgress: View {
    var url: String = ""
    var size: CGSize = .zero
    @State private var image: UIImage?

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        } else {
            ProgressView()
                .frame(width: size.width, height: size.height)
                .task {
                    await loadImage(at: url)
                }
        }
    }

    private func loadImage(at source: String) async {
        do {
            image = try await UIImage(data: ImageService.shared.loadData(url))
        } catch {
        }
    }
}
