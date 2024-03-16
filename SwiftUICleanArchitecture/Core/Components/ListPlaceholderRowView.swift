//
//  ListPlaceholderRowView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 16/03/2024.
//

import SwiftUI

struct ListPlaceholderRowView: View {
    
    let state: FetchState
//    let loadMore: () -> Void // sync
    let loadMore: () async -> Void // Asynchronous loadMore parameter

    init(state: FetchState, loadMore: @escaping () async -> Void) { // Asynchronous loadMore parameter
           self.state = state
           self.loadMore = loadMore
       }
    
    var body: some View {
        switch state {
        case .good:
            Color.clear
                .onAppear {
//                    loadMore() // sync
                    Task { await loadMore() }
                }
        case .isLoading:
            LoadingIndicatorView()
        case .noResults:
            Text("Sorry, could not load more")
        case .error(let message):
            Text(message)
                .foregroundStyle(.red)
        }
    }
}



#Preview {
    //    ListPlaceholderRowView(state: .noResults, loadMore: {} ) // sync
    ListPlaceholderRowView(state: .noResults, loadMore: {
        // Simulate an asynchronous operation here
        Task { try? await Task.sleep(nanoseconds: 2_000_000_000) } // Simulating a 2-second delay
    })
}
