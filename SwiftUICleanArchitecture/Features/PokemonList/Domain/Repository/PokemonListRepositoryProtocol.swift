//
//  ExploreRepositoryProtocol.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation
import SwiftData

protocol PokemonListRepositoryProtocol{
    func fetchFromRemote(limit: Int, offset: Int, modelContext: ModelContext) async -> Result<[PokemonEntity], APIError>
    func fetchFromLocalDB(limit: Int, offset: Int, modelContext: ModelContext) -> Result<[PokemonEntity], APIError>
}
