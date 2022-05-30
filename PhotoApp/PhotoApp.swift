//
//  PhotoAppApp.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 17/05/2022.
//

import SwiftUI

@main
struct PhotoApp: App {
    @StateObject var dataProvider = DataProvider()
    @StateObject var networkMonitor: NetworkMonitor

    init() {
        self._networkMonitor = StateObject(wrappedValue: NetworkMonitor())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataProvider)
                .environmentObject(networkMonitor)
        }
    }
}


extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

