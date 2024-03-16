//
//  LodingIndicatorView.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 16/03/2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ProgressView()
//            .progressViewStyle(.circular)
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoadingIndicatorView()
}
