//
//  GetPokemonListUseCase.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation
import SwiftData

class GetPokemonListUseCase{
    let respository: PokemonListRepositoryProtocol
    
    init(pokeRespository: PokemonListRepositoryProtocol) {
        self.respository = pokeRespository
    }
    
    func execute(limit: Int, offset: Int, modelContext: ModelContext) async throws -> Result<[PokemonEntity], APIError> {
        return await respository.fetchPokemons(limit: limit, offset: offset, modelContext: modelContext)
    }
    
    func execute2(limit: Int, offset: Int) async throws -> [PokemonEntity] {
        return try await respository.fetchPokemons2(limit: limit, offset: offset)
    }
}
