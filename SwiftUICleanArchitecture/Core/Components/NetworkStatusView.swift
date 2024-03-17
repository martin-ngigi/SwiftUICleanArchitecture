//
//  NetworkStatusView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 17/03/2024.
//

import SwiftUI

struct NetworkStatusView: View {
    @ObservedObject var networkInfo = NetworkInfoImpl()
    
    var body: some View {
        VStack {
            if networkInfo.isConnected {
                //Text("Connected to the Internet")
                    //.foregroundColor(.green)
            } else {
                Text("No Internet Connection")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    NetworkStatusView()
}
