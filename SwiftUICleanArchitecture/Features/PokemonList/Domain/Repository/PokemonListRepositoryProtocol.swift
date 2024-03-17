//
//  ExploreRepositoryProtocol.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation
import SwiftData

protocol PokemonListRepositoryProtocol{
    func fetchPokemons(limit: Int, offset: Int, modelContext: ModelContext) async -> Result<[PokemonEntity], APIError>
    func fetchPokemons2(limit: Int, offset: Int) async throws -> [PokemonEntity]
}
