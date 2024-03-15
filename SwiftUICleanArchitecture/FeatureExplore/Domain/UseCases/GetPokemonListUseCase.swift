//
//  GetPokemonListUseCase.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

class GetPokemonListUseCase{
    let respository: ExploreRepositoryProtocol
    
    init(pokeRespository: ExploreRepositoryProtocol) {
        self.respository = pokeRespository
    }
    
    func execute(limit: Int, offset: Int) async throws -> [PokemonEntity] {
        return try await respository.fetchPokemons(limit: limit, offset: offset)
    }
}
