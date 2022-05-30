//
//  ItemView.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 18/05/2022.
//

import SwiftUI

struct ItemView: View {
    @State private var showingSheet = false

    var title: String = ""
    var url: String = ""
    var thumbnailUrl: String = ""

    var body: some View {
        VStack {
            HStack {
                ImageWithProgress(
                    url: thumbnailUrl,
                    size: .init(width: 128, height: 128)
                )
                Text(title)
                Spacer()
            }
            Color(.white)
                .frame(height: 1)
        }
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            DetailsView(fullImageUrl: url)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(title: "title", thumbnailUrl: "https://via.placeholder.com/150/771796")
    }
}
