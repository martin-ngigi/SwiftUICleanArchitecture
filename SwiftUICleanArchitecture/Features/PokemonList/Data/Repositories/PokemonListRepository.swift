//
//  ExploreRepository.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation
import SwiftData
import SwiftUI

//class ExploreRepository: ExploreRespo

class PokemonListRepository: PokemonListRepositoryProtocol {
    
    static let shared = PokemonListRepository()
    
    var networkInfo = NetworkInfoImpl()

    //If we have internet, get pokemons from remote data source and also save to local
    // else get pokemons from remote data source
    func fetchPokemons(limit: Int, offset: Int, modelContext: ModelContext) async -> Result<[PokemonEntity], APIError> {
        
        //We have internet, so get pokemons from remote data source and also save to local
        if networkInfo.isConnected {
            let remotePokemonListDataSource = PokemonListRemoteDataSource()
            let pokemonListResponseResult = await remotePokemonListDataSource.fetchPokemons(limit: limit, offset: offset)
            
            switch pokemonListResponseResult {
                case .success(let pokemonListResponse):
                    let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
                    let pokemonEntities: [PokemonEntity] = pokemonResponse.map { pokemon in
                        return PokemonEntity(pokemonResponse: pokemon)!
                    }
                
                    // Save to local SwiftData
                    let pokemonSwiftDatas: [PokemonSwiftDataObject] = pokemonResponse.map { pokemon in
                        return PokemonSwiftDataObject(item: pokemon)
                    }
                    for entity in pokemonSwiftDatas {
                        do {
                            // delete before inserting new ones. This will help conserve storage
                            modelContext.delete(entity)
                            
                            //insert and save pokemons
                            modelContext.insert(entity)
                            try modelContext.save()
                            print("DEBUG: Saving Pokemons to local db success.")
                        }
                        catch{
                            print("DEBUG: Could not save pokemon to local swift data with error \(error.localizedDescription)")
                            return .failure(.custom("Couldn't save to local storage"))
                        }
                    }
                    return .success(pokemonEntities)
                
                case .failure(let error):
                    return .failure(error)
            }
        }
        //We don't have internet, so get from local db
        else {
            do{
                let fetchDescriptor = FetchDescriptor<PokemonSwiftDataObject>()
                
                let pokemonLists: [PokemonSwiftDataObject] = try modelContext.fetch(fetchDescriptor)
                
                let pokemonEntities: [PokemonEntity] = pokemonLists.map { pokemon in
                    return PokemonEntity(pokemonObject: pokemon)!
                }
                
                print("DEBUG: Retreieved cached pokemon from local data. Count is \(pokemonEntities.count)")
                return .success(pokemonEntities)
            }
            catch{
                return .failure(APIError.custom("\(error.localizedDescription)"))
            }
        }
    }
    
    func fetchPokemons2(limit: Int, offset: Int) async throws -> [PokemonEntity] {
        let exploreDataSource = PokemonListRemoteDataSource()
            let pokemonListResponse: PokemonListResponseModel = try await exploreDataSource.fetchPokemons2(limit: limit, offset: offset)
            let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
            let pokemonEntities: [PokemonEntity] = pokemonResponse.compactMap { pokemon in
                return PokemonEntity(pokemonResponse: pokemon)
            }
            return pokemonEntities
    }
    
//    
//    func fetchPokemons2(limit: Int, offset: Int) async throws -> [PokemonEntity] {
//        let pokemonListResponse: PokemonListResponseModel = try await exploreDataSource.fetchPokemons2(limit: limit, offset: offset)
//        let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
//        let pokemonEntities: [PokemonEntity] = pokemonResponse.compactMap { pokemon in
//            return PokemonEntity(pokemonResponse: pokemon)
//        }
//        return pokemonEntities
//    }
    
}
