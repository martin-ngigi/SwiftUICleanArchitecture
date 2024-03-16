//
//  FetchState.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 16/03/2024.
//

import Foundation

enum FetchState: Comparable{
    case good
    case isLoading
    case noResults
    case error(String)
}
