//
//  NetworkInfo.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 17/03/2024.
//

import Foundation
import Network


protocol NetworkInfo {
    var isConnected: Bool { get }
}

class NetworkInfoImpl: NetworkInfo, ObservableObject {
    private let monitor = NWPathMonitor()
    
    @Published var isConnected: Bool = false
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func checkIfInternetIsConnected() async -> Bool {
        return isConnected
    }
}
