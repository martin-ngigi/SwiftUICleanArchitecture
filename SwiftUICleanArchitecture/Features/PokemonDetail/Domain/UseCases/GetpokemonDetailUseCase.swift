//
//  GetpokemonDetailUseCase.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

class GetpokemonDetailUseCase{
    let repository: DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> PokemonDetailEntity?{
        guard let pokemonDetail: PokemonDetailEntity = try await repository.fetchPokemonDetail(id: id) else {
            return nil
        }
        return pokemonDetail
    }
}
