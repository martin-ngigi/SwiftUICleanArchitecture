//
//  ListPlaceholderRowView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 16/03/2024.
//

import SwiftUI
import SwiftData

struct ListPlaceholderRowView: View {
    
    let mContext: ModelContext
    
    let state: FetchState
//    let loadMore: () -> Void // sync
    let loadMore: (_ modelContext: ModelContext) async -> Void // Asynchronous loadMore parameter

    init(state: FetchState, context: ModelContext,  loadMore: @escaping  (_ modelContext: ModelContext) async -> Void) { // Asynchronous loadMore parameter
        self.state = state
        self.loadMore = loadMore
        self.mContext = context
       }
    
    var body: some View {
        switch state {
        case .good:
            Color.clear
                .onAppear {
//                    loadMore() // sync
                    Task { await loadMore(mContext) }
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



//#Preview {
//    //    ListPlaceholderRowView(state: .noResults, loadMore: {} ) // sync
//    ListPlaceholderRowView(state: .noResults, loadMore: {
//        // Simulate an asynchronous operation here
//        Task { try? await Task.sleep(nanoseconds: 2_000_000_000) } // Simulating a 2-second delay
//    })
//}
