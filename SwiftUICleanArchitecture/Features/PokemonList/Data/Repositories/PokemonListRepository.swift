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
    let remotePokemonListDataSource = PokemonListRemoteDataSource()
    let localPokemonListDataSource = PokemonListLocalDataSource()

    
    func fetchFromRemote(limit: Int, offset: Int, modelContext: ModelContext) async -> Result<[PokemonEntity], APIError> {
        
        let pokemonListResponseResult = await remotePokemonListDataSource.fetchPokemons(limit: limit, offset: offset)
        
        switch pokemonListResponseResult {
            case .success(let pokemonListResponse):
                let pokemonResponse: [PokemonResponseModel] = pokemonListResponse.results
                let pokemonEntities: [PokemonEntity] = pokemonResponse.map { pokemon in
                    return PokemonEntity(pokemonResponse: pokemon)!
                }
            
                let fetchDescriptor = FetchDescriptor<PokemonSwiftDTO>()
                let pokemonLists: [PokemonSwiftDTO] = try! modelContext.fetch(fetchDescriptor)
                print("DEBUG: pokemons count before deleting is: \(pokemonLists.count)")
            
                // delete all saved pokemons in db
                for (index, entity) in pokemonLists.enumerated() {
                    print("Id: \(String(describing: entity.id)), Name: \(entity.name)")
                    print("INDEX: \(index)")
                    do{
                        try localPokemonListDataSource.deletePokemon(pokemon: entity, context: modelContext)
                        // or
                        //try localPokemonListDataSource.deletePokemon(pokemon: pokemonLists[index], context: modelContext)
                    }
                    catch{
                        print("DEBUG: Failed to delete with error \(error.localizedDescription)")
                    }
                }
            
                let pokemonLists2: [PokemonSwiftDTO] = try! modelContext.fetch(fetchDescriptor)
                
                print("DEBUG: pokemon count after deleting is: \(pokemonLists2.count)")

                // Save to local SwiftData
                let pokemonSwiftDatas: [PokemonSwiftDTO] = pokemonResponse.map { pokemon in
                    return PokemonSwiftDTO(item: pokemon)
                }
                for entity in pokemonSwiftDatas {
                    do {
                        //insert and save pokemons
//                        modelContext.insert(entity)
//                        try context.save()
                        
//                        let imageData = try Data(contentsOf: URL(string: entity.url)!) // NB: This images have an issue while saving to DB.
                        let imageData = try Data(contentsOf: URL(string: "https://st.depositphotos.com/3336339/4627/i/450/depositphotos_46270609-stock-photo-unique-red-ball-leader.jpg")!)
                        entity.image = imageData
                        try localPokemonListDataSource.createPokemon(pokemon: entity, context: modelContext)
                        //print("DEBUG: Saving Pokemons to local db success. Id: \(String(describing: entity.id)), Name: \(entity.name)")
                    }
                    catch{
                        print("DEBUG: Could not save pokemon to local swift data with error \(error.localizedDescription)")
                        return .failure(.custom("Couldn't save to local storage"))
                    }
                }
                let pokemonLists3: [PokemonSwiftDTO] = try! modelContext.fetch(fetchDescriptor)
                
                print("DEBUG: pokemon count after saving is: \(pokemonLists3.count)")
                return .success(pokemonEntities)
            
            case .failure(let error):
                print("DEBUG: Could not retrieve pokemons from remote with error: \(error.localizedDescription)")
                return .failure(error)
        }
    }
    
    func fetchFromLocalDB(limit: Int, offset: Int, modelContext: ModelContext) -> Result<[PokemonEntity], APIError> {
        do{
            let fetchDescriptor = FetchDescriptor<PokemonSwiftDTO>()
            //let pokemonLists: [PokemonSwiftDTO] = try modelContext.fetch(fetchDescriptor)
            let pokemonLists: [PokemonSwiftDTO] = try localPokemonListDataSource.getPokemonList(fetchDescriptor: fetchDescriptor, context: modelContext)

            
            let pokemonEntities: [PokemonEntity] = pokemonLists.map { pokemon in
                return PokemonEntity(pokemonObject: pokemon)!
                // OR
//                let pokemon : PokemonEntity =  PokemonEntity(id: pokemon.id, name: pokemon.name, imageURL: pokemon.url , image: pokemon.image)
//                print("description \(pokemon.image?.description)")
//                return pokemon
            }
            
            print("DEBUG: Retreieved cached pokemon from local data. Count is \(pokemonEntities.count)")
            return .success(pokemonEntities)
        }
        catch{
            print("DEBUG: Could not retrieve pokemons from local with error: \(error.localizedDescription)")
            return .failure(APIError.custom("\(error.localizedDescription)"))
        }
    }
    
}
