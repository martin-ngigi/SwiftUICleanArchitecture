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
    
    func executeRemote(limit: Int, offset: Int, modelContext: ModelContext) async throws -> Result<[PokemonEntity], APIError> {
        return await respository.fetchFromRemote(limit: limit, offset: offset, modelContext: modelContext)
    }
    
    func executeLocalData(limit: Int, offset: Int, modelContext: ModelContext) -> Result<[PokemonEntity], APIError> {
        return respository.fetchFromLocalDB(limit: limit, offset: offset, modelContext: modelContext)
    }
}
