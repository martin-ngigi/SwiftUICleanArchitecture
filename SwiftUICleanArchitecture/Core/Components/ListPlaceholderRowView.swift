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
    let mIsInternetConnected: Bool
    
    let mState: FetchState
//    let loadMore: () -> Void // sync
    let loadMore: (_ modelContext: ModelContext, _ isInternetConnected: Bool) async -> Void // Asynchronous loadMore parameter

//    init(state: FetchState, context: ModelContext, netConnected: Bool, loadMore: @escaping  (_ modelContext: ModelContext) async -> Void) { // Asynchronous loadMore parameter
//        self.state = state
//        self.loadMore = loadMore
//        self.mContext = context
//        self.mIsInternetConnected = netConnected
//       }
    init(modelContext: ModelContext, isInternetConnected: Bool, state: FetchState, loadMore: @escaping (_: ModelContext, _: Bool) async -> Void) {
        self.mContext = modelContext
        self.mIsInternetConnected = isInternetConnected
        self.mState = state
        self.loadMore = loadMore
    }
    
    var body: some View {
        switch mState {
        case .good:
            Color.clear
                .onAppear {
//                    loadMore() // sync
                    Task { await loadMore(mContext, mIsInternetConnected) }
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
