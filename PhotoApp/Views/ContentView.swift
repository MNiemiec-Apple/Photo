//
//  ContentView.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var photos: [PhotoModel] = []
    @EnvironmentObject var dataProvider: DataProvider
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @Environment(\.editMode) private var editMode
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack(alignment: .trailing) {
            if photos.isEmpty {
                ProgressView()
                    .task {
                        photos = await dataProvider.fetchPhotos()
                    }
            } else {
                EditButton()
                    .padding(.trailing, 16)
                List {
                    ForEach(photos) { item in
                        ItemView(
                            title: item.title,
                            url: item.url,
                            thumbnailUrl: item.thumbnailUrl
                        )
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .padding(.bottom, 1)
                    .onChange(of: editMode!.wrappedValue, perform: { value in
                        if !value.isEditing {
                            dataProvider.udpateAll(photos)
                        }
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
        .alert("alert.mode.offline.title".localized(), isPresented: $networkMonitor.isNotConnected) {
            Button("alert.action.ok".localized(), role: .cancel) {
            }
        } message : {
            Text("alert.mode.offline.message".localized())
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active &&
                !networkMonitor.isNotConnected {
                Task {
                    if photos.isEmpty {
                        photos = await dataProvider.fetchPhotos()
                    }
                }
            }
        }
    }

    func delete(index: IndexSet) {
        photos.remove(atOffsets: index)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        photos.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
