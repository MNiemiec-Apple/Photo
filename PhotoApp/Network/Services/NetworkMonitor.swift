//
//  NetworkMonitor.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 30/05/2022.
//

import Foundation
import Network

@MainActor
class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    @Published var isNotConnected = false

    init() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        checkConnection()
    }

    private func checkConnection() {
        monitor.pathUpdateHandler = { [self] path in
            DispatchQueue.main.async{ [self] in
                if path.status == .satisfied {
                    print("We're connected!")
                    isNotConnected = false
                } else {
                    print("No connection.")
                    isNotConnected = true
                }
            }
        }
    }

}
