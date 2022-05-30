//
//  DetailsView.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 18/05/2022.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss

    var fullImageUrl: String = ""
    var body: some View {
        HStack(alignment: .top) {
            ImageWithProgress(
                url: fullImageUrl,
                size: .init(width: 300, height: 300)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Button {
                dismiss()
            } label: {
                Image(systemName: "multiply")
                    .resizable()
            }
            .frame(width: 20, height: 20)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(fullImageUrl: "https://via.placeholder.com/600/771796")
    }
}
